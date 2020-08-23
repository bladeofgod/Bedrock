


import 'dart:collection';
import 'dart:isolate';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

const String childPortKey = 'c_port_key';

///_waitLine.key = _resultLine.key

/// value : task method
final LinkedHashMap<String,Function> _waitLine = LinkedHashMap();
/// value : result callback
final LinkedHashMap<String,Function> _resultLine = LinkedHashMap();

bool isProcessing = false;

///child isolate
void _processTask(SendPort sendPort)async{
  final childPort = ReceivePort();
  sendPort.send([childPortKey,childPort.sendPort]);

  ///子线程监听
  childPort.listen((message) {
    debugPrint('child : $message');
  });
  while(_waitLine.length >0){
    if(!isProcessing){
      isProcessing = true;
      var entry = _waitLine.entries.first;
      final String key = entry.key;
      var result = await entry.value();
      ///must list and length == 2
      sendPort.send([key,result]);
//        if(_resultLine.containsKey(key)){
//          ///call result-callback
//          _resultLine[key](result);
//        }
    }
  }
}

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


  void clearLine(String expiredKey){
    _waitLine.removeWhere((key, value) => key == expiredKey);
    _resultLine.removeWhere((key, value) => key == expiredKey);
    isProcessing = false;
  }

  void init()async{
    _isolate = await Isolate.spawn(_processTask, receivePort.sendPort);
    childSendPort = await receivePort.first;
    receivePort.listen((message) {
      debugPrint('$message');
      String key = message[0];
      var result = message[1];
      if(key == childPortKey){
        childSendPort = result;
      }else if(_resultLine.containsKey(key)){
        _resultLine[key](result);
      }
      clearLine(key);
      ///waste time
//      if(message is List){
//        if(message.length == 2){
//        }
//      }

    },);
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


}