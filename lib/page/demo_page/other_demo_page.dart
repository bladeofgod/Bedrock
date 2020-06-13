/*
* Author : LiJiqqi
* Date : 2020/6/10
*/


import 'package:flutter/material.dart';
import 'package:flutter_bedrock/base_framework/config/router_manager.dart';
import 'package:flutter_bedrock/base_framework/widget_state/base_state.dart';

///实验室 随便写的。


class OtherDemoPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return OtherDemoPageState();
  }

}

class OtherDemoPageState extends BaseState<OtherDemoPage> {
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
              Navigator.of(context).pushNamed(RouteName.scroll_page);
            },
          ),
          getSizeBox(height: getWidthPx(40)),
          RaisedButton(
            child: Text('stream Util'),
            onPressed: (){
              Navigator.of(context).pushNamed(RouteName.little_util_page);
            },
          ),
          getSizeBox(height: getWidthPx(40)),
          RaisedButton(
            child: Text('滑动中适时刷新view的经验'),
            onPressed: (){
              Navigator.of(context).pushNamed(RouteName.timer_page);
            },
          ),
        ],
      ),
    ));
  }
}

































