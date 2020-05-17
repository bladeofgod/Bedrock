/*
* Author : LiJiqqi
* Date : 2020/4/2
*/

import 'package:flutter/cupertino.dart';

extension ListToString on List{
  String toStringByComma(){
    //[a,b,c] => a,b,c
    //[a] => a
    String list = this.toString();//[]
    debugPrint("list.toString  : $list");
    //list.replaceAll(" ", "");
    debugPrint("list replace all /b : $list");
    return list.length <= 2 ? "" :list.substring(1,list.length-1);
  }
}