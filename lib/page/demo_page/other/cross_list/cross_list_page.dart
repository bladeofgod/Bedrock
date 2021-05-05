

import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bedrock/base_framework/ui/widget/provider_widget.dart';
import 'package:flutter_bedrock/base_framework/widget_state/page_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bedrock/page/demo_page/other/cross_list/body_item_widget.dart';
import 'package:flutter_bedrock/page/demo_page/other/cross_list/cross_list_vm.dart';
import 'package:flutter_bedrock/page/demo_page/other/cross_list/tab_item_widget.dart';

class CrossListPage extends PageState{

  CrossListVM vm = CrossListVM();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    vm.initListeners();
  }

  @override
  void dispose() {
    vm.releaseRes();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return switchStatusBar2Dark(
        child: ProviderWidget<CrossListVM>(
            builder: (ctx,model,child){
              return _buildPage();
            },
            model: vm,onModelReady: (model) {},));
  }

  Widget _buildPage() {
    return Container(
      width: getWidthPx(750),height: getHeightPx(1334),
      child: Column(
        children: [
          getSizeBox(height: getWidthPx(40) + ScreenUtil.getStatusBarH(context)),
          _buildTabs(),
          getSizeBox(height: getWidthPx(40)),
          Expanded(
            child: _buildPageBody(),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      width: getWidthPx(750),height: getWidthPx(100),
      child: ListView.builder(
        cacheExtent: 1500,
        padding: EdgeInsets.symmetric(horizontal: getWidthPx(32)),
        controller: vm.tabController,
        scrollDirection: Axis.horizontal,
        itemCount: vm.tabsTitle.length,
        itemBuilder: (ctx,e) {
          return GestureDetector(
            onTap: () {
              vm.tapTab(e);
            },
            child: TabItemWidget(e).generateWidget(),
          );
        },
      ),
    );
  }

  Widget _buildPageBody() {
    return Container(
      width: getWidthPx(750),color: Colors.white,
      child: ListView.builder(
        controller: vm.bodyController,
        itemCount: vm.tabsTitle.length,
        padding: EdgeInsets.symmetric(horizontal: getWidthPx(32)),
        itemBuilder: (ctx,e) => BodyItemWidget(e).generateWidget(),
      ),
    );
  }

}
































