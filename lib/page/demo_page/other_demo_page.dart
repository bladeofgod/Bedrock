/*
* Author : LiJiqqi
* Date : 2020/6/10
*/


import 'package:flutter/material.dart';
import 'package:flutter_bedrock/base_framework/widget_state/page_state.dart';
import 'package:flutter_bedrock/page/demo_page/other/cross_list/cross_list_page.dart';
import 'package:flutter_bedrock/page/demo_page/other/little_util_page.dart';
import 'package:flutter_bedrock/page/demo_page/other/request_permission_page.dart';
import 'package:flutter_bedrock/page/demo_page/other/scroll_page.dart';
import 'package:flutter_bedrock/page/demo_page/other/test_android_page.dart';
import 'package:flutter_bedrock/page/demo_page/other/timer_page.dart';

import 'other/simple_list/simple_list_page.dart';

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
          ElevatedButton(
            child: Text('滚动事件的监听'),
            onPressed: (){
              push(ScrollPageState());
            },
          ),
          getSizeBox(height: getWidthPx(40)),
          ElevatedButton(
            child: Text('stream Util'),
            onPressed: (){
              push(LittleUtilPageState());
            },
          ),
          getSizeBox(height: getWidthPx(40)),
          ElevatedButton(
            child: Text('交叉联动列表'),
            onPressed: (){
              push(CrossListPage());
            },
          ),
          getSizeBox(height: getWidthPx(40)),
          ElevatedButton(
            child: Text('滑动中适时刷新view的经验'),
            onPressed: (){
              push(TimerPageState());
            },
          ),
          getSizeBox(height: getWidthPx(40)),
          ElevatedButton(
            child: Text('请求权限'),
            onPressed: (){
              push(RequestPermissionsPageState());
            },
          ),
          getSizeBox(height: getWidthPx(40)),
          ElevatedButton(
            child: Text('android 异常保护'),
            onPressed: (){
              push(TestAndroidPage());
            },
          ),
          40.vGap,
          ElevatedButton(
            child: Text('简单列表页'),
            onPressed: (){
              push(SimpleListPage());
            },
          ),

        ],
      ),
    ));
  }
}

































