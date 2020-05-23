import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:flutter_bedrock/base_framework/exception/un_authorized_exception.dart';
import 'package:flutter_bedrock/base_framework/exception/user_unbind_exception.dart';

import 'view_state.dart';


class ViewStateModel with ChangeNotifier {
  /// 防止页面销毁后,异步任务才完成,导致报错
  bool disposed = false;

  /// 当前的页面状态,默认为busy,可在viewModel的构造方法中指定;
  ViewState _viewState;

  /// 根据状态构造
  ///
  /// 子类可以在构造函数指定需要的页面状态
  /// FooModel():super(viewState:ViewState.busy);
  ViewStateModel({ViewState viewState})
      : _viewState = viewState ?? ViewState.idle;

  ViewState get viewState => _viewState;

  set viewState(ViewState viewState) {
    _viewState = viewState;
    notifyListeners();
  }

  /// 出错时的message
  String _errorMessage;

  String get errorMessage => _errorMessage;


  bool get busy => viewState == ViewState.busy;

  bool get idle => viewState == ViewState.idle;

  bool get empty => viewState == ViewState.empty;

  bool get error => viewState == ViewState.error;

  bool get unAuthorized => viewState == ViewState.unAuthorized;

  bool get unBind => viewState == ViewState.unBind;

  void setBusy(bool value) {
    _errorMessage = null;
    viewState = value ? ViewState.busy : ViewState.idle;
  }

  void setEmpty() {
    _errorMessage = null;
    viewState = ViewState.empty;
  }

  void setError(String message) {
    _errorMessage = message;
    showToast(_errorMessage);
    viewState = ViewState.error;
  }

  void setIdle(){
    _errorMessage = null;
    viewState = ViewState.idle;
  }

  void setUnAuthorized() {
    _errorMessage = null;
    viewState = ViewState.unAuthorized;
  }

  void setUnBind(){
    _errorMessage = null;
    viewState = ViewState.unBind;
  }

  @override
  String toString() {
    return 'BaseModel{_viewState: $viewState, _errorMessage: $_errorMessage}';
  }

  @override
  void notifyListeners() {
    if (!disposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    disposed = true;
    super.dispose();
  }

  /// Handle Error and Exception
  ///
  /// 统一处理子类的异常情况
  /// [e],有可能是Error,也有可能是Exception.所以需要判断处理
  /// [s] 为堆栈信息
  void handleCatch(e, s) {
    //should toast something here
    // DioError的判断,理论不应该拿进来,增强了代码耦合性,抽取为时组件时.应移除
    //print("----> ${e.toString()}");
    if(e is UnAuthorizedException){
      setUnAuthorized();
    }
    if(e is UserUnbindException){
      setUnBind();
    }
//    if(e is DioError){
//      print("${e.error}");
//      print("${e.response}");
//      print("${e.message}");
//      print("${e.type}");
//    }
//    String str = e.toString();
//    Map response = json.decode(str.substring(str.indexOf("{"),str.lastIndexOf
//      ("}")));
//    var errorCode = response["errorCode"];
//    var detailMsg = response["detailMessage"];
//    showToast("$detailMsg  $errorCode");
//    showToast("s from server : ${s.toString()}");
//    debugPrint('error----->\n' + e.toString());
//    debugPrint('statck----->\n' + s.toString());
    //temp set
    ///根据应用 自定义异常
//    _errorMessage = e.toString();
//    if(e is HessianException){
//      showToast("${e.message}");
//      if(e.code == 20007){
//        setUnAuthorized();
//      }
//      print("${e.code}");
//      print("${e.detail}");
//      print("${e.message}");
//
//    }else if(e is DataMissingException){
//      showToast(e.message);
//      setError(e.message);
//    }
//    else if (e is DioError && e.error is UnAuthorizedException) {
//      print("${e.type}");
//      print("${e.message}");
//      print("${e.response}");
//      print("${e.error}");
//      setUnAuthorized();
//    }
//    else if(e is DioError){
//      print("${e.type}");
//      print("${e.message}");
//      print("${e.response}");
//      print("${e.error}");
//
//    }
//    else if(e is Exception ){
//      print("${e.toString()}");
//      if(e.toString().contains("20007")){
//        //showToast(e.message);
//        setUnAuthorized();
//      }
//    }
//    else {
//      //print("${e.code}");
//      debugPrint('error--->\n' + e.toString());
//      debugPrint('statck--->\n' + s.toString());
//      setError(e is Error ? e.toString() : e.message);
//    }
  }
}
