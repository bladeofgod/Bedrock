/*
* Author : LiJiqqi
* Date : 2020/4/2
*/

import 'package:flutter/cupertino.dart';

///extension 可以对原有类进行扩展，下面实现了 list.toString 后,去除中括号

extension ListToString on List{

  ///将list转为以‘，’分隔的字符串
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