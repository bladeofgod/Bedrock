import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bedrock/base_framework/view_model/single_view_state_model.dart';

class CrossListVM extends SingleViewStateModel {
  final List<int> tabsTitle = List.generate(25, (index) => index);

  final ScrollController tabController = ScrollController();
  final ScrollController bodyController = ScrollController();

  /// 保存 mounted item 用于垂直list
  List<int>? unMountedList;

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

  ///list 当前滚动的位置
  int currentItemIndex = 0;

  ///选择了第几个tab
  int selectTabIndex = 0;


  ///滑动垂直list 驱动tabs滚动
  /// * tabs正在滚动时，不响应其它滚动事件
  bool isScrollAnimateTabs = false;

  ///点击 tab 时,驱动 垂直列表
  bool isTapAnimateList = false;

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
      isScrollAnimateTabs = true;
      Scrollable.ensureVisible(ctx, duration: Duration(milliseconds: tabsScrollDuration));
    }
    isScrollAnimateTabs = false;
    notifyListeners();
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


  @override
  Future? loadData() {}

  @override
  onCompleted(data) {}
}
