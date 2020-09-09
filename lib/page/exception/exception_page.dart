/*
* Author : LiJiqqi
* Date : 2020/5/26
*/



import 'package:flutter/material.dart';
import 'package:flutter_bedrock/base_framework/widget_state/base_state.dart';
import 'package:flutter_bedrock/base_framework/widget_state/page_state.dart';

///非业务型异常展示的页面


class ExceptionPageState extends PageState {

  final String exception;
  final String stack;

  ExceptionPageState(this.exception, this.stack);


  @override
  Widget build(BuildContext context) {

    return switchStatusBar2Dark(
      isSetDark: true,
        child: Container(
          color: Colors.white,
          width: getWidthPx(750),height: getHeightPx(1334),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(exception,style: TextStyle(color: Colors.black),),
                getSizeBox(height: getWidthPx(50)),
                Text(stack,style: TextStyle(color: Colors.blue),),
              ],
            ),
          ),
        ));
  }
}











