

import 'package:extended_image/extended_image.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bedrock/base_framework/utils/image_helper.dart';

/*
* 图片格式是否是webp要等于后端和IOS确定在做更改，目前是webp的
*
* extend_image 更多使用方法：https://github.com/fluttercandies/extended_image/blob/master/README-ZH.md
*
* 图片格式： webp : -w400  -w600 -w1000
* */



class ShowImageUtil{
  ///根据后台协商不同尾缀来加载不同尺寸的图片，可以换成你自己的
  static const String TEST = "";
  static const String W400 = "-w400";
  static const String W600 = "-w600";
  static const String W1000 = "-w1000";


  /// 获取一个图片widget
  /// * 支持全圆角，或者自定义圆角风格
  /// * 支持根据图片连接结果，显示缺省图（需释放注释）
  static Widget showImageWithDefaultError(String url,double width, double height,{
    String imageType = TEST, double borderRadius = 0,BorderRadius borderRStyle ,
    /// 缺省widget         ///错误widget
    Widget defaultImg, Widget errorImg, BoxFit boxFit : BoxFit.cover}){

    return ClipRRect(
      borderRadius:borderRStyle??BorderRadius.all(Radius.circular(borderRadius)) ,
      child: ExtendedImage.network(
        "$url$imageType",
        width: width,
        height: height,
        fit: boxFit,
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        cache: true,
        //不同状态加载不同图片
//      loadStateChanged: (ExtendedImageState state){
//        switch(state.extendedImageLoadState){
//          case LoadState.loading:
//            return Container();
//          case LoadState.completed:
//
//            return ExtendedRawImage(
//                image: state.extendedImageInfo?.image,
//              width: width,
//              height: height,fit: boxFit,);
//          case LoadState.failed:
//          // TODO: Handle this case.
//            return Container();
//          default :
//            return Container();
//        }
//      },
      ),
    );
  }






}