


import 'package:flutter/material.dart';
import 'package:flutter_bedrock/base_framework/widget_state/widget_state.dart';
import 'package:flutter_bedrock/page/demo_page/other/cross_list/cross_list_vm.dart';
import 'package:provider/provider.dart';

class TabItemWidget extends WidgetState{

  final int tabIndex;

  TabItemWidget(this.tabIndex);

  late final CrossListVM vm;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    vm = Provider.of(context,listen: false);
  }

  @override
  Widget build(BuildContext context) {
    vm.saveTabsChildCtx(tabIndex, context);
    return Selector<CrossListVM,int>(
      selector: (ctx, model) {
        return model.selectTabIndex;
      },
      builder: (ctx,value,child) {
        return Container(
          width: getWidthPx(150),
          padding: EdgeInsets.symmetric(horizontal: getWidthPx(20)),
          margin: EdgeInsets.only(right: getWidthPx(32)),
          decoration: BoxDecoration(
              color: value == tabIndex ? Colors.green : Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(getHeightPx(16))),
              border: Border.all(color: Colors.black,width: getWidthPx(2))
          ),alignment: Alignment.center,
          child: Text('标题  $tabIndex',style: TextStyle(color: Colors.black,fontSize: getSp(20)),),
        );
      },
    );
  }

}



























