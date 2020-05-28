




import 'package:flutter/material.dart';
import 'package:flutter_bedrock/base_framework/ui/anim/page_route_anim/no_animation.dart';
import 'package:flutter_bedrock/base_framework/ui/anim/page_route_anim/slide_animation.dart';
import 'package:flutter_bedrock/base_framework/ui/widget/image/image_editor.dart';
import 'package:flutter_bedrock/main.dart';
import 'package:flutter_bedrock/page/demo_page/demo_page.dart';

class RouteName{

  static const String demo_page = "demo_page";
  ///对指定图片进行裁剪、并返回对应路径
  static const String editor_image_page = "editor_image_page";



}


class Router{

  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name) {
      case RouteName.demo_page:
        return NoAnimRouteBuilder(DemoPage());
      case RouteName.editor_image_page:
        ///外层为动画
        return SlideTopRouteBuilder(ImageEditor(settings.arguments));
    }
  }

}