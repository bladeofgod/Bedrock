


import 'package:flutter/material.dart';
import 'package:flutter_bedrock/base_framework/config/router_manager.dart';
import 'package:flutter_bedrock/base_framework/factory/page/page_animation_builder.dart';
import 'package:flutter_bedrock/base_framework/widget_state/base_state.dart';
import 'package:flutter_bedrock/base_framework/widget_state/page_state.dart';
import 'package:flutter_bedrock/page/demo_page/route_anim/fade_page.dart';
import 'package:flutter_bedrock/page/demo_page/route_anim/scale_page.dart';
import 'package:flutter_bedrock/page/demo_page/route_anim/slide_page.dart';


class RouteAnimationPageState extends PageState {
  @override
  Widget build(BuildContext context) {
    return switchStatusBar2Dark(
        child: Container(width: getWidthPx(750),height: getHeightPx(1334),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                onPressed: (){
                  push(SlidePageState(),animation: PageAnimation.Slide);

                },
                child: Text("滑动跳转"),
              ),
              getSizeBox(height: getWidthPx(40)),
              RaisedButton(
                onPressed: (){
                  push(ScalePageState(),animation: PageAnimation.Scale);

                },
                child: Text("缩放跳转"),
              ),
              getSizeBox(height: getWidthPx(40)),
              RaisedButton(
                onPressed: (){
                  push(FadePageState(),animation: PageAnimation.Fade);

                },
                child: Text("渐隐跳转"),
              ),
            ],
          ),));
  }

}


















