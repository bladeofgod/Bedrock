/*
* Author : LiJiqqi
* Date : 2020/9/10
*/




import 'package:flutter/material.dart';
import 'package:flutter_bedrock/base_framework/widget_state/page_state.dart';
import 'package:flutter_bedrock/page/demo_page/start/pages/page_2.dart';

class Page1 extends PageState{
  @override
  Widget build(BuildContext context) {
    return switchStatusBar2Dark(child: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          getSizeBox(height: getHeightPx(100)),
          Text('page 1',style: TextStyle(color: Colors.black,fontSize: getSp(24)),),
          getSizeBox(height: getHeightPx(40)),
          RaisedButton(
            child: Text('go page 2',style: TextStyle(color: Colors.black),),
            onPressed: (){
              push(Page2());
            },
          ),
        ],
      ),
    ));
  }


}