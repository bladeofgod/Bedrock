/*
* Author : LiJiqqi
* Date : 2020/9/1
*/


import 'dart:async';
import 'dart:isolate';




/*
* sendPort发送的messages格式统一为 [key,dynamic]，ps：这是list不是map ！
* 格式保持一致，减少if嵌套
*
* */

const int kSendPortKey = 6633;//第二个元素则为 sendPort

const int kTaskKey = 8844; // 第二个元素为task

///
const String kMethodName = 'kMethodName';
const String kNameArgs = 'kNameArgs';



final List<String> orders = [];

void main( args,SendPort mainPort)async{

  ///connect with main isolate
  final ReceivePort receivePort = ReceivePort();
  final SendPort sendPort = receivePort.sendPort;
  receivePort.listen((message) {
    print('msg from main  $message');
    if(message[0] == kTaskKey){
      orders.add(message[1]);
    }

  });

  mainPort.send([kSendPortKey,sendPort]);

  ///connect with child isolate

  final ReceivePort proxyPort = ReceivePort();
  final SendPort proxySendPort = proxyPort.sendPort;
  final Isolate isolate = await Isolate.spawnUri(new Uri(path: './worker_isolate.dart'), args, proxySendPort);

  SendPort childSendPort;

  proxyPort.listen((message) {
    print('msg from child $message');
    if(message[0] == kSendPortKey){
      childSendPort = message[1];
      runTask(childSendPort);
    }

  });


}

void runTask(SendPort port){
  final timer = Timer.periodic(Duration(seconds: 1), (timer) {
    String methodName = orders.first;
    port.send([kTaskKey,{kMethodName:methodName,
      kNameArgs:{'bb':'你好'}}]);
    orders.removeWhere((element) => element==methodName);
  });
}








