/*
* Author : LiJiqqi
* Date : 2020/3/31
*/


import 'package:flutter/material.dart';
import 'package:flutter_bedrock/base_framework/widget_state/base_stateless_widget.dart';


class CircleBorderContainer extends BaseStatelessWidget{
  final double? width,height;
  final Color? borderColor;
  final double? borderWidth;
  final String? text;
  final TextStyle? style;


  CircleBorderContainer({this.width, this.height, this.borderColor,
    this.borderWidth, this.text,this.style});

  @override
  Widget build(BuildContext context) {

    return Container(
      alignment: Alignment.center,
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(width: borderWidth!,color: borderColor!)
      ),
      child: Text(text!,style: style,),
    );
  }

}