/*
* Author : LiJiqqi
* Date : 2020/7/6
*/


import 'dart:io';

import 'package:flutter/services.dart';

class NativeMethodManager{

  static const MethodChannel _channel = const MethodChannel('com.lijiaqi.bedrock');

  static final String methodInstall = 'install_apk';


  static NativeMethodManager _singleton;

  static NativeMethodManager getInstance(){
    if(_singleton == null){
      _singleton = NativeMethodManager._();
    }
    return _singleton;
  }
  NativeMethodManager._();


  ///安卓端：安装指定路径的apk，如果有问题请给我提issue

  void installApk(String path)async{
    ///ios建议直接取应用市场
    if(isAndroid()){
      await _channel.invokeMethod(methodInstall,
          {"path":path});
    }
  }

  ///=====================Test===============================
  ///android端异常测试
  static final String childThreadException = 'child_exception';
  static final String uIThreadException = 'ui_exception';
  static final String startUpException = 'start_up_exception';

  void throwChildThreadException()async{
    if(isAndroid()){
      await _channel.invokeMethod(childThreadException);
    }
  }

  void throwUiThreadException()async{
    if(isAndroid()){
      await _channel.invokeMethod(uIThreadException);
    }
  }

  void throwStartUpException()async{
    if(isAndroid()){
      await _channel.invokeMethod(startUpException);
    }
  }

  bool isAndroid(){
    return Platform.isAndroid;
  }


}