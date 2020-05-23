


import 'package:flutter/cupertino.dart';

import 'package:oktoast/oktoast.dart';
import 'package:flutter_bedrock/base_framework/view_model/view_state_model.dart';

abstract class ViewStateSingleModel<T> extends ViewStateModel{

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
        onCompleted(temp);
        data = temp;
        if(fetch){
          setBusy(false);
        }else{
          notifyListeners();
        }
      }
    } catch (e,s){
      debugPrint("e :    $e");
      debugPrint("s :    $s");
      handleCatch(e, s);
      }
  }


  Future<T> loadData();

  onCompleted(T data);

}