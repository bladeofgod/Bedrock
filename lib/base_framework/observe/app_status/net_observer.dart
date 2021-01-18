/*
* Author : LiJiqqi
* Date : 2020/8/28
*/

import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



/*
* 注意，此方法在child_isolate
* 返回值为List
* */

/// 第一个元素等于此key，则第二个元素为 child isolate 的sendPort
const String kNetPortKey = 'kNetPortKey';

///第一个元素为[kNetAvailable]
const String kNetAvailable = 'kNetAvailable';
///第二个元素则为下面的其中之一
const String kNetEnable = 'kEnable',kNetDisable = 'kDisable';


const int intervalTime = 10;

void observerNetState(SendPort sendPort){
  final String china = 'baidu.com';
  final String usa = 'google.com';
  final ReceivePort receivePort = ReceivePort();
  receivePort.listen((message) {
    debugPrint('$kNetPortKey  : $message');
  });

  sendPort.send([kNetPortKey,receivePort.sendPort]);



  final timer = Timer.periodic(Duration(seconds: intervalTime), (timer) async{
    try{
      ///注意区分国内外，或者用你自己的
      String host = china;
      final result =  await InternetAddress.lookup(host);
      debugPrint('$kNetPortKey  $result');
      if(result.isNotEmpty && result[0].rawAddress.isNotEmpty){
        ///net enable
        sendPort.send([kNetAvailable,kNetEnable]);
      }else{
        sendPort.send([kNetAvailable,kNetDisable]);
      }

    }on SocketException catch(_){
      sendPort.send([kNetAvailable,kNetDisable]);

    }
  });


}