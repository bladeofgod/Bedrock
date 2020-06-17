/*
* Author : LiJiqqi
* Date : 2020/6/16
*/

import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bedrock/base_framework/view_model/interface/cache_data_factory.dart';
import 'package:oktoast/oktoast.dart';
import 'package:flutter_bedrock/base_framework/exception/un_authorized_exception.dart';
import 'package:flutter_bedrock/base_framework/exception/user_unbind_exception.dart';
import 'package:flutter_bedrock/base_framework/view_model/view_state_model.dart';

class ExceptionHandler{

  static ExceptionHandler _singleton;

  static ExceptionHandler getInstance(){
    if(_singleton == null){
      _singleton = ExceptionHandler._();
    }
    return _singleton;
  }

  ExceptionHandler._();


  /// Handle Error and Exception
  ///
  /// 统一处理子类的异常情况
  /// [e],有可能是Error,也有可能是Exception.所以需要判断处理
  /// [s] 为堆栈信息
  void handleException<T extends ViewStateModel>(T model,e,s){
    debugPrint("e :    $e");
    debugPrint("s :    $s");
    if(e is DioError){
      if(e.error is UnAuthorizedException){
        model.setUnAuthorized();
      }
      if(e.error is UserUnbindException){
        model.setUnBind();
      }
      if(e.type == DioErrorType.CONNECT_TIMEOUT ){
        //todo
      }
      ///以下是demo 代码，实际项目最好删除掉
      assert((){
        ///我没有服务器，为了测试未登录下请求接口，并捕获抛出的未登录异常，
        ///这里将dio抛出的SocketException（因为使用了www.baidu.com当做服务地址，所以请求接口时会抛出这个异常）
        ///当做咱们抛出的未登录异常，并对他处理
        if(e.error is SocketException){
          model.setUnAuthorized();
        }
        return true;
      }());

    }
  }


}




















