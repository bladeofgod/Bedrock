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

/// 缓存测试页面
/// * 简单的讲，就是网络状态不佳的情况下，
/// * 从本地缓存取json格式的数据，用于显示
/// * 一般情况下直接缓存以string进行缓存，缓存工具是mmkv
/// * 你可以在CacheDataFactory 类里更改缓存方式

class CachePageVM extends RefreshListViewStateModel<CacheEntity> with CacheDataFactory<String> {

  CachePageVM(){
    ///注册缓存功能
    /// * 如果不需要缓存，不要使用缓存功能
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
  /*
  * 将之前缓存的list string 取出 并转为 list entity
  * 请务必保证json格式正确
  *
  * */
  @override
  void fetchListCacheData(List<String> cacheList) {
    cacheList.forEach((element) {
      list.add(CacheEntity.fromJson(jsonDecode(element)));
    });

  }


}
























