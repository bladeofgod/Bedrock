/*
* Author : LiJiqqi
* Date : 2020/8/27
*/


import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:flutter/cupertino.dart';


const String kNetPortKey = 'kNetPortKey';

const String kNetType = 'kNetType';
const String kWifi = 'kWifi',kMobile = 'kMobile';

const String kNetAvailable = 'kNetAvailable';
const String kNetEnable = 'kEnable',kNetDisable = 'kDisable';

void observerNetState(SendPort sendPort){
  final String china = 'baidu.com';
  final String usa = 'google.com';
  final ReceivePort receivePort = ReceivePort();
  sendPort.send([kNetPortKey,receivePort.sendPort]);

  receivePort.listen((message) {
    debugPrint('$kNetPortKey  : $message');
  });

  final timer = Timer.periodic(Duration(seconds: 10), (timer) async{
    try{
      ///注意区分国内外，或者用你自己的
      String host = china;
      final result =  await InternetAddress.lookup(host);
      debugPrint('$kNetPortKey  $result');
      if(result.isNotEmpty && result[0].rawAddress.isNotEmpty){
        sendPort.send([kNetAvailable,kNetEnable]);
      }else{
        sendPort.send([kNetAvailable,kNetDisable]);
      }

    }on SocketException catch(_){
      sendPort.send([kNetAvailable,kNetDisable]);

    }
  });


}