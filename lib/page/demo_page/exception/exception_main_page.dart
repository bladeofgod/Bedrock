/*
* Author : LiJiqqi
* Date : 2021/1/8
*/

import 'package:flutter_bedrock/base_framework/widget_state/page_state.dart';
import 'package:flutter/material.dart';
import 'exception_notify_page.dart';

import 'handle_exception_page.dart';


class ExceptionMainPage extends PageState{
  @override
  Widget build(BuildContext context) {
    return switchStatusBar2Dark(child: Container(
      color: Colors.white,
      width: getWidthPx(750),height: getHeightPx(1334),
      padding: EdgeInsets.symmetric(horizontal: getWidthPx(40)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          buildIntro("页面 viewModel.initData() 触发的api 业务异常"),
          RaisedButton(
            child: Text("demo handle exception",style: TextStyle(color: Colors.black),),
            onPressed: (){
              push(HandleExceptionPageState());
            },
          ),
          getSizeBox(height: getHeightPx(40)),
          buildIntro("页面/widget 对业务异常的监听(即，非initData()所触发的业务异常)。"),
          RaisedButton(
            child: Text("demo handle exception",style: TextStyle(color: Colors.black),),
            onPressed: (){
              push(ExceptionNotifyPage());
            },
          ),

        ],
      ),
    ));
  }

  Widget buildIntro(String str){
    return Text(str,style: TextStyle(color: Colors.black,fontSize: getSp(28)),);
  }

}



















