


import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bedrock/base_framework/config/net/bedrock_http.dart';
import 'package:flutter_bedrock/base_framework/utils/platform_utils.dart';

import '../frame_constant.dart';

// 必须是顶层函数
_parseAndDecode(String response) {
  return jsonDecode(response);
}

parseJson(String text) {
  return compute(_parseAndDecode, text);
}

//具体应用配置http类继承此类
abstract class BaseHttp extends DioForNative{

  final CancelToken rootCancelToken = CancelToken();

  BaseHttp(){
    ///json 解析放在了子isolate，不过按文档来看，这个解析速度要慢于直接解析
    ///优点就是不会造成ui卡顿（前提是你的json数据非常大）
    ///需要自身来评估
    (transformer as DefaultTransformer).jsonDecodeCallback = parseJson;
    interceptors
          ..add(new HeaderInterceptor());

    init();
  }

  void init();

  cancelAllRequest(){
    _cancelToken.cancel(['no available net']);
  }

}

///默认项目所有cancelToken使用这一个，用于断网下取消
///如有特殊需要可以 在ApiInterceptor进行覆盖或者注释
final CancelToken _cancelToken = CancelToken();


///添加拦截器
class HeaderInterceptor extends InterceptorsWrapper{
  @override
  Future onRequest(RequestOptions options) async{
    options.connectTimeout = 1000 * 45;
    options.receiveTimeout = 1000 * 45;

    options.cancelToken = _cancelToken;

    ///这里加入版本信息 在header，可以根据需求更改
    var appVersion = await PlatformUtils.getAppVersion();
    var deviceInfo = SpUtil.getString(BaseFrameConstant.DEVICE_UUID);

    //var token = CookieManager.getCookies(cookies);

    var version = Map()
      ..addAll({
        'appVersion': appVersion,
      });
    options.headers['version'] = version;
    options.headers['platform'] = Platform.operatingSystem;
    options.headers['clint_id'] = deviceInfo;
    return options;
  }


}

/// 子类需要重写
abstract class BaseResponseData {
  int code = 0;
  String message;
  dynamic data;

  bool get success;

  BaseResponseData({this.code, this.message, this.data});

  @override
  String toString() {
    return 'BaseRespData{code: $code, message: $message, data: $data}';
  }
}










