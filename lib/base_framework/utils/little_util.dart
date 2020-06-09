/*
* Author : LiJiqqi
* Date : 2020/6/9
*/


import 'dart:async';

class LittleUtil{

  static StreamSubscription cycleUtil(Function task,{Duration period = const Duration(seconds: 5)}){
    assert(task != null,"task must not null");
    Stream clock =  Stream.periodic(period);
    StreamSubscription streamSubscription = clock.listen((int) {
      task();
    });

    return streamSubscription;

  }


}


















