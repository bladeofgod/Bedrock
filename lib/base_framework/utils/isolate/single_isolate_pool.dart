


import 'dart:async';
import 'dart:collection';
import 'dart:isolate';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

const String kChildPortKey = 'c_port_key';

const String kIsolateDead='kIsolateDead';

//unit : seconds
const int kKeepAliveTime = 60;

///_waitLine.key = _resultLine.key

bool isProcessing = false;

///child isolate
void _processTask(SendPort sendPort)async{

  /// value : task method
  final LinkedHashMap<String,Function> _waitLine = LinkedHashMap();
  /// value : result callback
  final LinkedHashMap<String,Function> _resultLine = LinkedHashMap();

  debugPrint('isolate start process');
  ///count passed seconds
  int passedTime = 0;
  final Timer timer = Timer.periodic(Duration(seconds: 1), (t){
    passedTime +=1;
    debugPrint('isolate passed time :$passedTime');
  });



  final childPort = ReceivePort();
  sendPort.send([kChildPortKey,childPort.sendPort]);

  ///子线程监听
  childPort.listen((message) {
    debugPrint('child : $message');
    if(message[0] == 'task'){
      _waitLine.addEntries(message[1]);
      debugPrint('${_waitLine.toString()}');
    }
  });

  while(_waitLine.length >0 || passedTime <= kKeepAliveTime){
    debugPrint('do while');
    debugPrint('child line  ${_waitLine.length}');
    if(!isProcessing && _waitLine.length>0){

      debugPrint('process');
      passedTime = 0;
      isProcessing = true;
      var entry = _waitLine.entries.first;
      final String key = entry.key;
      var result = await entry.value();
      debugPrint('result $result');
      ///must list and length == 2
      sendPort.send([key,result]);
    }
  }
  /// isolate dead;
  sendPort.send([kIsolateDead,'']);
}

class SingleIsolatePool{

//  //seconds
//  final int keepAliveTime;

  /// value : task method
  final LinkedHashMap<String,Function> _waitLine = LinkedHashMap();
  /// value : result callback
  final LinkedHashMap<String,Function> _resultLine = LinkedHashMap();


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
    debugPrint('main line clear  ${_waitLine.length}');
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

    _receivePort.listen((message) {
      debugPrint('$message');
      String key = message[0];
      var result = message[1];
      if(key == kChildPortKey){
        /// hold child isolate port
        _childSendPort = result;
        callProceed();
      }else if(_resultLine.containsKey(key)){
        _resultLine[key](result);
        _clearLine(key);
        callProceed();
      }else if(key == kIsolateDead){
        ///isolate dead
        _clearLine('');
      }
      ///waste time
//      if(message is List){
//        if(message.length == 2){
//        }
//      }

    },);
  }

  void callProceed(){
    if(_childSendPort != null){
      if(_waitLine.length >0){
        _childSendPort.send(['task',_waitLine.entries.first]);
      }
    }
  }


  void executeTask(Function task,Function resultCallback){
    final String key = '${task.hashCode + DateTime.now().microsecondsSinceEpoch}';
    debugPrint('task key $key');
    _waitLine[key] = task;
    _resultLine[key] = resultCallback;
    debugPrint('main line  ${_waitLine.length}');

    if(_isolate == null){
      debugPrint('init');
      ///执行任务时再去初始化
      _init();
    }

  }


}