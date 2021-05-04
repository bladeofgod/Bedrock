import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bedrock/base_framework/view_model/single_view_state_model.dart';
import 'dart:math' as math;

class CrossListVM extends SingleViewStateModel {
  final List<int> tabsTitle = List.generate(25, (index) => index);

  final ScrollController tabController = ScrollController();
  final ScrollController bodyController = ScrollController();

  /// 保存 mounted item 用于垂直list
  List<int>? unMountedList;

  /// 长距离最小分片时间
  final int onCardScrollDuration = 16*8;

  ///tab item context
  final SplayTreeMap<int, BuildContext> tabsChildCtx = SplayTreeMap<int, BuildContext>();
  ///body item context
  final SplayTreeMap<int, BuildContext> bodyChildCtx = SplayTreeMap<int, BuildContext>();

  final SplayTreeMap<int, double> itemOffsetY = SplayTreeMap<int, double>();
  
  void saveBodyItemCtx(int index , BuildContext ctx) {
    bodyChildCtx.update(index, (value) => ctx , ifAbsent: ()=>ctx);
  }

  void saveTabsChildCtx(int index, BuildContext ctx) {
    tabsChildCtx.update(index, (value) => ctx,ifAbsent: () => ctx);
  }


  ///tab 滚动时间
  int tabsScrollDuration = 300;

  ///用于分片滚动时间
  final int standardSingleTime = 150;

  ///list 当前滚动的位置
  int currentItemIndex = 0;

  ///选择了第几个tab
  int selectTabIndex = 0;


  ///滑动垂直list 驱动tabs滚动
  /// * tabs正在滚动时，不响应其它滚动事件
  bool isScrollAnimateTabs = false;

  ///点击 tab 时,驱动 垂直列表
  bool isTapAnimateList = false;

  ///滚动所给时间
  int scrollDuration = 500;

  void initListeners() {
    bodyController.addListener(() {
      if (isTapAnimateList) return;
      //在不改变缓存的情况下，总是有3个存活
      updateUnMountedList();
      updateTabs();
    });

  }

  ///垂直列表滚动时切换上方tabs
  void updateTabs() {
    if (isScrollAnimateTabs) return;
    currentItemIndex = currentIndexOnScreen();
    if (selectTabIndex == currentItemIndex) return;
    selectTabIndex = currentItemIndex;
    final ctx = tabsChildCtx[currentItemIndex];
    if (ctx != null) {
      StatefulElement ele = ctx as StatefulElement;
      if(!ele.state.mounted) return;
      isScrollAnimateTabs = true;
      Scrollable.ensureVisible(ctx, duration: Duration(milliseconds: tabsScrollDuration));
    }
    isScrollAnimateTabs = false;
    notifyListeners(refreshSelector: true);
  }

  ///更新 存活列表
  void updateUnMountedList() {
    unMountedList = bodyChildCtx.entries
        .where((ctx) {
          StatefulElement ele = ctx.value as StatefulElement;
          return (ele.state.mounted);
        })
        .map<int>((e) => e.key)
        .toList();
  }

  ///返回当前垂直列表 在屏的index
  int currentIndexOnScreen() {
    if (unMountedList == null || (unMountedList?.isEmpty ?? true)) return 0;
    if (bodyController.position.pixels == bodyController.position.minScrollExtent) {
      //head pos
      return unMountedList!.first;
    } else if (bodyController.position.pixels == bodyController.position.maxScrollExtent) {
      //tail pos
      return unMountedList!.last;
    }
    final double scrollPos = bodyController.position.pixels;
    //collect
    collectVerticalItemHeight();

    for (int i = 0; i < unMountedList!.length - 1; i++) {
      final int ctxIndex = unMountedList![i];
      if ((itemOffsetY[ctxIndex]! - scrollPos).abs() < 20) {
        return unMountedList![i];
      }
    }
    //容灾
    return currentItemIndex;

  }

  ///收集垂直列表item高度
  /// * 此处应用item的高度不会变化
  void collectVerticalItemHeight() {
    final minScrollExtent = bodyController.position.minScrollExtent;
    final maxScrollExtent = bodyController.position.maxScrollExtent;
    unMountedList!.forEach((live) {
      if (itemOffsetY.containsKey(live)) return;
      final BuildContext ctx = bodyChildCtx[live]!;
      final RenderObject renderObject = ctx.findRenderObject()!;
      final RenderAbstractViewport viewport = RenderAbstractViewport.of(renderObject)!;
      final double target = viewport.getOffsetToReveal(renderObject, 0.0).offset.clamp(minScrollExtent, maxScrollExtent);
      itemOffsetY[live] = target;
    });
  }

  void tapTab(int index) async {
    jumpToItem(index);
    selectTabIndex = index;
    notifyListeners(refreshSelector: true);
    await Scrollable.ensureVisible(tabsChildCtx[index]!,duration: Duration(milliseconds: 500),alignment: 0.5);
  }


    ///滚动到第[index]施工进度卡片
  void jumpToItem(int index) async {
    final int dis = (index - selectTabIndex).abs();
    if (dis == 0) return;

    isTapAnimateList = true;

    if (dis == 1) {
      scrollDuration = 500;
      await Scrollable.ensureVisible(bodyChildCtx[index]!, duration: Duration(milliseconds: scrollDuration));
    } else {
      scrollDuration = math.max((dis / tabsTitle.length * standardSingleTime).ceil(), onCardScrollDuration);
      if (index > selectTabIndex) {
        //tab 向右  ，list 向下 滑动
        int i = selectTabIndex + 1;
        while (i <= index) {
          await Scrollable.ensureVisible(bodyChildCtx[i]!, duration: Duration(milliseconds: scrollDuration));
          i++;
        }
      } else {
        //tab 向左  ，list 向上 滑动
        int i = selectTabIndex - 1;
        while (i >= index) {
          await Scrollable.ensureVisible(bodyChildCtx[i]!, duration: Duration(milliseconds: scrollDuration));
          i--;
        }
      }
    }

    isTapAnimateList = false;
  }


  @override
  Future? loadData() {}

  @override
  onCompleted(data) {}
}
