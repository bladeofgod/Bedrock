/*
* Author : LiJiqqi
* Date : 2020/6/4
*/


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bedrock/base_framework/widget_state/base_state.dart';
import 'package:flutter_bedrock/base_framework/widget_state/page_state.dart';



class UnKnowPageState extends PageState {

  String introduce = "路由未找到会进入此页面。\n "
      "理论上很难出现，但是对于一些路由路径后端控制，进行动态内部页面跳转的时候，还是有几率出现的，在此设置有一个页面，用户体验好一些。";

  @override
  Widget build(BuildContext context) {
    return switchStatusBar2Dark(child: Container(
      color: Colors.white,
      width: getWidthPx(750),height: getHeightPx(1334),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(introduce,textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontSize: getSp(28)),),
        ],
      ),
    ));
  }
}





















