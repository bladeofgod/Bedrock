


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bedrock/base_framework/widget_state/widget_state.dart';

class CustomBottomDrawerWidget extends WidgetState with SingleTickerProviderStateMixin{

  AnimationController animationController;
  Animation animation;

  double bottom = -600;

  @override
  void initState() {
    animationController = AnimationController(vsync: this,duration: Duration(milliseconds: 500));
    animation =Tween<double>(begin: bottom,end: 0).animate(animationController);
    super.initState();
    animationController.addListener(() {
      setState(() {
        bottom = animation.value;
      });
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      animationController.forward();
    });
  }
  @override
  void dispose() {
    animationController.dispose();
    // TODO: implement dispose
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Positioned(
          bottom: getHeightPx(bottom),
          child: Material(
            color: const Color.fromRGBO(0, 0, 0, 0),
            child: Container(
              width: getWidthPx(750),height: getHeightPx(600),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(getHeightPx(16)),topRight: Radius.circular(getHeightPx(16))),
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('this is a drawer.\n slide from bottom',style: TextStyle(
                      color: Colors.black,fontSize: getSp(32)
                  ),),
                  getSizeBox(height: getWidthPx(70)),
                  RaisedButton(
                    onPressed: (){
                      animationController.reverse().then((value) => Navigator.pop(context));
                    },
                    child: Text('close',style: TextStyle(color: Colors.black,fontSize: getSp(30)),),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

}