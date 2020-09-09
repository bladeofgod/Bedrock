


import 'package:ffloat/ffloat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bedrock/base_framework/widget_state/base_state.dart';
import 'package:flutter_bedrock/base_framework/widget_state/page_state.dart';


class FFloatPageState extends PageState {

  FFloatController controller = FFloatController();

  @override
  Widget build(BuildContext context) {
    return switchStatusBar2Dark(child: Container(
      width: getWidthPx(750), height: getHeightPx(1334),
      child: Column(
        children: <Widget>[
          getSizeBox(height: getWidthPx(100)),
          buildBtn(GestureDetector(
            onPanDown: (details){
              FFloat(
                    (setter)=>buildDialog(),
                canTouchOutside: true,
                backgroundColor: Color.fromRGBO(34, 34, 34, 0.3),
                location: Offset(getScreenWidth()/2,getScreenHeight()/2),
              ).show(context);
            },
            child: Text('屏幕居中显示dialog'),
          )),
          getSizeBox(height: getWidthPx(40)),
          buildBtn(FFloat(
                (_)=>buildFloat('i am float widget'),
            margin: EdgeInsets.only(top: getWidthPx(10)),
            canTouchOutside: true,
            alignment: FFloatAlignment.bottomCenter,
            anchor: Text('在我下面显示dialog',style: TextStyle(color: Colors.black,fontSize: getSp(28)),),
          )),
          getSizeBox(height: getWidthPx(100)),
          buildBtn(FFloat(
                (_)=>GestureDetector(
                  onTap: (){
                    if(controller.isShow){
                      controller.dismiss();
                    }
                  },
                  child: buildFloat('点我关闭'),
                ),
            controller: controller,
            margin: EdgeInsets.only(top: getWidthPx(10)),
            canTouchOutside: true,
            alignment: FFloatAlignment.bottomCenter,
            anchor: Text('在我下面显示dialog',style: TextStyle(color: Colors.black,fontSize: getSp(28)),),
          )),
        ],
      ),
    ));
  }


  Widget buildFloat(String str){
    return Container(
      padding: EdgeInsets.all(getWidthPx(10)),
      alignment: Alignment.center,
      child: Text(str,style: TextStyle(color: Colors.white,fontSize: getSp(28)),),
      color: Colors.black,
      //width: getWidthPx(80),height: getWidthPx(40),
    );
  }

  Widget buildDialog(){
    return Container(
      width: getWidthPx(200),height: getWidthPx(200),
      color: Colors.red,
    );
  }

  Widget buildBtn(Widget btn){
    return Container(
      padding: EdgeInsets.all(getWidthPx(10)),
      //width: getWidthPx(100),
      //height: getWidthPx(50),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(getWidthPx(10)),
        border: Border.all(color: Colors.black,width: getWidthPx(2))
      ),
      child: btn,
    );
  }

}






















