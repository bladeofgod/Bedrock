
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:markdown_widget/markdown_widget.dart';

///最大执行5，超过需要加入队列等待


class StandardIsolatePool{
  
  
  final LinkedHashMap<String,Function> _waitLine = LinkedHashMap();
  
  StandardIsolatePool._();
  
  static StandardIsolatePool singleton;
  
  static StandardIsolatePool getInstance(){
    if(singleton == null){
      singleton = StandardIsolatePool._();
    }
    return singleton;
  }
  
  void executeTask(Function task){
    if(checkWaitLine()){

    }
    
  }
  
  /// true 工作线程没有满
  /// false 工作线程已经满了
  bool checkWaitLine(){
    return _waitLine.length < 5;
  }

}

















