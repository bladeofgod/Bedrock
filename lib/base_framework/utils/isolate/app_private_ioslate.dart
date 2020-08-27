/*
* Author : LiJiqqi
* Date : 2020/8/27
*/


import 'dart:isolate';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bedrock/base_framework/observe/app_status_observer.dart';

class AppPrivateIsolate{

  static AppPrivateIsolate _appPrivateIsolate;

  factory AppPrivateIsolate()=>getInstance();

  static AppPrivateIsolate getInstance(){
    if(_appPrivateIsolate == null){
      _appPrivateIsolate = AppPrivateIsolate._();
    }
    return _appPrivateIsolate;
  }

  AppPrivateIsolate._();


  final ReceivePort _netReceivePort = ReceivePort();
  SendPort _netSendPort ;
  Isolate _netIsolate ;

  void initNetObserver()async{
    _netIsolate =await Isolate.spawn(observerNetState, _netReceivePort.sendPort);

    /// message<String,dynamic>
    _netReceivePort.listen((message) {
      debugPrint('$message');
      String key = message[0];
      var value = message[1];
      if(key == kNetPortKey){
        _netSendPort = value;
      }else if(key == kNetType){
        ///网络类型
      }else if(key == kNetAvailable){
        ///网络是否可用
        debugPrint('${message[1]}');
      }
    });

  }


}





















