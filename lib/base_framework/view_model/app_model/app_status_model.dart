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
/*
* 如果这个类不适合你的需求，可以根据自己的需求更改。
* 仅做参考
* */
class AppStatusModel {
  static AppStatusModel _singleton;
  factory AppStatusModel() => _getInstance();
  static AppStatusModel _getInstance(){
    if(_singleton == null){
      _singleton = AppStatusModel._();
    }
    return _singleton;
  }

  AppStatusModel._();


  ///网络是否可用
  NetStatus netStatus = NetStatus.Enable;
  setNetStatus(NetStatus status){
    netStatus = status;
  }

  ///网络连接方式

  NetType netType ;
  setNetType(NetType type){
    netType = type;
  }


}
























