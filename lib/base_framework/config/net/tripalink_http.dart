

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/foundation.dart';
import 'package:tripalink/base_framework/config/net/base_http.dart';
import 'package:tripalink/base_framework/config/storage_manager.dart';
import 'package:tripalink/base_framework/exception/un_authorized_exception.dart';
import 'package:tripalink/base_framework/exception/un_caught_exception.dart';
import 'package:tripalink/base_framework/exception/user_unbind_exception.dart';
import 'package:tripalink/base_framework/exception/verification_code_exception.dart';

final TripaLinkHttp tripaLinkHttp = TripaLinkHttp();


class TripaLinkHttp extends BaseHttp{

  String cookie;

  final CookieManager cookieManager = CookieManager(
      PersistCookieJar(dir: StorageManager.temporaryDirectory.path)
  );

  @override
  void init() {
    //temp http://47.92.252.37/index.php?r=test/index
    //http://47.92.252.37/index.php?r=route/get-online
    options.baseUrl = "https://apitripalink.com/";
    interceptors
      ..add(ApiInterceptor())
      ..add(cookieManager);
  }

}



class ApiInterceptor extends InterceptorsWrapper{

  @override
  Future onRequest(RequestOptions options) async{

    //log();
//    debugPrint("------------cookie");
//    debugPrint("${CookieManager.getCookies(tripaLinkHttp.cookieManager.cookieJar.loadForRequest(options.uri))}");
//    debugPrint("------------cookie");
  if(tripaLinkHttp.cookie == null || tripaLinkHttp.cookie.isEmpty){
    String cookie = SpUtil.getString("cookie");
    options.headers["cookie"] = cookie;
  }else{
    options.headers["cookie"] = tripaLinkHttp.cookie??"";
  }


    debugPrint('---api-request--->url--> ${options.baseUrl}${options.path}' +
        ' queryParameters: ${options.queryParameters}'
        ' formdata  : ${options.data.toString()}' );
    String params="";
    String mark = "&";
    options.queryParameters.forEach((k,v){
      if(v == null) return;
      params = "$params${params.isEmpty?"":mark}$k=$v";
    });
    debugPrint("---api-request--->url--> ${options.baseUrl}${options.path}?$params");

    //debugPrint("request header  :  ${options.headers.toString()}");
    return options;
  }

  log(){

//    tripaLinkHttp.interceptors.forEach((inter){
//      debugPrint("${inter.toString()}");
//    });
  //tripaLinkHttp.cookieManager.);
  }


  @override
  Future onResponse(Response response) {
    //if(response == null || response.data == null) return null;
//    debugPrint("------------cookie");
//    debugPrint("${CookieManager.getCookies(tripaLinkHttp.cookieManager.cookieJar.loadForRequest(response.realUri))}");
//    debugPrint("------------cookie");
    //debugPrint("response header  :  ${response.headers.toString()}");
    //log();
    if(response.headers != null){
      if(response.headers.map["set-cookie"] != null && response.headers.map["set-cookie"].toString().isNotEmpty){
        tripaLinkHttp.cookie = response.headers.map["set-cookie"].toString();
        SpUtil.putString("cookie", tripaLinkHttp.cookie);
      }
    }
    ResponseData responseData = ResponseData.fromJson(response.data);
    if(responseData.success){
      return tripaLinkHttp.resolve(responseData);
    }else{
      ///这里可以根据不同的业务代码 扔出不同的异常
      ///具体要根据后台进行协商
      if(responseData.code ==  30001){
        throw new UnAuthorizedException();
      }
      if(responseData.code == 30003){
        //用户需要绑定
        throw new UserUnbindException();
      }
      throw new UnCaughtException();
      //return null;

    }

    return tripaLinkHttp.resolve(response);

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