


import 'dart:collection';
import 'dart:isolate';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

final LinkedHashMap<String,Function> _waitLine = LinkedHashMap();
final LinkedHashMap<String,Function> _resultLine = LinkedHashMap();

bool isProcessing = false;

class SingleIsolatePool{


  ///当前线程
  final receivePort = ReceivePort();
  Isolate _isolate ;

  ///子线程
  SendPort childSendPort;

  SingleIsolatePool._();

  static SingleIsolatePool _singleton;
  static SingleIsolatePool getInstance(){
    if(_singleton == null){
      _singleton = SingleIsolatePool._();
    }
    return _singleton;
  }

  void init()async{
    _isolate = await Isolate.spawn(processTask, receivePort.sendPort);
    childSendPort = await receivePort.first;
  }


  void executeTask(Function task,Function resultCallback){
    if(_isolate == null){
      ///执行任务时再去初始化
      init();
    }
    final String key = '${task.hashCode + DateTime.now().microsecondsSinceEpoch}';
    debugPrint('task key $key');
    _waitLine[key] = task;
    _resultLine[key] = resultCallback;

  }


  ///child isolate
  void processTask(SendPort sendPort)async{
    final childPort = ReceivePort();
    sendPort.send(childPort.sendPort);

    ///子线程监听
    await for(var msg in childPort){}
//    while(_waitLine.length > 0){
//      if(!isProcessing){
//        isProcessing = true;
//
//      }
//    }
  }

  void dodo(String msg){
    print(msg);
  }







}