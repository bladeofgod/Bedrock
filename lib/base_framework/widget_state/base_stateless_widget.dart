

import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bedrock/base_framework/ui/behavior/over_scroll_behavior.dart';
import 'package:flutter_bedrock/base_framework/utils/image_helper.dart';

/// Stateless widget 继承此类

abstract class BaseStatelessWidget extends StatelessWidget{


  ///切换状态栏 模式：light or dark
  ///应在根位置调用此方法
  Widget switchStatusBar2Dark({bool isSetDark = false,@required Widget child,
    EdgeInsets edgeInsets}){
    return AnnotatedRegion(
      value: isSetDark ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
      child: Material(
        child: Padding(
          padding: edgeInsets??EdgeInsets.only(bottom: ScreenUtil.getInstance().bottomBarHeight),
          child: child,
        ),
      ),
    );
  }

  ///去掉 scroll view的 水印  e.g : listView scrollView
  ///
  Widget getNoInkWellListView({@required Widget scrollView}){
    return ScrollConfiguration(
      behavior: OverScrollBehavior(),
      child: scrollView,
    );
  }


  ///占位widget
  Widget getSizeBox({double width = 1,double height = 1}){
    return SizedBox(
      width: width,
      height: height,
    );
  }



  /*
  * size adapter with tool ScreenUtil
  *
  * */

  double getHeightPx(double height) => ScreenUtil.getInstance().getHeightPx
    (height);

  double getWidthPx(double width) => ScreenUtil.getInstance().getWidthPx(width);

  ///屏幕宽度
  double getScreenWidth()=>ScreenUtil.getInstance().screenWidth;
  ///屏幕高度
  double getScreenHeight()=>ScreenUtil.getInstance().screenHeight;

  //目前仅对于手机： 因为手机大多数情况下是长度变化较大，
  // 所以以高度来算出半径，保证异形屏的弧度不会缩小
  ///有其他需求，还需要重改
  double getRadiusFromHeight(double raidus) => ScreenUtil.getInstance().getHeightPx(raidus);

  double getSp(double fontSize) => ScreenUtil.getInstance().getSp(fontSize);

}