

import 'package:flutter/material.dart';
import 'package:flutter_bedrock/base_framework/ui/anim/page_route_anim/fade_animation.dart';
import 'package:flutter_bedrock/base_framework/ui/anim/page_route_anim/no_animation.dart';
import 'package:flutter_bedrock/base_framework/ui/anim/page_route_anim/size_scale_animation.dart';
import 'package:flutter_bedrock/base_framework/ui/anim/page_route_anim/slide_animation.dart';


final PageAnimationBuilder pageBuilder = PageAnimationBuilder.getInstance();


///动画枚举类，这个你可以根据需求自定义
///但最好保持代码这个结构

enum PageAnimation{
  Fade,Scale,Slide,Non
}


class PageAnimationBuilder{

  static PageAnimationBuilder singleton;

  static PageAnimationBuilder getInstance(){
    if(singleton == null){
      singleton = PageAnimationBuilder._();
    }
    return singleton;
  }

  PageAnimationBuilder._();


  ///

  Route<dynamic> wrapWithNoAnim(Widget page,RouteSettings routeSettings){
    return NoAnimRouteBuilder(page,routeSettings);
  }


  ///fade
  Route<dynamic> wrapWithFadeAnim(Widget page,RouteSettings routeSettings){
    return FadeRouteBuilder(page,routeSettings);
  }


  ///slide
  Route<dynamic> wrapWithSlideAnim(Widget page,RouteSettings routeSettings){
    return SlideRightRouteBuilder(page,routeSettings);
  }

  Route<dynamic> wrapWithSlideTopAnim(Widget page,RouteSettings routeSettings){
    return SlideTopRouteBuilder(page,routeSettings);
  }


  ///scale
  Route<dynamic> wrapWithScaleAnim(Widget page,RouteSettings routeSettings){
    return ScaleRouteBuilder(page,routeSettings);
  }


}
























