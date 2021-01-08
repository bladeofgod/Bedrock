

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bedrock/base_framework/view_model/handle/exception_handler.dart';
import 'package:flutter_bedrock/base_framework/view_model/view_state_model.dart';
import '../../utils/exception_pitcher.dart';
import 'package:flutter_bedrock/base_framework/config/net/base_http.dart';
import 'package:flutter_bedrock/base_framework/config/storage_manager.dart';



final BedRock bedRock = BedRock();


class BedRock extends BaseHttp{

  final String china = "https://wanandroid.com/";


  @override
  void init() {

    options.baseUrl = china;
    interceptors
      ..add(CookieManager(PersistCookieJar(dir: StorageManager.appDirectory.path)))
      ..add(ApiInterceptor())
      ..add(LogInterceptor());
  }

}



class ApiInterceptor extends InterceptorsWrapper{

  @override
  Future onRequest(RequestOptions options) async{
    ///这里将空值参数去除掉，可根据自己的需求更改
//    options.queryParameters.removeWhere((key, value) => value == null);
//
//    String params="";
//    String mark = "&";
//
//    if(!kReleaseMode){
//      debugPrint('---api-request--->url--> ${options.baseUrl}${options.path}' +
//          ' queryParameters: ${options.queryParameters}'
//              ' formdata  : ${options.data.toString()}' );
//      options.queryParameters.forEach((k,v){
//        if(v == null) return;
//        params = "$params${params.isEmpty?"":mark}$k=$v";
//      });
//      debugPrint("---api-request--->url--> ${options.baseUrl}${options.path}?$params");
//    }




    //debugPrint("request header  :  ${options.headers.toString()}");
    return options;
  }

  ///这里可以根据不同的业务代码 扔出不同的异常
  ///具体要根据后台进行协商
  /// [ViewStateModel] 的子类会对此处进行捕捉，捕捉后逻辑可以在[ExceptionHandler]中处理
  /// * 此处的异常捕捉功能仅在[loadData]中有效
  /// * 如果需要独立收到Api的业务异常，见此类[ExceptionBinding]

  @override
  Future onResponse(Response response) {

    ResponseData responseData = ResponseData.fromJson(response.data);
    if(responseData.success){
      return bedRock.resolve(responseData);
    }else{
      ///抛出业务异常
      throw ExceptionPitcher().transformException(responseData);
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