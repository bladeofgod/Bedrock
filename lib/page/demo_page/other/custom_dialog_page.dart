/*
* Author : LiJiqqi
* Date : 2020/12/4
*/

import 'package:flutter/material.dart';
import 'package:flutter_bedrock/base_framework/widget_state/page_state.dart';

class CustomDialogPage extends PageState{
  @override
  Widget build(BuildContext context) {
    return switchStatusBar2Dark(child: Container(
      color: Colors.white,
      width: getWidthPx(750),height: getHeightPx(1334),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildBtn('显示一个蓝色方块', (){
            floatWidget(Container(width: getWidthPx(400),height: getWidthPx(400),color: Colors.blue,));
          }),
          getSizeBox(height: getWidthPx(100)),
          buildBtn('显示一个红色圆', (){
            floatWidget(Container(width: getWidthPx(400),height: getWidthPx(400),
              decoration: BoxDecoration(
                color: Colors.red,shape: BoxShape.circle
              ),));
          }),
        ],
      ),
    ));
  }

  Widget buildBtn(String title,Function onTap){
    return Container(
      width: getWidthPx(500),height: getWidthPx(100),
      child: RaisedButton(
        onPressed: onTap,
        child: Text(title,style: TextStyle(
          color: Colors.black,fontSize: getSp(28)
        ),),
      ),
    );
  }

}
















