/*
* Author : LiJiqqi
* Date : 2020/12/4
*/

import 'package:flutter/material.dart';
import 'package:flutter_bedrock/base_framework/widget_state/page_state.dart';
import 'package:flutter_bedrock/page/demo_widget/custom_drawer.dart';
import 'float_layer_widget/shake_float_widget.dart';
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
          getSizeBox(height: getWidthPx(80)),
          buildBtn('elasticOut 式的动画：红方块 ', (){
            final ShakeFloatState shake = ShakeFloatState();
            floatWidget(shake.generateWidget(),
              floatWidgetDismiss: (ctx){
              shake.controller.reverse()
                .whenComplete(() => Navigator.pop(ctx));
              
              });
          }),
          getSizeBox(height: getWidthPx(80)),
          buildBtn('弹窗 pageView', (){
            floatWidget(pageView(),barrierDismissible: true,
              transitionDuration: Duration(milliseconds: 0),
                reverseTransitionDuration: Duration(milliseconds: 0));
          }),
          getSizeBox(height: getWidthPx(80)),
          buildBtn('底部滑出抽屉', (){
            final CustomBottomDrawerWidget bottomDrawerWidget = CustomBottomDrawerWidget();
            floatWidget(bottomDrawerWidget.generateWidget(),
                floatWidgetDismiss: (ctx){
                bottomDrawerWidget.animationController?.reverse()
                  ?.whenComplete(() => Navigator.pop(ctx));
                },
                barrierDismissible: true,
                );
          }),
        ],
      ),
    ));
  }

  final PageController controller = PageController(viewportFraction: 0.8);

  Widget pageView(){
    return Material(
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: getWidthPx(750),height: getWidthPx(700),
            child: PageView(
              controller: controller,
              children: List.generate(3, (index){
                return Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(right: getWidthPx(80)),
                  width: getWidthPx(590),height: getWidthPx(600),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(getWidthPx(16)))
                  ),
                  child: Text('$index',style: TextStyle(color: Colors.blue,fontSize: getSp(60),
                      fontWeight: FontWeight.bold),),
                );
              }),
            ),
          ),
          getSizeBox(height: getWidthPx(60)),
        ],
      ),
    );
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
















