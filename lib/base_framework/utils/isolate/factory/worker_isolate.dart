/*
* Author : LiJiqqi
* Date : 2020/9/1
*/


import 'dart:isolate';


import 'package:flutter_bedrock/base_framework/utils/isolate/factory/worker_isolate.reflectable.dart';
import 'package:reflectable/reflectable.dart';

/*
* 在此处添加你要执行的方法，之后在terminal运行下方代码
* flutter packages pub run build_runner build
*
* 为了避免顺序错误导致的参数异常，这里不使用positionalArguments
*
* */

@myReflect
class WorkList{

  void test({String bb}){
    print('  name $bb');
  }

}




/*
* sendPort发送的messages格式统一为 [key,dynamic]
*
*
* */
const int kSendPortKey = 6633;//第二个元素则为 sendPort

const int kTaskKey = 8844; // 第二个元素为task

///
const String kMethodName = 'kMethodName';
const String kNameArgs = 'kNameArgs';



void main(List args,SendPort proxyPort){
  initializeReflectable();

  final WorkList _workerList = WorkList();
  final InstanceMirror instanceMirror = myReflect.reflect(_workerList);
  final ClassMirror classMirror = myReflect.reflectType(WorkList);

  final ReceivePort receivePort = ReceivePort();
  final SendPort sendPort = receivePort.sendPort;

  receivePort.listen((message) {
    if(message[0] == kTaskKey){
      ///执行任务
      print('call method ${message[1]}');
      Map method = message[1];
      String mn = method[kMethodName];
      Map nameArguments = method[kNameArgs];
      ///为了避免顺序错误导致的参数异常，这里不使用positionalArguments
      instanceMirror.invoke(mn, [],nameArguments);

    }

  });

  proxyPort.send([kSendPortKey,sendPort]);


}





const myReflect = MyReflectable();

class MyReflectable extends Reflectable{
  const MyReflectable():super(invokingCapability);
}























