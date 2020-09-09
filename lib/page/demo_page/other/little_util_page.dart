/*
* Author : LiJiqqi
* Date : 2020/6/10
*/

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bedrock/base_framework/utils/little_util.dart';
import 'package:flutter_bedrock/base_framework/widget_state/base_state.dart';
import 'package:flutter_bedrock/base_framework/widget_state/page_state.dart';



class LittleUtilPageState extends PageState {

  int count = 0;

  @override
  Widget build(BuildContext context) {
    return switchStatusBar2Dark(child: Container(
      width: getWidthPx(750),height: getHeightPx(1334),
      child: Column(
        children: <Widget>[
          getSizeBox(height: getWidthPx(100)),
          Divider(color: Colors.black,height: getWidthPx(4),),
          Text('开始自加 : $count'),
          RaisedButton(
            onPressed: startCalculate,
            child: Text('cycle Util'),
          ),
          Text("我自己项目需要封装的一个小工具，如果需要复杂功能建议直接使用stream，非常强大(flutter版RXjava)"),
          getSizeBox(height: getWidthPx(40)),
          Divider(color: Colors.black,height: getWidthPx(4),),
        ],
      ),
    ));
  }
  StreamSubscription streamSubscription;
  startCalculate()async{
    if(streamSubscription != null){
      await streamSubscription.cancel();
    }
     streamSubscription = LittleUtil.cycleUtil((){

      if(mounted){
        count++;
        setState(() {

        });
      }else{
        ///避免内存泄漏
        streamSubscription.cancel();
      }

    },period: Duration(seconds: 1));
  }


}
























