


import 'dart:isolate';

const kServeNotifyPortKey = 'kServeNotifyPortKey';

void observeServerNotify(SendPort sendPort){
  
  final ReceivePort receivePort = ReceivePort();
  
  sendPort.send(receivePort)
  
}





















