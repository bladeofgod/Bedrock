/*
* Author : LiJiqqi
* Date : 2020/9/1
*/


import 'dart:async';
import 'dart:isolate';
import 'dart:math';



import 'package:flutter_bedrock/base_framework/utils/isolate/factory/task_warpper.dart';
import 'package:flutter_bedrock/base_framework/utils/isolate/factory/work_isolate_wrapper.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:reflectable/reflectable.dart';

import '../../../../main.dart';
import '../../../../main.reflectable.dart';




/*
* sendPort发送的messages格式统一为 [key,dynamic]
*
*
* */
const int kSendPortKey = 6633;//第二个元素则为 sendPort

const int kTaskKey = 8844; // 第二个元素为task

const int kTaskParamsKey = 10055; // 第二个元素为 方法对应的 参数

const int kTaskResult = 15500;//任务返回结果

///
const String kMethodName = 'kMethodName';
const String kNameArgs = 'kNameArgs';


/*
* 此类在 main isolate
* */
class WorkerMainProxy{
  static WorkerMainProxy _instance;
  static WorkerMainProxy getInstance(){
    if(_instance == null){
      _instance = WorkerMainProxy._();
    }
    return _instance;
  }

  factory WorkerMainProxy()=>getInstance();


  WorkerMainProxy._();

  final ReceivePort receivePort = ReceivePort();
  Isolate isolate;
  SendPort childPort;

  List<TaskWrapper> taskCache = [];

  bool initializing = false;

  ///nameArgs  key: params name
  ///value: params value .
  ///and type can only 'num,null,double,String'
  void invokeWorker({String methodName,Map<String,dynamic> nameArgs})async{
    taskCache.add(TaskWrapper(methodName, nameArgs));
    if(isolate == null && !initializing){
      initializing = true;
      isolate  = await Isolate.spawn(proxyHandler, receivePort.sendPort);
      receivePort.listen((message) {

        if(message[0] == kSendPortKey){
          childPort = message[1];
          sendTask();
        }else if(message[0]==kTaskResult){
          ///要考虑多线程不同步的情况
          //任务返回结果
        }
      });
    }else if(isolate != null && childPort != null){
      sendTask();
    }

  }

  void sendTask(){
    if(taskCache.length > 0){
      taskCache.forEach((element) {
        childPort.send([kTaskKey,element.methodName,element.nameArgs]);
      });
      taskCache.clear();
    }
  }

}

/////////////////////////////以下为子线程////////////////////////////////////////

/*
* 中间代理isolate
* 注意： 请勿使用任何dart:ui内的东西（即涉及到flutter的代码）
* */

List<TaskWrapper> taskLog = [];

final ReceivePort receiveMainPort = ReceivePort();
final SendPort sendPortOfProxy = receiveMainPort.sendPort;

final Map<int,WorkIsolateWrapper> workers = {};

void proxyHandler(SendPort mainPort)async{

  receiveMainPort.listen((message) {
    if(message[0] == kTaskKey){
      String name = message[1];
      Map<String,dynamic> args = message[2];
      TaskWrapper wrapper = TaskWrapper(name,args);
      taskLog.add(wrapper);
    }

  });

  mainPort.send([kSendPortKey,sendPortOfProxy]);


  /// create 3 work isolate

  List.generate(3, (index) async{
    final ReceivePort proxyPort = ReceivePort();
    final SendPort proxySendPort = proxyPort.sendPort;
    Isolate.spawn(_workerIsolate, proxySendPort,paused: true)
      .then((isolate) {
      int id = Random().nextInt(1000);
      while(workers.containsKey(id)){
        id = Random().nextInt(1000);
      }
      var worker = WorkIsolateWrapper(id,proxyPort, proxySendPort, isolate);
      workers[id] = worker;
      worker.init();
    });


  });

  runProxy();


//  SendPort childSendPort;
//
//  proxyPort.listen((message) {
//    print('msg from child $message');
//    if(message[0] == kSendPortKey){
//      childSendPort = message[1];
//      runTask(childSendPort);
//    }
//
//  });

}

void runProxy(){
  final timer = Timer.periodic(Duration(milliseconds: 1), (timer) {
    if(taskLog.length>0){
      workers.forEach((key, value) {
        if(taskLog.length > 0){
          if(value.isStandBy()){
            TaskWrapper task = taskLog.first;
            value.setStatus(false);// not free
            value.workSendPort.send([kTaskKey,{kMethodName:task.methodName,
              kNameArgs:task.nameArgs}]);
            taskLog.removeWhere((element) => element == task);
          }

        }

      });

    }
  });
}

/*
* 工作isolate
* 注意： 请勿使用任何dart:ui内的东西（即涉及到flutter的代码）
* */


const int kWorkDone = 98766; //处理完后的回复tag

void _workerIsolate(SendPort proxyPort){
  initializeReflectable();



  final ReceivePort receivePort = ReceivePort();
  final SendPort sendPort = receivePort.sendPort;

  receivePort.listen((message) {
    if(message[0] == kTaskKey){
      ///执行任务
      Map method = message[1];
      String mn = method[kMethodName];
      Map<Symbol,dynamic> nameArguments = {};
      if(method[kNameArgs] is Map){
        ///为了避免顺序错误导致的参数异常，这里不使用positionalArguments
        (method[kNameArgs] as Map).forEach((key, value) {
          nameArguments[Symbol(key)] = value;
        });

        final WorkList workerList = WorkList();
        final InstanceMirror instanceMirror = myReflect.reflect(workerList);
        //final ClassMirror classMirror = myReflect.reflectType(WorkList);
        instanceMirror.invoke(mn, [],nameArguments);
        ///work done
        ///结构暂定为 [order flag, result(Map)]
        ///个人认为这种多线程处理任务，最好不要有返回结果 ....待设计
        proxyPort.send([kWorkDone,{'method':mn,'args':nameArguments.toString()}]);
      }

    }

  });

  proxyPort.send([kSendPortKey,sendPort]);


}


























