/*
* Author : LiJiqqi
* Date : 2020/4/17
*/

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bedrock/base_framework/utils/image_helper.dart';
import 'package:flutter_bedrock/base_framework/utils/show_image_util.dart';
import 'package:flutter_bedrock/base_framework/widget_state/base_state.dart';

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
                title: "$indexStr/${imageList.length}",
                bgColor: Colors.black,
                leftWidget: buildAppBarLeft(),
                leftPadding: getWidthPx(40),
                rightPadding: getWidthPx(40)),
          ],
        )
    );
  }

}





















