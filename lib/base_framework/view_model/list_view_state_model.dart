import 'package:connectivity/connectivity.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:mmkv_flutter/mmkv_flutter.dart';
import 'package:oktoast/oktoast.dart';

import 'view_state_model.dart';

/// 基于
abstract class ListViewStateModel<T> extends ViewStateModel {

  /// 分页第一页页码
  final int pageNumFirst = 1;

  /// 分页条目数量
  final int pageSize = 10;

  /// 页面数据
  List<T> list = [];
  ///第一次加载
  bool firstInit = true;


  /// 第一次进入页面loading skeleton
  initData() async {
    setBusy(true);
    if(cacheDataFactory != null){
      bool netStatus =await checkNet();
      if(netStatus){
        ///没网
        await showCacheData();
        return;
      }
    }
    await refresh(init: true);
  }



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

  // 下拉刷新
  refresh({bool init = false}) async {
    //firstInit = init;
    try {
      List<T> data = await loadData();
      if (data.isEmpty) {
        setEmpty();
      } else {
        onCompleted(data);
        list = data;
        if (init) {
          firstInit = false;
          //改变页面状态为非加载中
          setBusy(false);
        } else {
          notifyListeners();
        }
        onRefreshCompleted();
        ///第一次加载且已注册的才缓存
        if(init && cacheDataFactory != null){
          cacheData();
        }
      }
    } catch (e, s) {
      handleCatch(e, s);
    }
  }
  void cacheData()async{
    debugPrint('list to string  ${cacheDataFactory.cacheListData().toString()}');
    final mmkv = await MmkvFlutter.getInstance();
    await mmkv.setString(this.runtimeType.toString(),cacheDataFactory.cacheListData().toString());
  }

  // 加载数据
  Future<List<T>> loadData();

  ///数据获取后会调用此方法,此方法在notifyListeners（）之前
  onCompleted(List<T> data) {}

  ///状态刷新后会调用此方法，此方法在notifyListeners（）之后
  onRefreshCompleted(){}

}
