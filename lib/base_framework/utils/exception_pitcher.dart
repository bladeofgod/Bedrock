/*
* Author : LiJiqqi
* Date : 2020/5/29
*/

import 'dart:collection';

import 'package:flutter_bedrock/base_framework/config/net/base_http.dart';
import 'package:flutter_bedrock/base_framework/config/net/bedrock_http.dart';
import 'package:flutter_bedrock/base_framework/exception/un_authorized_exception.dart';
import 'package:flutter_bedrock/base_framework/exception/un_handle_exception.dart';
import 'package:flutter_bedrock/base_framework/exception/user_unbind_exception.dart';




class ExceptionPitcher with _ExceptionNotifyBinding{
  static ExceptionPitcher _instance;
  factory ExceptionPitcher()=>getSingleton();
  ExceptionPitcher._internal(){
    //todo
  }

  static ExceptionPitcher getSingleton(){
    if(_instance == null){
      _instance = ExceptionPitcher._internal();
    }
    return _instance;
  }



  /// * 根据code 转换Exception
  Exception transformException(ResponseData responseData){
    assert(responseData!=null,'responseData can not be null!');
    final Exception exception = _transferException(responseData);

    return exception;

  }
  /// 异常分拣
  Exception _transferException(ResponseData responseData){
    switch(responseData.code){
    ///仅为以下测试代码
      case -2:
      case 30001:
        return UnAuthorizedException();
      case 30003:
        return UserUnbindException(responseData.message??"user unBind");
      default:
        return UnHandleException(responseData.message??"un handle exception");
    }
  }

}

/// mixin [_ExceptionNotifyBinding] can notified a Exception to all the [ExceptionListener] listener.

mixin _ExceptionNotifyBinding{
  final LinkedList<_ExceptionPackage> _packages = LinkedList<_ExceptionPackage>();

  /// 增加一个回调，页面发生时，会通知所有listener
  /// 页面使用后务必移除 [removeListener]
  void addListener(ExceptionListener listener){
    _packages.add(_ExceptionPackage(listener));

  }

  /// 移除一个回调
  void removeListener(ExceptionListener listener){
    for(final _ExceptionPackage package in _packages){
      if(package._listener == listener){
        package.unlink();
        return;
      }
    }
  }

}


/// api 异常监听回调
abstract class ExceptionListener<E extends Exception,T extends BaseResponseData>{
  /// what kind of [exception] was happened,with api's [rawData]
  void notifyException({E exception,T rawData});
}


/// package  exception with listener
class _ExceptionPackage extends LinkedListEntry<_ExceptionPackage>{

  final ExceptionListener _listener;

  _ExceptionPackage(this._listener);

}



