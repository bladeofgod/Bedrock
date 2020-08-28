/*
* Author : LiJiqqi
* Date : 2020/8/28
*/

import 'package:flutter/material.dart';

enum NetStatus{
  Enable,Disable
}

enum NetType{
  wifi,mobile,none
}

class AppStatusModel extends ChangeNotifier{
  static AppStatusModel _singleton;
  factory AppStatusModel() => _getInstance();
  static AppStatusModel _getInstance(){
    if(_singleton == null){
      _singleton = AppStatusModel();
    }
    return _singleton;
  }

  ///网络是否可用
  NetStatus netStatus = NetStatus.Enable;
  setNetStatus(NetStatus status){
    netStatus = status;
    notifyListeners();
  }

  ///网络连接方式

  NetType netType ;
  setNetType(NetType type){
    netType = type;
    notifyListeners();
  }


}
























