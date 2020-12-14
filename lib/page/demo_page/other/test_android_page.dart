/*
* Author : LiJiqqi
* Date : 2020/12/14
*/
import 'package:flutter/material.dart';
import 'package:flutter_bedrock/base_framework/native/native_method_manager.dart';
import 'package:flutter_bedrock/base_framework/widget_state/page_state.dart';
class TestAndroidPage extends PageState{
  @override
  Widget build(BuildContext context) {
    return switchStatusBar2Dark(child: Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RaisedButton(onPressed: (){
            NativeMethodManager.getInstance().throwChildThreadException();

          },child: Text('android ： 抛一个子线程异常'),),
          getSizeBox(height: getWidthPx(40)),
          Text("默认 ui线程保护 和 activity 启动保护是注释掉的，需要在原生端的 BaseApp开启,才能进行下面的测试。\n"
              "PS:你可以先点击下方的看一下效果，然后开启后再看一下效果",
            style: TextStyle(color: Colors.black,fontSize: getSp(32)),),
          getSizeBox(height: getWidthPx(40)),
          RaisedButton(onPressed: (){
            NativeMethodManager.getInstance().throwUiThreadException();

          },child: Text('android ： 抛一个子UI线程异常'),),
          getSizeBox(height: getWidthPx(40)),
          RaisedButton(onPressed: (){
            NativeMethodManager.getInstance().throwStartUpException();
          },child: Text('android ： 抛一个生命周期异常'),),
        ],
      ),
    ));
  }

}



















