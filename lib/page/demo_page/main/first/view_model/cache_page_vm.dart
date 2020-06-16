/*
* Author : LiJiqqi
* Date : 2020/6/15
*/


import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bedrock/base_framework/view_model/interface/cache_data_factory.dart';
import 'package:flutter_bedrock/base_framework/view_model/refresh_list_view_state_model.dart';
import 'package:flutter_bedrock/page/demo_page/main/first/entity/cache_entity.dart';
import 'package:flutter_bedrock/service_api/bedrock_repository_proxy.dart';



class CachePageVM extends RefreshListViewStateModel<CacheEntity> implements CacheDataFactory{

  CachePageVM(){
    ///注册缓存功能
    this.injectCache(this);
  }


  @override
  Future<List<CacheEntity>> loadData({int pageNum}) {
   return BedrockRepositoryProxy.getInstance().getSectionOne().getCacheList(pageNum);
  }

  @override
  String cacheData() {
    return '';
  }

  @override
  List<String> cacheListData() {
    List<String> strList = [];
    list.forEach((element) {
      strList.add(jsonEncode(element));
    });
    return strList;
  }

  @override
  void fetchCacheData(String cache) {

  }

  @override
  void fetchListCacheData(List<String> cacheList) {
    cacheList.forEach((element) {
      list.add(CacheEntity.fromJson(jsonDecode(element)));
    });

  }


}
























