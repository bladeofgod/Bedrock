


import 'package:flutter_bedrock/base_framework/widget_state/widget_state.dart';

import 'package:flutter/material.dart';

typedef NotifyDone = void Function(bool notifyDone);

class FromTopNotifyWidget extends WidgetState with SingleTickerProviderStateMixin {


  final Widget child;
  final Duration animationDuration;
  final Duration notifyDwellTime;

  AnimationController controller;
  Animation animation;

  FromTopNotifyWidget(this.child, this.animationDuration, this.notifyDwellTime);


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(vsync: this,duration: animationDuration);
    animation = Tween<Offset>(begin: Offset(0,-1),end: Offset.zero).animate(controller);
    controller.addStatusListener((status) {
      if(status == AnimationStatus.completed){
        Future.delayed(notifyDwellTime)
            .whenComplete(() => controller?.reverse());
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.forward();
    });
  }
  @override
  void dispose() {
    controller?.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [AnimatedBuilder(
        animation: animation,
        builder: (ctx,c){
          return SlideTransition(
            position:animation ,
            child: child,);
        },
      )],
    );
  }

}













