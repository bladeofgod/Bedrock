


import 'dart:async';
import 'dart:isolate';

import 'package:flutter/cupertino.dart';

const kServeNotifyPortKey = 'kServeNotifyPortKey';

///对服务器通知进行监测
///实际上这个功能在主线程实现也没有什么问题，
///不过一些特殊需求可能放在子线程（隔离 不太顺口）比较好

void observeServerNotify(SendPort sendPort){
  
  final ReceivePort receivePort = ReceivePort();

  receivePort.listen((message) {
    debugPrint('$kServeNotifyPortKey   :  $message');
  });
  sendPort.send(receivePort.sendPort);

  final timer = Timer.periodic(Duration(seconds: 60), (timer) {
    ///do your stuff here

    ///var result  = requestAPI();
    ///sendPort.send([key,result]);
  });
  
}





















