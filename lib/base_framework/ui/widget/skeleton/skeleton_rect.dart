/*
* Author : LiJiqqi
* Date : 2020/4/24
*/




import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tripalink/base_framework/constant.dart';
import 'package:tripalink/base_framework/ui/widget/skeleton/base_skeleton/base_skeleton_widget.dart';
import 'package:tripalink/base_framework/widget_state/base_stateless_widget.dart';

class SkeletonRect extends BaseSkeletonWidget{

  final double width;
  final double height;
  final double radius;
  final Color color;


  SkeletonRect({this.width, this.height, this.radius, this.color});

  @override
  Widget build(BuildContext context) {

    return Container(
      width: width,height: height,
      decoration: BoxDecoration(
        color: color??skeletonColor,borderRadius: BorderRadius.circular(radius)
      ),
    );
  }

}















