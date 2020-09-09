


import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bedrock/base_framework/widget_state/page_state.dart';



class TimerPageState extends PageState {
  
  String text = '''
  有的时候需要在用户滚动到某个item后请求接口并刷新，但是并不能确定用户会停在这个item。如果不考虑这些我，
  只是生硬的停一次请求一次，\n1、造成卡顿 \n 2、引起数据错乱 \n 3、浪费服务器资源 \n
  我的做法是通过timer来进行请求\n
  具体请查看代码和日志
      ''';
  
  @override
  Widget build(BuildContext context) {
    return switchStatusBar2Dark(child: Container(
      color: Colors.white,
      width: getWidthPx(750),height: getHeightPx(1334),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(text,style: TextStyle(color: Colors.black,fontSize: getSp(28)),),
          RaisedButton(
            child: Text('请求一下接口'),
            onPressed: (){
              request();
            },
          ),
        ],
      ),
    ));
  }
  
  Timer singleTimer;
  
  request(){
    if(singleTimer != null &&  singleTimer.isActive){
      debugPrint('取消上一次请求');
      singleTimer.cancel();
    }
    ///假设用户停止500ms后 请求
    singleTimer = Timer(Duration(milliseconds: 500),()async{

      await Future.delayed((Duration(seconds: 1))).then((value) => debugPrint("请求结束"));

      ///请求结束后的刷新
      ///接口请求应放在model 层，那么直接调用notifierListener()即可。
      ///其他地方请注意内存泄露问题
      debugPrint('刷新');
    });
  }
  
}



















