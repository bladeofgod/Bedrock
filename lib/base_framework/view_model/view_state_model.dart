import 'dart:convert';
import 'dart:math';

import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bedrock/base_framework/utils/exception_pitcher.dart';
import 'package:flutter_bedrock/base_framework/view_model/interface/cache_data_factory.dart';
import 'package:flutter_bedrock/base_framework/widget_state/page_state.dart';
import 'package:flutter_bedrock/base_framework/widget_state/widget_state.dart';
import 'package:oktoast/oktoast.dart';
import 'package:flutter_bedrock/base_framework/exception/un_authorized_exception.dart';
import 'package:flutter_bedrock/base_framework/exception/user_unbind_exception.dart';

import 'view_state.dart';


abstract class ViewStateModel with ChangeNotifier {

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

  bool get noNet => viewState == ViewState.noNet;


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

  void setUnAuthorized({String toast}) {
    _errorMessage = toast;
    showShortToast(toast);
    viewState = ViewState.unAuthorized;
  }

  void setUnBind({String toast}){
    _errorMessage = toast;
    showShortToast(toast);
    viewState = ViewState.unBind;
  }

  void setNoNet({String toast}){
    _errorMessage = toast;
    showShortToast(toast);
    viewState = ViewState.noNet;
  }

  showShortToast(String toast){
    if(toast != null && toast.isNotEmpty){
      showToast(toast);
    }
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

  /// 当注册缓存功能后，会在第一次进入页面加载数据时（initData（））对数据进行缓存
  /// 刷新等操作是不会缓存数据的。之后，在没网的情况下会显示上次缓存的数据并提示用户网络状态，以达到更好的用户体验
  /// 你也可以根据自己的需求定制

  CacheDataFactory cacheDataFactory;
  injectCache(CacheDataFactory cacheDataFactory){
    this.cacheDataFactory = cacheDataFactory;
  }

  ///检查网络状态
  Future<bool> checkNet()async{
    debugPrint('检查网络');
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult == ConnectivityResult.none;
  }


}


/// 虽然 * ViewModel 已经对 [loadData()]的业务异常进行捕捉，但由于其位置的特殊性，
/// 使页面内其他的接口异常无法捕捉到，为此提供下面的功能。
/// 页面或者widget[PageState],[WidgetState]需要对api所触发的业务异常进行监听时
/// 可以为ViewModel混入此类

mixin ExceptionBinding on ViewStateModel implements ExceptionListener{
  ExceptionListener _listener;
  ///混入此类后，实现[ExceptionListener]并调用此方法进行注册
  bindToExceptionHandler(ExceptionListener listener){
    if(listener == null) return;
    _listener = listener;
    addExceptionListener();
  }

  ///增加(业务)异常监听
  addExceptionListener(){
    ExceptionPitcher().addListener(_listener);
  }
  ///移除(业务)异常监听
  /// * 默认会在dispose中自动移除
  removeExceptionListener(){
    if(_listener != null)
      ExceptionPitcher().removeListener(_listener);
  }


  ///理论上，不需要你手动移除[ExceptionListener]，此处会自动处理
  @override
  void dispose() {
    removeExceptionListener();
    super.dispose();
  }

}
