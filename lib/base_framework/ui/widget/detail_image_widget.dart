/*
* Author : LiJiqqi
* Date : 2020/4/17
*/

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:tripalink/base_framework/utils/image_helper.dart';
import 'package:tripalink/base_framework/utils/show_image_util.dart';
import 'package:tripalink/base_framework/widget_state/base_state.dart';

class DetailImageWidget extends StatefulWidget{


  final Map arguments;

  DetailImageWidget(this.arguments);

  @override
  State<StatefulWidget> createState() {

    return DetailImageWidgetState(arguments["imageList"],arguments["initIndex"]);
  }

}

class DetailImageWidgetState extends BaseState<DetailImageWidget> {

  final List<String> imageList;
  final int initIndex;
  int indexStr=1;

  DetailImageWidgetState(this.imageList, this.initIndex);
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return switchStatusBar2Dark(
        isSetDark: true,
        child: Stack(
          children: <Widget>[
            Container(
              color: Colors.black,
              width: getWidthPx(750),
              height: getHeightPx(1334),
              child: ExtendedImageGesturePageView.builder(
                  controller: new PageController(initialPage: this.initIndex),
                  itemCount: imageList.length,
                  itemBuilder: (ctx,index){
                    var url = "${imageList[index]}${ShowImageUtil.W1000}";
                    //var url = "http://a0.att.hudong.com/78/52/01200000123847134434529793168.jpg";
                    Widget image = ExtendedImage.network(
                      url,fit: BoxFit.contain,mode: ExtendedImageMode.gesture,
                      initGestureConfigHandler: (state){
                        return GestureConfig(
                            inPageView: imageList.length>1
                        );
                      },
                    );
                    return image;
                  },
                onPageChanged: (int index) {
                 setState(() {
                   indexStr=index+1;
                 });
                },
                  ),
            ),
            commonAppBar(
                title: "${indexStr}/${imageList.length}",
                bgColor: Colors.black,
                leftWidget: buildAppBarLeft(),
                leftPadding: getWidthPx(40),
                rightPadding: getWidthPx(40)),
          ],
        )
    );
  }
  Widget commonAppBar({Widget leftWidget,String title,List<Widget> rightWidget ,
    Color bgColor = Colors.black,@required double leftPadding,@required double rightPadding}){
    return Container(
      width: getWidthPx(750),
      height: getHeightPx(110),
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
                style: TextStyle(fontSize: getSp(36),color: Colors.white,
                    decoration: TextDecoration.none),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget buildAppBarLeft(){
    return GestureDetector(
      onTap: (){
        Navigator.of(context).pop();
      },
      child: Container(
        color: Colors.black,
        width: getWidthPx(80),
        height: getHeightPx(50),
        alignment: Alignment.bottomLeft,
        child: Image.asset(ImageHelper.wrapAssetsIcon("icon_back_black_p.jpg"),width: getWidthPx(17),height: getHeightPx(32),),
      ),
    );
  }
}





















