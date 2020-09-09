/*
* Author : LiJiqqi
* Date : 2020/6/10
*/

import 'package:flutter/material.dart';
import 'package:flutter_bedrock/base_framework/widget_state/base_state.dart';
import 'package:flutter_bedrock/base_framework/widget_state/page_state.dart';



class ScrollPageState extends PageState {

  String text = "停止中";
  String t = "滚动中";

  //ScrollController scrollController;
  @override
  void initState() {

    super.initState();
//    scrollController = ScrollController();
//    scrollController.addListener(() {
//      text='停止了...';
//      if(scrollController.position.isScrollingNotifier.value){
//        text = "滚动中";
//        setState(() {
//
//        });
//        return;
//      }
//
//      setState(() {
//
//      });
//    });

  }


  @override
  Widget build(BuildContext context) {
    return switchStatusBar2Dark(child: Container(
      width: getWidthPx(750),height: getHeightPx(1334),
      child: Stack(
        children: <Widget>[
          NotificationListener<ScrollStartNotification>(
            onNotification: (ScrollStartNotification startScroll){
              debugPrint("开始滚动");
              debugPrint("$startScroll");
              setState(() {
                text = "开始滚动";
              });
              return true;///false 事件继续冒泡
            },
            child: NotificationListener<ScrollEndNotification>(
              onNotification: (ScrollEndNotification endNotification){
                debugPrint("停止滚动");
                debugPrint("$endNotification");
                setState(() {
                  text = "停止滚动";
                });
                return true;///false 事件继续冒泡
              },
              child: ListView(
                children:buildList(),
              ),
            ),
          ),
          Container(
            color: Colors.white,
            alignment: Alignment.center,
            height: getWidthPx(120),
            margin: EdgeInsets.only(top: getWidthPx(100)),
            child: Text(text
              ,style: TextStyle(color: Colors.black),),
          ),
        ],
      ),
    ));
  }

  List<Widget> buildList(){
    List<Widget> list = [];
    List.generate(20, (index) {
      list.add(Container(
        width: getWidthPx(750),height: getWidthPx(200),color: index%2==0?Colors.blue:Colors.red,
      ));
    });
    return list;
  }


}















