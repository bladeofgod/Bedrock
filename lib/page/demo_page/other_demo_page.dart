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
      width: getWidthPx(750),height: getHeightPx(1334),
      child: Column(
        children: <Widget>[
          getSizeBox(height: getWidthPx(100)),
          RaisedButton(
            child: Text('scroll page'),
            onPressed: (){
              Navigator.of(context).pushNamed(RouteName.scroll_page);
            },
          ),
        ],
      ),
    ));
  }
}

































