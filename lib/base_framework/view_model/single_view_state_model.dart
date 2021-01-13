


import 'package:flutter/cupertino.dart';

import 'package:oktoast/oktoast.dart';
import 'package:flutter_bedrock/base_framework/view_model/view_state_model.dart';

import 'handle/exception_handler.dart';

abstract class SingleViewStateModel<T> extends ViewStateModel{

  T data ;

  initData()async{
    setBusy(true);
    await fetchData(fetch: true);
  }

  fetchData({bool fetch = false})async{
    try{
      T temp = await loadData();
      if(temp == null){
        setEmpty();
      }else{
        data = temp;
        onCompleted(temp);
        if(fetch){
          setBusy(false);
        }else{
          notifyListeners();
        }
      }
    } catch (e,s){
      ExceptionHandler.getInstance().handleException(this, e, s);
      }
  }


  Future<T> loadData();
  //数据获取后会调用此方法,此方法在notifyListeners（）之前
  ///此方法仅在页面状态变化前，对外暴露一下数据
  /// * e.g. 需要对接口返回的数据进行二次处理
  onCompleted(T data);

}