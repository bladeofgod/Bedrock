/*
* Author : LiJiqqi
* Date : 2020/6/12
*/


import 'package:flutter/material.dart';
import 'package:flutter_bedrock/base_framework/widget_state/base_state.dart';
import 'package:flutter_bedrock/base_framework/widget_state/page_state.dart';


class SlideOutPageState extends PageState {

  String intro = '''
  switchStatusBar2Dark方法默认是使用侧滑退出的，如果不需要请将needSlideOut设置为false。
  对于使用侧滑退出的页面，请在routeManager中用SlideRightRouteBuilder对页面进行包裹，这样可以保证
  页面在退出和进入的时候，保证视觉上的流畅性。\n
  侧滑触发，是在页面左侧十分之一屏幕宽度内按下向右滑动超过二分之一屏幕宽度后松开退出。\n\n
  如果整个项目不打算接入侧滑退出，可以直接将switchStatusBar2Dark方法默认值改为false
  ''';

  @override
  Widget build(BuildContext context) {
    return switchStatusBar2Dark(
      needSlideOut: true,
      child: Container(
        color: Colors.blue,
        width: getWidthPx(750),height: getHeightPx(1334),
        padding: EdgeInsets.symmetric(horizontal: getWidthPx(40)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("slide page out"),
            getSizeBox(height: getWidthPx(100)),
            Text(intro,style: TextStyle(color: Colors.yellow,
            fontSize: getSp(30)),)

          ],
        ),
      )
    );
  }
}



















