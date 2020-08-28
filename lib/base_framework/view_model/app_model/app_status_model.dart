/*
* Author : LiJiqqi
* Date : 2020/8/28
*/

import 'package:flutter/material.dart';

enum NetStatus{
  Enable,Disable
}

class AppStatusModel extends ChangeNotifier{

  ///网络是否可用
  NetStatus netStatus = NetStatus.Enable;
  setNetStatus(NetStatus status){
    netStatus = status;
    notifyListeners();
  }


}
























