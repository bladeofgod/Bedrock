// import 'dart:async';
// import 'dart:collection';
// import 'dart:math' as math;
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/rendering.dart';
// import 'package:riki/api/base_api.dart';
// import 'package:riki/api/construction/online_watcher_api.dart';
// import 'package:riki/entity/construction/online_watcher_progress_entity.dart';
//
// import '../build_progress_page.dart';
//
// /// 作者：李佳奇
// /// 日期：2021/2/27
// /// 备注：
//
// // class PageDataForAutoPlay{
// //   ///第几个item的视频可以播放也关联此
// //   int currentIndex;
// // }
//
// class BuildProgressPageVM extends SingleViewStateModel<OnlineWatcherProgressEntity> {
//
//   final BuildProgressPageArgs args;
//
//   // BuildProgressPageVM(){
//   //   initListeners();
//   // }
//
//   ///获取施工进度总览
//   OnlineWatcherApi onlineWatcherApi;
//
//   BuildProgressPageVM(this.args);
//
//   initApi() {
//     onlineWatcherApi = OnlineWatcherApi(context);
//   }
//
//   final ScrollController scrollController = ScrollController();
//
//   ///保存 mounted item
//   /// * 用于垂直列表
//   /// * 理论上length 不会过长
//   List<int> unMountedList;
//
//   ///保存 顶部水平 tabs
//   final SplayTreeMap<int, BuildContext> tabsChildCtx = SplayTreeMap<int, BuildContext>();
//
//   void saveOrUpdateTabsCtx(int index, BuildContext ctx) {
//     //tabsChildCtx[index] = ctx;
//     tabsChildCtx.update(index, (value) => ctx,ifAbsent: ()=>ctx);
//   }
//
//   ///保存 施工阶段 <垂直列表>
//   final SplayTreeMap<int, BuildContext> childCtx = SplayTreeMap<int, BuildContext>();
//
//   final SplayTreeMap<int, double> itemOffsetY = SplayTreeMap<int, double>();
//
//   void saveOrUpdateContext(int index, BuildContext ctx) {
//     //childCtx[index] = ctx;
//     childCtx.update(index, (value) => ctx ,ifAbsent: ()=>ctx);
//   }
//
//   ///更新 存活列表
//   /// * 应该还有优化的余地
//   void updateUnMountedList() {
//     unMountedList = childCtx.entries
//         .where((ctx) {
//           StatefulElement ele = ctx.value as StatefulElement;
//           return (ele?.state?.mounted) ?? false;
//         })
//         .map<int>((e) => e.key)
//         .toList();
//   }
//
//   ///返回当前垂直列表 在屏的index
//   int currentIndexOnScreen() {
//     if (unMountedList == null || unMountedList.isEmpty) return 0;
//     if (scrollController.position.pixels == scrollController.position.minScrollExtent) {
//       //head pos
//       return unMountedList.first;
//     } else if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
//       //tail pos
//       return unMountedList.last;
//     }
//     final double scrollPos = scrollController.position.pixels;
//     //collect
//     collectVerticalItemHeight();
//
//     for (int i = 0; i < unMountedList.length - 1; i++) {
//       final int ctxIndex = unMountedList[i];
//       if ((itemOffsetY[ctxIndex] - scrollPos).abs() < 20) {
//         return unMountedList[i];
//       }
//     }
//     //容灾
//     return currentItemIndex;
//
//     // if(unMountedList == null){
//     //   return 0;
//     // }else {
//     //   if(unMountedList.length <= 2){
//     //     return unMountedList.first;
//     //   }else{
//     //     return unMountedList.first + 1;
//     //   }
//     // }
//   }
//
//   ///收集垂直列表高度
//   /// * 此方法由滚动跳动，即绘制完成后
//
//   void collectVerticalItemHeight() {
//     final minScrollExtent = scrollController.position.minScrollExtent;
//     final maxScrollExtent = scrollController.position.maxScrollExtent;
//     unMountedList.forEach((live) {
//       //理论上这里的高度不会变化
//       //如果变化，可能需要再调整
//       if (itemOffsetY.containsKey(live)) return;
//       final BuildContext ctx = childCtx[live];
//       final RenderObject renderObject = ctx.findRenderObject();
//       final RenderAbstractViewport viewport = RenderAbstractViewport.of(renderObject);
//       //后期alignmentPolicy 变化 需要再处理
//       final double target = viewport.getOffsetToReveal(renderObject, 0.0).offset.clamp(minScrollExtent, maxScrollExtent) as double;
//       itemOffsetY[live] = target;
//     });
//   }
//
//   // List<String> tabs = ['砌墙施工','砌墙施工','砌墙施工','砌墙施工',
//   //   '砌墙施工','砌墙施工','砌墙施工','砌墙施工','砌墙施工','砌墙施工','砌墙施工','砌墙施工'];
//
//   ///选择了第几个tab
//   int selectTabIndex = 0;
//
//   /// 点击tab时 驱动垂直列表
//   /// 点击tab时，在垂直列表滚动完成前 都应该是true
//   /// * [isTapAnimateList] = true  屏蔽 [scrollController]的监听
//   /// * 函数处理并不保险
//   bool isTapAnimateList = false;
//
//   ///点击时
//   void tapTab(int index) async {
//     jumpToItem(index);
//     selectTabIndex = index;
//     notifyListeners(refreshVM: false);
//     await Scrollable.ensureVisible(tabsChildCtx[index],duration: Duration(milliseconds: 500),alignment: 0.5);
//   }
//
//   ///长距离滚动过程中，中间卡片不加载真实布局
//   bool cardIsScrolling = false;
//   void updateCardScrollStatus(bool status) {
//     cardIsScrolling = status;
//     notifyListeners();
//   }
//
//   ///tab 滚动时间
//   int tabsScrollDuration = 300;
//
//   ///滑动垂直list 驱动tabs滚动
//   /// * tabs正在滚动时，不响应其它滚动事件
//   bool isScrollAnimateTabs = false;
//
//   ///list 当前滚动的位置
//   /// * 目前用于确定那个视频播放
//   /// * 第几个item的视频可以播放也关联此
//
//   int currentItemIndex = 0;
//
//   ///垂直列表滚动时切换上方tabs
//   void updateTabs() {
//     if (isScrollAnimateTabs) return;
//     currentItemIndex = currentIndexOnScreen();
//     //debugPrint('scroll tabs--- $selectTabIndex === $currentItemIndex');
//     if (selectTabIndex == currentItemIndex) return;
//     selectTabIndex = currentItemIndex;
//     final ctx = tabsChildCtx[currentItemIndex];
//     if (ctx != null) {
//       isScrollAnimateTabs = true;
//       Scrollable.ensureVisible(tabsChildCtx[currentItemIndex], duration: Duration(milliseconds: tabsScrollDuration));
//     }
//     isScrollAnimateTabs = false;
//     notifyListeners();
//   }
//
//   ///滚动 横向 tabs
//   void animateTabsList() {}
//
//   int scrollDuration = 500;
//
//   ///用于分片滚动时间
//   final int standardSingleTime = 80;
//
//   /// 根据fps和测试，[standardSingleTime]最小值最好保证在100ms以上
//   /// * 测试用机 三星 s6
//   /// * 中高端机型，应该可以压缩这个值
//
//   ///每一张卡片滚动所耗时间
//   final int onCardScrollDuration = 16*8;
//
//   ///滚动到第[index]施工进度卡片
//   void jumpToItem(int index) async {
//     final int dis = (index - selectTabIndex).abs();
//     if (dis == 0) return;
//
//     isTapAnimateList = true;
//
//     if(dis > 10) {
//       //长距离滚动
//       updateCardScrollStatus(true);
//     }
//
//     if (dis == 1) {
//       scrollDuration = 500;
//       await Scrollable.ensureVisible(childCtx[index], duration: Duration(milliseconds: scrollDuration));
//     } else {
//       //方案一 短距效果不好
//       // scrollDuration = data.types.length * standardSingleTime;
//       // scrollDuration = (scrollDuration / dis).ceil();
//       //方案二 最低8帧，兼顾低端机型
//       scrollDuration = math.max((dis / data.types.length * standardSingleTime).ceil(), onCardScrollDuration);
//       if (index > selectTabIndex) {
//         //tab 向右  ，list 向下 滑动
//         int i = selectTabIndex + 1;
//         while (i <= index) {
//           await Scrollable.ensureVisible(childCtx[i], duration: Duration(milliseconds: scrollDuration));
//           i++;
//         }
//       } else {
//         //tab 向左  ，list 向上 滑动
//         int i = selectTabIndex - 1;
//         while (i >= index) {
//           await Scrollable.ensureVisible(childCtx[i], duration: Duration(milliseconds: scrollDuration));
//           i--;
//         }
//       }
//     }
//
//     isTapAnimateList = false;
//   }
//
//   ///获取实际工期
//   String getBuildDate(Types types) {
//     if (types.startDate == null || types.startDate == 0) {
//       //还未开始
//       return '-';
//     } else {
//       DateTime start = DateTime.fromMillisecondsSinceEpoch(types.startDate);
//       DateTime end = (types.finishDate == null || types.finishDate == 0) ? start : DateTime.fromMillisecondsSinceEpoch(types.finishDate);
//       return '${start.month}/${start.day}-${end.month }/${end.day}';
//     }
//   }
//
//   ///-----------------------------------
//
//   @override
//   Future<OnlineWatcherProgressEntity> loadData() {
//     //885测试数据
//     //args.reportId
//     return onlineWatcherApi.start(params: {'recordId': args.reportId}).then((value) {
//       if (value.success) {
//         return value.result;
//       } else {
//         ToastUtil.showNegativeToast('${value.message}');
//         return null;
//       }
//     });
//   }
//
//   @override
//   onCompleted(OnlineWatcherProgressEntity data) {}
//
//   bool isAddScrollingListener = false;
//
//   void initListeners() {
//     scrollController.addListener(() {
//       //此方法与长距离加载时，使用holder代替有关 ，暂时注释掉
//       //if(!isAddScrollingListener) addScrollingListener();
//       if (isTapAnimateList) return;
//       //在不改变缓存的情况下，总是有3个存活
//       updateUnMountedList();
//       updateTabs();
//     });
//
//   }
//
//
//   void addScrollingListener() {
//     isAddScrollingListener = true;
//     scrollController.position.isScrollingNotifier.addListener(() {
//       if(! scrollController.position.isScrollingNotifier.value) {
//         doStuffThrottle();
//       }
//     });
//   }
//
//   Timer timer;
//
//   void doStuffThrottle() {
//     if(timer != null && timer.isActive) {
//       timer.cancel();
//     }
//     timer = new Timer(Duration(milliseconds: (onCardScrollDuration * 1.5).ceil()), (){
//       updateCardScrollStatus(false);
//     });
//   }
//
// // ///[index] 总是 [selectTabIndex]的相邻值
// // Stream<int> scrollViewManual(int index)async* {
// //   await Scrollable.ensureVisible(childCtx[index],duration: Duration(milliseconds: 300));
// //   yield index;
// // }
//
// }
