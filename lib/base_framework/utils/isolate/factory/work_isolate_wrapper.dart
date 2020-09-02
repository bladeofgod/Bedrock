/*
* Author : LiJiqqi
* Date : 2020/9/2
* 注意： 请勿使用任何dart:ui内的东西（即涉及到flutter的代码）
*/

import 'dart:async';
import 'dart:isolate';

import 'package:flutter_bedrock/base_framework/utils/isolate/factory/worker_isolate.dart';


class WorkIsolateWrapper {
  final int id;
  final ReceivePort proxyPort;

  final SendPort proxySendPort;

  final Isolate _isolate;

  WorkIsolateWrapper(this.id,this.proxyPort, this.proxySendPort, this._isolate);

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
      if (message[0] == kSendPortKey) {
        workSendPort = message[1];
        initSuccess = true;
      }else if(message[0] == kWorkDone){
        ///work done
        setStatus(true);
        print('isolate $id  完成了 ：${message[1].toString()}');
      }
    });
  }
}
