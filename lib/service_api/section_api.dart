/*
* Author : LiJiqqi
* Date : 2020/5/28
*/



import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bedrock/base_framework/config/net/bedrock_http.dart';

class SectionOne{
  static SectionOne _singleton;

  factory SectionOne()=>getSingleton();

  static SectionOne getSingleton(){
    if(_singleton == null){
      _singleton = SectionOne._internal();
    }
    return _singleton;
  }

  SectionOne._internal(){
    //do stuff
  }


  ///
  final String testAPI = "";
  static const String Index_php = "index.php";

  Future getTest()async{
    var map = {
      "model":"1","user_id":"","union_id":"321","status":"0"
    };

    var response = await bedRock.post("$Index_php?r=collect/save-collect",data: FormData.fromMap(map));;
//    try{
//      response = await bedRock.post("$Index_php?r=collect/save-collect",data: FormData.fromMap(map));
//
//    }catch(e){
//      debugPrint("---------------");
//      debugPrint(e.toString());
//    }
    return response;
  }


}















