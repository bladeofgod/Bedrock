

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/foundation.dart';
import '../../utils/exception_pitcher.dart';
import 'package:flutter_bedrock/base_framework/config/net/base_http.dart';
import 'package:flutter_bedrock/base_framework/config/storage_manager.dart';
import 'package:flutter_bedrock/base_framework/exception/un_authorized_exception.dart';
import 'package:flutter_bedrock/base_framework/exception/un_handle_exception.dart';
import 'package:flutter_bedrock/base_framework/exception/user_unbind_exception.dart';


final BedRock bedRock = BedRock();


class BedRock extends BaseHttp{

  final String china = "https://apitripalink.com/";

  @override
  void init() {

    options.baseUrl = china;
    interceptors
      ..add(CookieManager(PersistCookieJar(dir: StorageManager.temporaryDirectory.path)))
      ..add(ApiInterceptor());
  }

}



class ApiInterceptor extends InterceptorsWrapper{

  @override
  Future onRequest(RequestOptions options) async{
    ///这里将空值参数去除掉，可根据自己的需求更改
    options.queryParameters.removeWhere((key, value) => value == null);

    String params="";
    String mark = "&";

    if(!kReleaseMode){
      debugPrint('---api-request--->url--> ${options.baseUrl}${options.path}' +
          ' queryParameters: ${options.queryParameters}'
              ' formdata  : ${options.data.toString()}' );
      options.queryParameters.forEach((k,v){
        if(v == null) return;
        params = "$params${params.isEmpty?"":mark}$k=$v";
      });
      debugPrint("---api-request--->url--> ${options.baseUrl}${options.path}?$params");
    }




    //debugPrint("request header  :  ${options.headers.toString()}");
    return options;
  }


  @override
  Future onResponse(Response response) {

    ResponseData responseData = ResponseData.fromJson(response.data);
    if(responseData.success){
      return bedRock.resolve(responseData);
    }else{
      ///这里可以根据不同的业务代码 扔出不同的异常
      ///具体要根据后台进行协商
      return ExceptionPitcher().throwException(responseData);//不加return会有黄色警告，纯属美观
    }


  }


}





class ResponseData extends BaseResponseData {
  bool get success => (code == 1 || code == 200);

  ResponseData.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'];
  }
}