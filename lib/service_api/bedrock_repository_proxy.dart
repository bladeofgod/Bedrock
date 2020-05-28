/*
* Author : LiJiqqi
* Date : 2020/5/28
*/


import 'package:flutter_bedrock/service_api/section_api.dart';

class BedrockRepositoryProxy{
  static BedrockRepositoryProxy _singleton;

  BedrockRepositoryProxy._internal(){
    //do something
  }

  static BedrockRepositoryProxy getInstance(){
    if(_singleton == null){
      _singleton = BedrockRepositoryProxy._internal();
    }
    return _singleton;
  }


  ///项目按模块划分 api   eg： 我的、首页、商品等等
  SectionOne getSectionOne(){
    return SectionOne();
  }

}



