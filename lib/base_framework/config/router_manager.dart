




import 'package:flutter/material.dart';
import 'package:flutter_bedrock/base_framework/ui/anim/page_route_anim/no_animation.dart';
import 'package:flutter_bedrock/base_framework/ui/anim/page_route_anim/slide_animation.dart';
import 'package:flutter_bedrock/base_framework/ui/widget/detail_image_widget.dart';
import 'package:flutter_bedrock/base_framework/ui/widget/image/image_editor.dart';
import 'package:flutter_bedrock/main.dart';
import 'package:flutter_bedrock/page/demo_page/demo_page.dart';
import 'package:flutter_bedrock/page/demo_page/exception/handle_exception_page.dart';
import 'package:flutter_bedrock/page/demo_page/main_page.dart';

class RouteName{

  static const String demo_page = "demo_page";
  static const String demo_exception_page = "demo_exception_page";
  static const String main_page = 'main_page';


  ///对指定图片进行裁剪、并返回对应路径
  static const String editor_image_page = "editor_image_page";
  ///显示大图
  static const String show_big_image = "show_big_image";



}


class Router{

  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name) {
      case RouteName.demo_page:
        return NoAnimRouteBuilder(DemoPage());
      case RouteName.main_page:
        return NoAnimRouteBuilder(MainPage());
      case RouteName.demo_exception_page:
        return NoAnimRouteBuilder(HandleExceptionPage());

      case RouteName.editor_image_page:
        ///外层为动画
        return SlideTopRouteBuilder(ImageEditor(settings.arguments));
      case RouteName.show_big_image:
        return NoAnimRouteBuilder(DetailImageWidget(settings.arguments));
    }
  }

}