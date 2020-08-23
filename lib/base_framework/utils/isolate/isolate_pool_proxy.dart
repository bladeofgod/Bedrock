


import 'package:flutter_bedrock/base_framework/utils/isolate/standard_isolate_pool.dart';

class IsolatePoolProxy{

  IsolatePoolProxy._();

  static IsolatePoolProxy instance;

  factory IsolatePoolProxy() => getInstance();

  static IsolatePoolProxy getInstance(){
    if(instance == null){
      instance = IsolatePoolProxy._();
    }
    return instance;
  }


  ///获取标准线程池

  StandardIsolatePool getStandardPool(){
    return StandardIsolatePool.getInstance();
  }



}















