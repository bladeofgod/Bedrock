/*
* Author : LiJiqqi
* Date : 2021/1/19
*/


import 'package:flutter_bedrock/base_framework/widget_state/page_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bedrock/page/demo_page/image/nine_image_page.dart';
import 'package:flutter_bedrock/page/demo_page/image/pick_image_page.dart';
class ImageMainDemo extends PageState{
  @override
  Widget build(BuildContext context) {

    return switchStatusBar2Dark(child: Container(
      width: getWidthPx(750),height: getHeightPx(1334),
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            getSizeBox(height: getWidthPx(100)),

            getSizeBox(height: getHeightPx(40)),
            buildIntro("选择一个图片"),
            RaisedButton(
              child: Text("弹出自定义的widget 演示",style: TextStyle(color: Colors.black),),
              onPressed: (){
                push(PickImagePageState());
              },
            ),

            getSizeBox(height: getHeightPx(40)),
            buildIntro("选择图片九宫格"),
            RaisedButton(
              child: Text("九宫图演示demo",style: TextStyle(color: Colors.black),),
              onPressed: (){
                push(NineImagePage());
              },
            ),

            getSizeBox(height: getHeightPx(40)),
          ],
        ),
      ),
    ));
  }

  Widget buildIntro(String str){
    return Text(str,style: TextStyle(color: Colors.black,fontSize: getSp(28)),);
  }

}