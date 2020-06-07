


import 'package:flutter/material.dart';
import 'package:flutter_bedrock/base_framework/config/router_manager.dart';
import 'package:flutter_bedrock/base_framework/widget_state/base_state.dart';

class RouteAnimationPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return RouteAnimationPageState();
  }

}

class RouteAnimationPageState extends BaseState<RouteAnimationPage> {
  @override
  Widget build(BuildContext context) {
    return switchStatusBar2Dark(
        child: Container(width: getWidthPx(750),height: getHeightPx(1334),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                onPressed: (){
                  Navigator.of(context).pushNamed(RouteName.slide_page);

                },
                child: Text("滑动跳转"),
              ),
              getSizeBox(height: getWidthPx(40)),
              RaisedButton(
                onPressed: (){
                  Navigator.of(context).pushNamed(RouteName.scale_page);

                },
                child: Text("缩放跳转"),
              ),
              getSizeBox(height: getWidthPx(40)),
              RaisedButton(
                onPressed: (){
                  Navigator.of(context).pushNamed(RouteName.fade_page);

                },
                child: Text("渐隐跳转"),
              ),
            ],
          ),));
  }

}


















