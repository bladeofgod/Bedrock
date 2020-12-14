/*
* Author : LiJiqqi
* Date : 2020/6/10
*/


import 'package:flutter/material.dart';
import 'package:flutter_bedrock/base_framework/config/router_manager.dart';
import 'package:flutter_bedrock/base_framework/widget_state/base_state.dart';
import 'package:flutter_bedrock/base_framework/widget_state/page_state.dart';
import 'package:flutter_bedrock/page/demo_page/other/little_util_page.dart';
import 'package:flutter_bedrock/page/demo_page/other/request_permission_page.dart';
import 'package:flutter_bedrock/page/demo_page/other/scroll_page.dart';
import 'package:flutter_bedrock/page/demo_page/other/test_android_page.dart';
import 'package:flutter_bedrock/page/demo_page/other/timer_page.dart';

///实验室 随便写的。



class OtherDemoPageState extends PageState {
  @override
  Widget build(BuildContext context) {
    return switchStatusBar2Dark(child: Container(
      color: Colors.white,
      width: getWidthPx(750),height: getHeightPx(1334),
      child: Column(
        children: <Widget>[
          getSizeBox(height: getWidthPx(100)),
          RaisedButton(
            child: Text('滚动事件的监听'),
            onPressed: (){
              push(ScrollPageState());
            },
          ),
          getSizeBox(height: getWidthPx(40)),
          RaisedButton(
            child: Text('stream Util'),
            onPressed: (){
              push(LittleUtilPageState());
            },
          ),
          getSizeBox(height: getWidthPx(40)),
          RaisedButton(
            child: Text('滑动中适时刷新view的经验'),
            onPressed: (){
              push(TimerPageState());
            },
          ),
          getSizeBox(height: getWidthPx(40)),
          RaisedButton(
            child: Text('请求权限'),
            onPressed: (){
              push(RequestPermissionsPageState());
            },
          ),
          getSizeBox(height: getWidthPx(40)),
          RaisedButton(
            child: Text('android 异常保护'),
            onPressed: (){
              push(TestAndroidPage());
            },
          ),
        ],
      ),
    ));
  }
}

































