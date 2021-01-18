/*
* Author : LiJiqqi
* Date : 2020/6/9
*/


import 'dart:async';

class LittleUtil{

  ///简单的循环执行一个task
  /// * 务必在不用的时候释放掉。
  static StreamSubscription cycleUtil(Function task,{Duration period = const Duration(seconds: 5)}){
    assert(task != null,"task must not null");
    Stream clock =  Stream.periodic(period);
    StreamSubscription streamSubscription = clock.listen((value) {
      task();
    });

    return streamSubscription;

  }


}


















