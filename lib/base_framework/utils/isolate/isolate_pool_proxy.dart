


import 'dart:isolate';





/*
* 2020年8月24日15:36:58
* 设计有问题需要重新规划，不要使用此功能
* */


class IsolatePoolProxy{

  IsolatePoolProxy._();

  static IsolatePoolProxy _instance;

  factory IsolatePoolProxy() => getInstance();

  static IsolatePoolProxy getInstance(){
    if(_instance == null){
      _instance = IsolatePoolProxy._();
    }
    return _instance;
  }

  final int kSendPortKey = 6633;//第二个元素则为 sendPort

  final int kTaskKey = 8844; // 第二个元素为task

  ///
  final String kMethodName = 'kMethodName';
  final String kNameArgs = 'kNameArgs';


  void callTask()async{
    Uri uri = Uri.parse('package:flutter_bedrock/base_framework/utils/isolate/factory/proxy_isolate.dart');

    final ReceivePort receivePort = ReceivePort();
    Isolate isolate = await Isolate.spawnUri(uri,
        [], receivePort.sendPort);
    SendPort childPort;
    receivePort.listen((message) {
      print('msg from proxy $message');
      if(message[0] == kSendPortKey){
        childPort = message[1];
        childPort.send([kTaskKey,'test']);
      }
    });



  }


  ///获取标准线程池

//  StandardIsolatePool getStandardPool(){
//    return StandardIsolatePool.getInstance();
//  }
//
//  SingleIsolatePool getSinglePoll(){
//    return SingleIsolatePool.getInstance();
//  }



}















