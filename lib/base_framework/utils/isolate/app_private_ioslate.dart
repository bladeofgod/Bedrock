/*
* Author : LiJiqqi
* Date : 2020/8/27
*/


import 'dart:isolate';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'file:///D:/bedrock/lib/base_framework/observe/app_status/app_status_observe.dart';

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
    if(_netIsolate != null )return;
    _netIsolate =await Isolate.spawn(observerNetState, _netReceivePort.sendPort);

    /// message<String,dynamic>
    _netReceivePort.listen((message) {
      debugPrint('$message');
      String key = message[0];
      var value = message[1];
      if(key == kNetPortKey){
        _netSendPort = value;
      }else if(key == kNetAvailable){
        ///网络是否可用
        debugPrint('${message[1]}');
      }
    });

    ///网络连接方式的监听
    ///   ！ 注意这个不要放在child isolate
    Connectivity().onConnectivityChanged.listen((netType) {
      debugPrint('$netType');
      if(netType == ConnectivityResult.wifi){

      }else if(netType == ConnectivityResult.mobile){

      }

    });


  }


}





















