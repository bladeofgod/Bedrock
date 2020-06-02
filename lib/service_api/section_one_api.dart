/*
* Author : LiJiqqi
* Date : 2020/5/28
*/



import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bedrock/base_framework/config/net/bedrock_http.dart';
import 'package:flutter_bedrock/page/demo_page/main/first/entity/first_card_entity.dart';
import 'package:flutter_bedrock/page/demo_page/main/first/entity/first_entity.dart';

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

    var response = await bedRock.post("$Index_php?r=collect/save-collect",data: FormData.fromMap(map));

    return response;
  }

  Future<FirstEntity> getFirstEntity()async{
    ///模拟请求、实体解析
    var response ;
    await Future.delayed(Duration(seconds: 2)).then((value){
      response =  FirstEntity();
    });
    return response;

  }
  ///假数据
  List<String> fakeData = [
    'https://iknow-pic.cdn.bcebos.com/6609c93d70cf3bc7dd9f82efd500baa1cd112a11?x-bce-process=image/resize,m_lfit,w_600,h_800,limit_1',
    'https://iknow-pic.cdn.bcebos.com/6a63f6246b600c334c3e91cb1e4c510fd9f9a16a?x-bce-process=image/resize,m_lfit,w_600,h_800,limit_1',
    'https://iknow-pic.cdn.bcebos.com/d4628535e5dde7119b460cf5a3efce1b9d166118?x-bce-process=image/resize,m_lfit,w_600,h_800,limit_1'
  ];

  Future<List<FirstCardEntity>> getFirstListCard(int pageNum,int pageSize)async{
    List<FirstCardEntity> response;
    await Future.delayed(Duration(seconds: 2)).then((value){
      if(pageNum > 3){
        response = null;
      }else{
        response = List.generate(8, (index){
          return FirstCardEntity(fakeData[index%3],"this is a title $index");
        });
      }
    });

    return response;
  }

}















