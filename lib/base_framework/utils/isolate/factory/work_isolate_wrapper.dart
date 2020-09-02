/*
* Author : LiJiqqi
* Date : 2020/9/2
*/

import 'dart:async';
import 'dart:isolate';

import 'package:flutter_bedrock/base_framework/utils/isolate/factory/worker_isolate.dart';

class WorkIsolateWrapper {
  final ReceivePort proxyPort;

  final SendPort proxySendPort;

  final Isolate _isolate;

  WorkIsolateWrapper(this.proxyPort, this.proxySendPort, this._isolate);

  ///是否空闲
  bool _isFree = true;
  bool isStandBy()=> _isFree&&initSuccess;
  setStatus(bool status){
    _isFree = status;
  }

  SendPort workSendPort;
  bool initSuccess = false;
  init() {
    _isolate.resume(_isolate.pauseCapability);
    proxyPort.listen((message) {
      print('msg from child $message');
      if (message[0] == kSendPortKey) {
        workSendPort = message[1];
        initSuccess = true;
      }
    });
  }
}
