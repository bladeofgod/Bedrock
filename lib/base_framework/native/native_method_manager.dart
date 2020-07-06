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
    if(Platform.isAndroid){
      await _channel.invokeMethod(methodInstall,
          {"path":path});
    }
  }


}