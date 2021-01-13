import 'package:connectivity/connectivity.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bedrock/base_framework/view_model/interface/cache_data_factory.dart';
import 'package:mmkv_flutter/mmkv_flutter.dart';
import 'package:oktoast/oktoast.dart';

import 'handle/exception_handler.dart';
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
      ///
      bool netStatus =await checkNet();
      if(netStatus){
        ///没网 的情况下
        await cacheDataFactory.showCacheData();
        return;
      }
    }
    await refresh(init: true);
  }




  // 下拉刷新
  refresh({bool init = false}) async {
    //firstInit = init;
    try {
      List<T> data = await loadData();
      if (data.isEmpty) {
        setEmpty();
      } else {
        list = data;
        onCompleted(data);
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
      ExceptionHandler.getInstance().handleException(this, e, s);
    }
  }


  // 加载数据
  Future<List<T>> loadData();

  ///数据获取后会调用此方法,此方法在notifyListeners（）之前
  onCompleted(List<T> data) {}

  ///状态刷新后会调用此方法，此方法在notifyListeners（）之后
  onRefreshCompleted(){}

}
