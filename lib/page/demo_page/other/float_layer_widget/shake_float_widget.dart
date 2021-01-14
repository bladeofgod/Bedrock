/*
* Author : LiJiqqi
* Date : 2021/1/14
*/

import 'package:flutter_bedrock/base_framework/widget_state/widget_state.dart';

import 'package:flutter/material.dart';

class ShakeFloatState extends WidgetState with SingleTickerProviderStateMixin{

  AnimationController controller;
  Animation<double> animation;
  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
  @override
  void initState() {
    controller = AnimationController(vsync: this,duration: const Duration(milliseconds: 300));
    animation = Tween<double>(begin: 0.1,end: 1.0)
        .animate(CurvedAnimation(curve: Curves.elasticOut,
          reverseCurve: Curves.easeOut,parent: controller));
    super.initState();
    controller.addListener(() {
      setState(() {
      });
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.forward();
    });
  }


  double alpha = 0.0;
  double width = 400;

  @override
  Widget build(BuildContext context) {
    return Opacity(opacity: animation.value.clamp(0.0, 1.0),
      child: GestureDetector(
        onTap: (){
          controller.reverse();
        },
        child: Container(
          width: getWidthPx(width * animation.value),height: getWidthPx(width * animation.value),
          color: Colors.red,
          child: Icon(Icons.close,size: getWidthPx(80),color: Colors.white,),
        ),
      ),);
  }

}























