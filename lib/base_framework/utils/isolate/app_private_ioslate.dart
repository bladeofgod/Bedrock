/*
* Author : LiJiqqi
* Date : 2020/8/27
*/


import 'dart:isolate';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bedrock/base_framework/config/net/base_http.dart';
import 'package:flutter_bedrock/base_framework/config/net/bedrock_http.dart';
import 'package:flutter_bedrock/base_framework/observe/app_status/app_status_observe.dart' as appObserve;
import 'package:flutter_bedrock/base_framework/view_model/app_model/app_status_model.dart';
import 'package:oktoast/oktoast.dart';


///app 状态监测类，负责各种状态监测
///多数监测工作在子isolate

class AppPrivateIsolate{

  final AppStatusModel appStatusModel = AppStatusModel();

  ///
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

  ///监测网络状态和连接类型
  ///此方法工作在 main isolate
  void initNetObserver()async{
    if(_netIsolate != null )return;
    _netIsolate =await Isolate.spawn(appObserve.observerNetState, _netReceivePort.sendPort);

    /// message<String,dynamic>
    _netReceivePort.listen((message) {
      debugPrint('$message');
      String key = message[0];
      var value = message[1];
      if(key == appObserve.kNetPortKey){
        _netSendPort = value;
      }else if(key == appObserve.kNetAvailable){
        ///网络是否可用
        debugPrint('${message[1]}');
        String available = message[1];
        ///可以根据状态做对应的操作 具体看你的业务需求
        if(available == appObserve.kNetDisable){
          showToast('网络不可用');
          //bedRock.cancelAllRequest();
          appStatusModel.setNetStatus(NetStatus.Disable);
        }else if(available == appObserve.kNetEnable){
          debugPrint('网络正常');
          appStatusModel.setNetStatus(NetStatus.Enable);
        }
      }
    });

    ///网络连接方式的监听
    ///   ！ 注意这个不要放在child isolate
    Connectivity().onConnectivityChanged.listen((netType) {
      debugPrint('$netType');
      if(netType == ConnectivityResult.wifi){
        appStatusModel.setNetType(NetType.wifi);
      }else if(netType == ConnectivityResult.mobile){
        appStatusModel.setNetType(NetType.mobile);
      }else if(netType == ConnectivityResult.none){
        appStatusModel.setNetType(NetType.none);
      }

    });


  }

  ///服务器通知监测

  final ReceivePort _serverRP = ReceivePort();
  SendPort _serverOBSendPort;
  Isolate _serverOBIsolate;

  void initServerNotifyWatch()async{
    if(_serverOBIsolate != null)return;
    _serverOBIsolate = await Isolate.spawn(appObserve.observeServerNotify, _serverRP.sendPort);

    _serverRP.listen((message) {
      debugPrint('${appObserve.kServeNotifyPortKey} main : $message');
      //todo
    });

  }




  ///其他的监测工作 待拓展


}





















