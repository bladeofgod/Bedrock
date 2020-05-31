import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:flutter_bedrock/base_framework/exception/un_authorized_exception.dart';
import 'package:flutter_bedrock/base_framework/exception/user_unbind_exception.dart';

import 'view_state.dart';


class ViewStateModel with ChangeNotifier {

  bool disposed = false;

  ViewState _viewState;

  /// 根据状态构造
  ///
  /// 子类可以在构造函数指定需要的页面状态
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
    if(e is DioError){

      if(e.error is UnAuthorizedException){
        setUnAuthorized();
      }
      if(e.error is UserUnbindException){
        setUnBind();
      }
      if(e.type == DioErrorType.CONNECT_TIMEOUT ){
        //todo
      }

    }



  }
}
