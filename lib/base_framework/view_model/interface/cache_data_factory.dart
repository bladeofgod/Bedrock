/*
* Author : LiJiqqi
* Date : 2020/6/15
*/

import 'package:flutter_bedrock/base_framework/view_model/view_state_model.dart';
import 'package:mmkv_flutter/mmkv_flutter.dart';
import 'package:oktoast/oktoast.dart';

mixin CacheDataFactory<T> on ViewStateModel{
  /// 缓存单一数据
  /// * 一般情况下是json string
  T cacheData();
  /// 从缓存中取出数据
  void fetchCacheData(T cache);
  /// 缓存list数据
  /// * 一般情况下是List<json string >
  List<T> cacheListData();
  /// 从缓存中取出数据List
  void fetchListCacheData(List<T> cacheList);

  /// 将首次记载的数据进行缓存
  cacheRefreshData()async{
    final mmkv = await MmkvFlutter.getInstance();
    int i=0;
    for(T t in cacheListData()){
      await mmkv.setString('${this.runtimeType.toString()}$i','$t');
      i +=1;
    }

  }

  /// 显示上一次缓存的数据
  showCacheData()async{
    showToast('请检查网络状态');
    final mmkv = await MmkvFlutter.getInstance();
    ///总是取第一页作为临时展示
    List<String> cacheList = [];
    List<Future<String>> futures = [];
    for(int i=0 ; i < 10; i++){
      futures.add(mmkv.getString('${this.runtimeType.toString()}$i'));
    }
    Future.wait(futures).then((value){
      cacheList.addAll(value);
      cacheList.removeWhere((element) => (element.isEmpty || element.contains('null')));
      if(cacheList.isEmpty ){
        setEmpty();
      }else{
        cacheDataFactory.fetchListCacheData(cacheList);
        setBusy(false);
      }
    });


  }


}























