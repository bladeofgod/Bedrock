


import 'dart:async';
import 'dart:collection';
import 'dart:isolate';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

const String childPortKey = 'c_port_key';

//unit : seconds
const int keepAliveTime = 60;

///_waitLine.key = _resultLine.key

/// value : task method
final LinkedHashMap<String,Function> _waitLine = LinkedHashMap();
/// value : result callback
final LinkedHashMap<String,Function> _resultLine = LinkedHashMap();

bool isProcessing = false;

///child isolate
void _processTask(SendPort sendPort)async{
  ///count passed seconds
  int passedTime = 0;
  final Timer timer = Timer.periodic(Duration(seconds: 1), (t){
    passedTime +=1;
    debugPrint('isolate passed time :$passedTime');
  });



  final childPort = ReceivePort();
  sendPort.send([childPortKey,childPort.sendPort]);

  ///子线程监听
  childPort.listen((message) {
    debugPrint('child : $message');
  });

  while(_waitLine.length >0 || passedTime <= keepAliveTime){
    if(!isProcessing && _waitLine.length>0){
      if(_waitLine.length>0){
        passedTime = 0;
        isProcessing = true;
        var entry = _waitLine.entries.first;
        final String key = entry.key;
        var result = await entry.value();
        ///must list and length == 2
        sendPort.send([key,result]);

      }
    }
  }
}

class SingleIsolatePool{

//  //seconds
//  final int keepAliveTime;

  ///当前线程
  final _receivePort = ReceivePort();
  Isolate _isolate ;

  ///子线程
  SendPort _childSendPort;

  SingleIsolatePool._();

  static SingleIsolatePool _singleton;
  static SingleIsolatePool getInstance(){
    if(_singleton == null){
      _singleton = SingleIsolatePool._();
    }
    return _singleton;
  }


  void _clearLine(String expiredKey){
    _waitLine.removeWhere((key, value) => key == expiredKey);
    _resultLine.removeWhere((key, value) => key == expiredKey);
    if(_waitLine.isEmpty || _resultLine.isEmpty){
      _waitLine.clear();
      _resultLine.clear();
      _releaseIsolate();
    }
    isProcessing = false;

  }

  void _releaseIsolate(){
    _isolate?.kill();
    _isolate = null;
    _receivePort?.close();
    _childSendPort = null;
  }


  void _init()async{
    _isolate = await Isolate.spawn(_processTask, _receivePort.sendPort);
    _childSendPort = await _receivePort.first;
    _receivePort.listen((message) {
      debugPrint('$message');
      String key = message[0];
      var result = message[1];
      if(key == childPortKey){
        _childSendPort = result;
      }else if(_resultLine.containsKey(key)){
        _resultLine[key](result);
      }
      _clearLine(key);
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
      _init();
    }
    final String key = '${task.hashCode + DateTime.now().microsecondsSinceEpoch}';
    debugPrint('task key $key');
    _waitLine[key] = task;
    _resultLine[key] = resultCallback;

  }


}