/*
* Author : LiJiqqi
* Date : 2020/5/29
*/

import 'package:flutter_bedrock/base_framework/config/net/bedrock_http.dart';
import 'package:flutter_bedrock/base_framework/exception/un_authorized_exception.dart';
import 'package:flutter_bedrock/base_framework/exception/un_handle_exception.dart';
import 'package:flutter_bedrock/base_framework/exception/user_unbind_exception.dart';

class ExceptionPitcher{
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

  Future throwException(ResponseData responseData){
    switch(responseData.code){
      case 30001:
        throw UnAuthorizedException();
      case 30003:
        throw UserUnbindException(responseData.message??"user unBind");
      default:
        throw UnHandleException(responseData.message??"un handle exception");
    }
  }

}



