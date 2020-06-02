/*
* Author : LiJiqqi
* Date : 2020/6/2
*/


import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bedrock/base_framework/config/router_manager.dart';
import 'package:flutter_bedrock/base_framework/utils/show_image_util.dart';
import 'package:flutter_bedrock/base_framework/widget_state/base_state.dart';

class FirstBanner extends StatefulWidget{

  final int index;
  final List<String> imageList;

  final bool canShowBigImage;

  final BorderRadius borderRadius;

  FirstBanner({this.index,this.imageList,this.canShowBigImage = false,this.borderRadius = BorderRadius.zero});

  @override
  State<StatefulWidget> createState() {

    return FirstBannerState();
  }

}

class FirstBannerState extends BaseState<FirstBanner> {
  int imageIndex = 1;

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: <Widget>[
        /// banner
        CarouselSlider(
          enableInfiniteScroll: true,
          height: 292,
          viewportFraction: 1.0,
          items: widget.imageList.map((item) {
            if(widget.canShowBigImage){
              return GestureDetector(
                onTap: (){
                  if(widget.canShowBigImage){
                    Navigator.of(context).pushNamed(RouteName.show_big_image,
                        arguments: {"imageList":widget.imageList,"initIndex":(imageIndex-1)});
                  }
                },
                child: ClipRRect(
                  borderRadius:widget.borderRadius??BorderRadius.circular(getHeightPx(10)) ,
                  child: ShowImageUtil.showImageWithDefaultError(item,  getWidthPx(622),
                      getHeightPx(292),boxFit: BoxFit.cover ),
                ),
              );
            }else{
              return ClipRRect(
                borderRadius: widget.borderRadius??BorderRadius.circular(getHeightPx(10)),
                child: ShowImageUtil.showImageWithDefaultError(item,  getWidthPx(622),
                    getHeightPx(292),boxFit: BoxFit.cover,borderRadius: getHeightPx(10)),
              );
            }

          }).toList(),
          onPageChanged: (index){
            setState(() {
              imageIndex = index + 1;
            });
          },
        ),
        /// index
        Positioned(
          right: getWidthPx(34),bottom: getHeightPx(30),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: getWidthPx(4),horizontal: getWidthPx(17)),
            decoration: BoxDecoration(
                color: Color.fromRGBO(51, 51, 51, 0.1),
                borderRadius: BorderRadius.circular(getHeightPx(14))
            ),
            child: Text(
              "$imageIndex/${widget.imageList.length}",style: TextStyle(fontSize: getSp(22),color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}










