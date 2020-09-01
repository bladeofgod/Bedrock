/*
* Author : LiJiqqi
* Date : 2020/9/1
*/


import 'dart:async';
import 'dart:isolate';



import 'package:reflectable/reflectable.dart';

import '../../../../main.dart';
import '../../../../main.reflectable.dart';




/*
* sendPort发送的messages格式统一为 [key,dynamic]
*
*
* */
const int kSendPortKey = 6633;//第二个元素则为 sendPort

const int kTaskKey = 8844; // 第二个元素为task

///
const String kMethodName = 'kMethodName';
const String kNameArgs = 'kNameArgs';

final List<String> orders = [];

/*
* 此类在 main isolate
* */
class WorkerMainProxy{
  static WorkerMainProxy _instance;
  static WorkerMainProxy getInstance(){
    if(_instance == null){
      _instance = WorkerMainProxy._();
    }
    return _instance;
  }

  factory WorkerMainProxy()=>getInstance();


  WorkerMainProxy._();

  void callTask()async{

    final ReceivePort receivePort = ReceivePort();
    Isolate isolate = await Isolate.spawn(proxyHandler, receivePort.sendPort);
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

/*
* 中间代理isolate
*
* */

void proxyHandler(SendPort mainPort)async{
  final ReceivePort receivePort = ReceivePort();
  final SendPort sendPort = receivePort.sendPort;
  receivePort.listen((message) {
    print('msg from main  $message');
    if(message[0] == kTaskKey){
      orders.add(message[1]);
    }

  });

  mainPort.send([kSendPortKey,sendPort]);

  ///connect with child isolate


  final ReceivePort proxyPort = ReceivePort();
  final SendPort proxySendPort = proxyPort.sendPort;
  final Isolate isolate = await Isolate.spawn(_workerIsolate, proxySendPort);

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

/*
* 工作isolate
*
* */

void _workerIsolate(SendPort proxyPort){
  initializeReflectable();



  final ReceivePort receivePort = ReceivePort();
  final SendPort sendPort = receivePort.sendPort;

  receivePort.listen((message) {
    if(message[0] == kTaskKey){
      ///执行任务
      print('call method ${message[1]}');
      Map method = message[1];
      String mn = method[kMethodName];
      Map<Symbol,dynamic> nameArguments = {};
      if(method[kNameArgs] is Map){
        ///为了避免顺序错误导致的参数异常，这里不使用positionalArguments
        (method[kNameArgs] as Map).forEach((key, value) {
          nameArguments[Symbol(key)] = value;
        });
        final WorkList workerList = WorkList();
        final InstanceMirror instanceMirror = myReflect.reflect(workerList);
        final ClassMirror classMirror = myReflect.reflectType(WorkList);
        instanceMirror.invoke(mn, []);
      }


    }

  });

  proxyPort.send([kSendPortKey,sendPort]);


}


























