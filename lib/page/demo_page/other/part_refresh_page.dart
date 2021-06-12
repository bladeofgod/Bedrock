/*
* Author : LiJiqqi
* Date : 2020/11/27
*/


import 'package:flutter/material.dart';
import 'package:flutter_bedrock/base_framework/widget_state/page_state.dart';
import 'package:flutter_bedrock/base_framework/widget_state/widget_state.dart';

///仅作为一种刷新方式

class PartRefreshPage extends PageState{

  bool exp1 = false;

  late PartWidget partWidget;

  @override
  Widget build(BuildContext context) {
    debugPrint('page build');
    return switchStatusBar2Dark(child: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(onPressed: (){
            exp1 = !exp1;
            setState(() {

            });
          },
          child: Text('change color By setState()'),),
          Container(
            height: getWidthPx(100),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: getWidthPx(80),
                  color: exp1 ? Colors.red:Colors.blue,
                ),
                Container(
                  width: getWidthPx(80),
                  color: exp1 ? Colors.blue:Colors.red,
                ),
              ],
            ),
          ),
          getSizeBox(height: getWidthPx(100)),
          ElevatedButton(onPressed: (){
            partWidget.switchColor();
          }, child: Text('change color By part refresh'),),
          generateWidget(() {
            partWidget = PartWidget();
            return partWidget;
          }),
        ],
      ),
    ));
  }

}

class PartWidget extends WidgetState{

  bool exp1 = false;
  ///此为Demo 故,书写随意
  void switchColor(){
    if(!mounted)return;
    exp1 = !exp1;
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('DoubleColorWidget build');
    return  Container(
      height: getWidthPx(100),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: getWidthPx(80),
            color: exp1 ? Colors.red:Colors.blue,
          ),
          Container(
            width: getWidthPx(80),
            color: exp1 ? Colors.blue:Colors.red,
          ),
        ],
      ),
    );
  }

}

















