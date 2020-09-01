


import 'dart:async';
import 'dart:isolate';







/*
* 2020年8月24日15:36:58
* 设计有问题需要重新规划，不要使用此功能
* */

const int kSendPortKey = 6633;//第二个元素则为 sendPort

const int kTaskKey = 8844; // 第二个元素为task


///
const String kMethodName = 'kMethodName';
const String kNameArgs = 'kNameArgs';

final List<String> orders = [];

void handle(SendPort mainPort)async{
  final ReceivePort receivePort = ReceivePort();
  final SendPort sendPort = receivePort.sendPort;
  receivePort.listen((message) {
    print('msg from main  $message');
    if(message[0] == kTaskKey){

    }

  });

  mainPort.send([kSendPortKey,sendPort]);

  ///connect with child isolate


  final ReceivePort proxyPort = ReceivePort();
  final SendPort proxySendPort = proxyPort.sendPort;
  final Isolate isolate = await Isolate.spawnUri(new Uri(path:
  'package:flutter_bedrock/base_framework/utils/isolate/factory/worker_isolate.dart'),
      [], proxySendPort);

  SendPort childSendPort;

  proxyPort.listen((message) {
    print('msg from child $message');
    if(message[0] == kSendPortKey){
      childSendPort = message[1];
      runTask(childSendPort);
    }

  });

}

void runTask(SendPort port){
  final timer = Timer.periodic(Duration(seconds: 1), (timer) {
    String methodName = orders.first;
    port.send([kTaskKey,{kMethodName:methodName,
      kNameArgs:{'bb':'你好'}}]);
    orders.removeWhere((element) => element==methodName);
  });
}

///

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




  void callTask()async{

    final ReceivePort receivePort = ReceivePort();
    Isolate isolate = await Isolate.spawn(handle, receivePort.sendPort);
    SendPort childPort;
    receivePort.listen((message) {
      print('msg from proxy $message');
      if(message[0] == kSendPortKey){
        childPort = message[1];
        childPort.send([kTaskKey,'test']);
      }
    });



  }



}















