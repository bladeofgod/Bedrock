// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:riki/api/base_api.dart';
// import 'package:riki/entity/construction/online_watcher_progress_entity.dart';
// import 'package:riki/pages/construction/online_watcher/vm/build_progress_page_vm.dart';
// import 'package:riki/pages/construction/online_watcher/widget/tabs_item_widget.dart';
// import 'package:riki/pages/construction/online_watcher/widget/work_process_item.dart';
// import 'package:riki/res/header.dart';
// import 'package:riki/router/app_router.dart';
// import 'package:riki_base_flutter/widgets/base/base_pure_widget_state.dart';
// import 'package:riki_base_flutter/widgets/list/riki_smart_refresher.dart';
// import 'package:riki_im/riki_im.dart';
// import 'package:wakelock/wakelock.dart';
//
// import 'build_progress_detail_page.dart';
//
// ///缩放图片尾部，后面要移到 riki base里
// ///缩略图使用，仅限测试
//
// // String scaleImgUrl(String url, {int height = 150}) {
// //   return url + '?x-oss-process=image/resize,h_$height,m_lfit,limit_1';
// // }
//
// /// 作者：李佳奇
// /// 日期：2021/2/27
// /// 备注：在线管家 施工进度
// ///
// /// 外层需要提供一个 在线管家的服务群id
//
// class BuildProgressPageArgs {
//   ///用于进在线管家服务群
//   final String groupId;
//
//   ///报告id
//   final int reportId;
//
//   BuildProgressPageArgs(this.groupId, this.reportId);
// }
//
// class BuildProgressPage extends StatefulWidget {
//   final BuildProgressPageArgs args;
//
//   const BuildProgressPage({Key key, this.args}) : super(key: key);
//
//   @override
//   State<StatefulWidget> createState() {
//     return BuildProgressPageState();
//   }
// }
//
// class BuildProgressPageState extends BasePureWidgetState<BuildProgressPage> {
//   BuildProgressPageVM vm;
//
//   @override
//   void initState() {
//     super.initState();
//     Wakelock.enable();
//     vm = BuildProgressPageVM(widget.args);
//     vm.initListeners();
//   }
//
//   @override
//   void dispose() {
//     Wakelock.disable();
//     vm.scrollController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget buildBody(BuildContext context) {
//     return AnnotatedRegion<SystemUiOverlayStyle>(
//       value: SystemUiOverlayStyle.dark,
//       child: ProviderWidget<BuildProgressPageVM>(
//           builder: (ctx, model, child) {
//             return buildPageBody();
//           },
//           model: vm,
//           onModelReady: (model) {
//             vm.initApi();
//             vm.initData();
//           },
//           pageStatusFactory: DefaultPageStatusFactory()),
//     );
//   }
//
//   Widget buildPageBody() {
//     return Container(
//       width: 375.w,
//       height: 812.h,
//       color: Colors.white,
//       child: Stack(
//         children: [
//           //进度内容
//           buildProgressContent(),
//           //tab list
//           buildTabList(),
//
//           Positioned(top: 1, child: buildAppBar()),
//         ],
//       ),
//     );
//   }
//
//   ///整体进度内容
//   Widget buildProgressContent() {
//     final List<Widget> children = [];
//     for (int i = 0; i < vm.data.types.length; i++) {
//       children.add(buildWorkItem(i));
//     }
//     children.add(60.vGap);
//
//     return Container(
//       margin: EdgeInsets.only(top: 72.w + 44.w + ScreenUtil().statusBarHeight),
//       width: 375.w,
//       color: Color.fromRGBO(242, 242, 242, 1),
//       child: ListView(
//         controller: vm.scrollController,
//         padding: EdgeInsets.symmetric(horizontal: 16.w),
//         children: children,
//       ),
//     );
//   }
//
//   Widget buildWorkItem(int index) {
//     return WorkProcessItemWidget(
//       index: index,
//     );
//     // return GestureDetector(
//     //   onTap: (){
//     //     NavigatorUtils.push(context, AppRouter.buildProgressDetailPage,
//     //         params: BuildProgressDetailPageArgs(index: index,phaseList: vm.data.types));
//     //   },
//     //   child: WorkProcessItemWidget(index: index,),
//     // );
//   }
//
//   ///顶部施工进度 tab
//   Widget buildTabList() {
//     final List<Widget> children = [];
//     for (int i = 0; i < vm.data.types.length; i++) {
//       children.add(buildTabsItem(vm.data.types[i], i));
//     }
//     return Container(
//       margin: EdgeInsets.only(top: 44.w + ScreenUtil().statusBarHeight),
//       width: 375.w,
//       height: 72.w,
//       decoration: BoxDecoration(color: Colors.white, boxShadow: [
//         BoxShadow(
//           color: Colors.black.withOpacity(0.03),
//           offset: Offset(0, 4.w),
//           blurRadius: 16.w,
//           spreadRadius: 0,
//         )
//       ]),
//       child: ListView(
//         cacheExtent: 1500,
//         scrollDirection: Axis.horizontal,
//         padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 16.w),
//         children: children,
//       ),
//     );
//   }
//
//   Widget buildTabsItem(Types types, int index) {
//     return TabsItemWidget(
//       title: '${index+1}',
//       name: '${types.name}',
//       index: index,
//     );
//   }
//
//   Widget buildAppBar() {
//     return Container(
//       color: Colors.white,
//       width: 375.w,
//       height: 44.w + ScreenUtil().statusBarHeight,
//       padding: EdgeInsets.only(top: ScreenUtil().statusBarHeight),
//       child: Stack(
//         alignment: Alignment.centerLeft,
//         children: [
//           Positioned(
//             left: 0,
//             child: GestureDetector(
//               onTap: () {
//                 Navigator.pop(context);
//               },
//               child: ImageUtil.loadAssetImage(R.assetsImagesCommonIcAppbarBlackBack, width: 40.w, height: 40.w),
//             ),
//           ),
//           Positioned(
//               left: 145.w,
//               child: Text(
//                 '施工进度查看',
//                 style: TextStyle(color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.w500),
//               )),
//           Positioned(
//             left: 339.w,
//             child: GestureDetector(
//               onTap: () {
//                 if (vm.args.groupId == null || vm.args.groupId.isEmpty) {
//                   ToastUtil.showNegativeToast('暂未开启服务群');
//                 } else {
//                   RikiIM.instance.enterServiceGroupConversation(context, vm.args.groupId);
//                 }
//               },
//               child: Container(
//                 width: 20.w,
//                 height: 20.w,
//                 child: ImageUtil.loadAssetImage(R.assetsImagesMineIcMineBuildMsg),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//     // return RikiAppBar(
//     //   centerTitle: '施工进度查看',
//     //   actions: [
//     //     GestureDetector(
//     //       onTap: () {
//     //         if(vm.args.groupId == null || vm.args.groupId.isEmpty ){
//     //           ToastUtil.showNegativeToast('暂未开启服务群');
//     //         }else {
//     //           RikiIM.instance.enterServiceGroupConversation(context, vm.args.groupId);
//     //         }
//     //
//     //       },
//     //       child: Container(
//     //         width: 20.w,
//     //         height: 20.w,
//     //         child: ImageUtil.loadAssetImage(R.assetsImagesMineIcBuildMsg),
//     //       ),
//     //     ),
//     //     15.hGap,
//     //   ],
//     // );
//   }
//
//   @override
//   void initData(BuildContext context) {
//   }
//
// // void dumpCode() {
// //   Container(
// //     width: 375.w,
// //     color: Color.fromRGBO(242, 242, 242, 1),
// //     child: SmartRefresher(
// //       controller: vm.refreshController,
// //       enablePullDown: false,
// //       enablePullUp: false,
// //       header: buildRefreshView(),
// //       footer: buildLoadMoreView(),
// //       onRefresh: (){},
// //       onLoading: (){},
// //       //暂时不用builder,应该也能hold住
// //       child: ListView(
// //         controller: vm.scrollController,
// //         padding: EdgeInsets.symmetric(horizontal: 16.w),
// //         children: children,
// //       ),
// //     ),
// //   );
// // }
//
// }
