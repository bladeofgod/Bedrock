

import 'package:flutter/material.dart';
import 'package:flutter_bedrock/base_framework/ui/anim/page_route_anim/fade_animation.dart';
import 'package:flutter_bedrock/base_framework/ui/anim/page_route_anim/no_animation.dart';
import 'package:flutter_bedrock/base_framework/ui/anim/page_route_anim/size_scale_animation.dart';
import 'package:flutter_bedrock/base_framework/ui/anim/page_route_anim/slide_animation.dart';

///后期对此扩建

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

  Route<dynamic> wrapWithNoAnim(Widget page){
    return NoAnimRouteBuilder(page);
  }



  Route<dynamic> wrapWithFadeAnim(Widget page){
    return FadeRouteBuilder(page);
  }


  Route<dynamic> wrapWithSlideAnim(Widget page){
    return SlideRightRouteBuilder(page);
  }

  Route<dynamic> wrapWithScaleAnim(Widget page){
    return ScaleRouteBuilder(page);
  }


}
























