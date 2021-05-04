import 'dart:math';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bedrock/base_framework/widget_state/widget_state.dart';
import 'package:flutter_bedrock/page/demo_page/other/cross_list/cross_list_vm.dart';
import 'package:provider/provider.dart';


class BodyItemWidget extends WidgetState{

  final int index;

  BodyItemWidget(this.index);

  late final CrossListVM vm;

  late double height;

  @override
  void initState() {
    super.initState();
    vm = Provider.of(context,listen: false);
    height = (Random().nextInt(20)).clamp(5, 19) * 50;
  }


  @override
  Widget build(BuildContext context) {
    vm.saveBodyItemCtx(index, context);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(getHeightPx(16))),
          border: Border.all(color: Colors.lightBlueAccent,width: getWidthPx(2))
      ),margin: EdgeInsets.only(bottom: getWidthPx(32)),
      child: Column(
        children: [
          Text('标题 $index',style: TextStyle(color: Colors.black,fontSize: getSp(30))),
          Container(
            width: getWidthPx(750),
            height: getWidthPx(height),
            margin: EdgeInsets.symmetric(horizontal: getWidthPx(16),vertical: getWidthPx(42)),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(getHeightPx(16))),
              color: Colors.grey
            ),child: Text('内容 $index',style: TextStyle(color: Colors.white,fontSize: getSp(50))),
          ),
        ],
      ),
    );
  }

}

























