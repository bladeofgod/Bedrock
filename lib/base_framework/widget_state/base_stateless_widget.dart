

import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bedrock/base_framework/ui/behavior/over_scroll_behavior.dart';
import 'package:flutter_bedrock/base_framework/utils/image_helper.dart';


abstract class BaseStatelessWidget extends StatelessWidget{

  BuildContext context;



  ///切换状态栏 模式：light or dark
  ///应在根位置调用此方法
  Widget switchStatusBar2Dark({bool isSetDark = false,@required Widget child}){
    return AnnotatedRegion(
      value: isSetDark ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
      child: Material(
        child: child,
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


  /// 一般页面的通用APP BAR 具体根据项目需求调整
  Widget commonAppBar({Widget leftWidget,String title,List<Widget> rightWidget ,
    Color bgColor = Colors.white,@required double leftPadding,@required double rightPadding}){
    return Container(
      width: getWidthPx(750),
      height: getHeightPx(115),
      //padding: EdgeInsets.only(left: getWidthPx(40),right: getWidthPx(40)),
      color: bgColor??Color.fromRGBO(241, 241, 241, 1),
      padding: EdgeInsets.only(bottom: getHeightPx(10),left: leftPadding,right: rightPadding),
      alignment: Alignment.bottomCenter,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: <Widget>[
          Positioned(
            left: 0,
            child: leftWidget ?? Container(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Visibility(
              visible:  title != null,
              child: Text(
                "$title",
                style: TextStyle(fontSize: getSp(36),color: Colors.black,
                    decoration: TextDecoration.none),
              ),
            ),
          ),
          if(rightWidget != null)
            ...rightWidget,
        ],
      ),
    );
  }

  Widget buildAppBarLeft(){
    return GestureDetector(
      onTap: (){
        Navigator.of(context).pop();
      },
      child: Image.asset(ImageHelper.wrapAssetsIcon("icon_back_black.png"),width: getWidthPx(17),height: getHeightPx(32),),
    );
  }

  Widget buildMsgWidget({bool showDot = true,Function hitMsgWidget}){
    return GestureDetector(
      onTap: (){
        if(hitMsgWidget != null){
          hitMsgWidget();
        }
      },
      child: Container(
        width: getWidthPx(38),
        height: getHeightPx(34),
        child: Stack(
          children: <Widget>[
            Image.asset(ImageHelper.wrapAssetsIcon(showDot? "icon_msg_new.png":"icon_msg.png"),
              width: getWidthPx(36),height: showDot ? getWidthPx(34):getWidthPx(28),),
            ///dot
//            Positioned(
//              right: 0,
//              top: 0,
//              child: Visibility(
//                visible: showDot,
//                child: ClipOval(
//                  child: Container(
//                    width: getWidthPx(14),
//                    height: getWidthPx(14),
//                    color: Color.fromRGBO(232, 97, 97, 1),
//                  ),
//                ),
//              ),
//            ),
          ],
        ),
      ),
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

  //目前仅对于手机： 因为手机大多数情况下是长度变化较大，
  // 所以以高度来算出半径，保证异形屏的弧度不会缩小
  ///有其他需求，还需要重改
  double getRadiusFromHeight(double raidus) => ScreenUtil.getInstance().getHeightPx(raidus);

  double getSp(double fontSize) => ScreenUtil.getInstance().getSp(fontSize);

}