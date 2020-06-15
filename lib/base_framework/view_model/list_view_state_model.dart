import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:mmkv_flutter/mmkv_flutter.dart';

import 'view_state_model.dart';

/// 基于
abstract class ListViewStateModel<T> extends ViewStateModel {
  /// 页面数据
  List<T> list = [];
  ///第一次加载
  bool firstInit = true;


  /// 第一次进入页面loading skeleton
  initData() async {
    setBusy(true);
    if(cacheDataFactory != null){
      checkNet();
    }
    await refresh(init: true);
  }

  checkNet()async{
    var connectivityResult = await (Connectivity().checkConnectivity());
    if(connectivityResult == ConnectivityResult.none){
      final mmkv = await MmkvFlutter.getInstance();
      ///没网
      debugPrint('run time type  :${runtimeType}');
      String cache =await mmkv.getString(this.runtimeType.toString());
      if(cache == null || cache.isEmpty){
        setEmpty();
      }else{
        cacheDataFactory.fetchListCacheData(cache.split(','));
      }
    }
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
      }
    } catch (e, s) {
      handleCatch(e, s);
    }
  }

  // 加载数据
  Future<List<T>> loadData();

  ///数据获取后会调用此方法,此方法在notifyListeners（）之前
  onCompleted(List<T> data) {}

  ///状态刷新后会调用此方法，此方法在notifyListeners（）之后
  onRefreshCompleted(){}

}
