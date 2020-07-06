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



  void installApk(String path)async{
    if(Platform.isAndroid){
      await _channel.invokeMethod(methodInstall,
          {"path":path});
    }
  }


}