/*
* Author : LiJiqqi
* Date : 2020/5/26
*/



import 'package:flutter/material.dart';
import 'package:flutter_bedrock/base_framework/widget_state/base_state.dart';

class ExceptionPage extends StatefulWidget{
  final String exception;
  final String stack;


  ExceptionPage(this.exception, this.stack);

  @override
  State<StatefulWidget> createState() {
    return ExceptionPageState();
  }
  
}

class ExceptionPageState extends BaseState<ExceptionPage> {
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
                Text(widget.exception,style: TextStyle(color: Colors.black),),
                getSizeBox(height: getWidthPx(50)),
                Text(widget.stack,style: TextStyle(color: Colors.blue),),
              ],
            ),
          ),
        ));
  }
}











