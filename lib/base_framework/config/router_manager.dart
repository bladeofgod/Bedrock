




import 'package:flutter/material.dart';
import 'package:flutter_bedrock/base_framework/ui/anim/page_route_anim/fade_animation.dart';
import 'package:flutter_bedrock/base_framework/ui/anim/page_route_anim/no_animation.dart';
import 'package:flutter_bedrock/base_framework/ui/anim/page_route_anim/size_scale_animation.dart';
import 'package:flutter_bedrock/base_framework/ui/anim/page_route_anim/slide_animation.dart';
import 'package:flutter_bedrock/base_framework/ui/widget/detail_image_widget.dart';
import 'package:flutter_bedrock/base_framework/ui/widget/image/image_editor.dart';
import 'package:flutter_bedrock/base_framework/ui/widget/web/html_page.dart';
import 'package:flutter_bedrock/base_framework/ui/widget/web/web_page.dart';
import 'package:flutter_bedrock/main.dart';
import 'package:flutter_bedrock/page/demo_page/demo_page.dart';
import 'package:flutter_bedrock/page/demo_page/exception/handle_exception_page.dart';
import 'package:flutter_bedrock/page/demo_page/image/pick_image_page.dart';
import 'package:flutter_bedrock/page/demo_page/local_i10l/local_page.dart';
import 'package:flutter_bedrock/page/demo_page/main/login/login_page.dart';
import 'package:flutter_bedrock/page/demo_page/main_page.dart';
import 'package:flutter_bedrock/page/demo_page/other/little_util_page.dart';
import 'package:flutter_bedrock/page/demo_page/other/request_permission_page.dart';
import 'package:flutter_bedrock/page/demo_page/other/scroll_page.dart';
import 'package:flutter_bedrock/page/demo_page/other/timer_page.dart';
import 'package:flutter_bedrock/page/demo_page/other_demo_page.dart';
import 'package:flutter_bedrock/page/demo_page/route_anim/fade_page.dart';
import 'package:flutter_bedrock/page/demo_page/route_anim/route_animation_page.dart';
import 'package:flutter_bedrock/page/demo_page/route_anim/scale_page.dart';
import 'package:flutter_bedrock/page/demo_page/route_anim/slide_page.dart';
import 'package:flutter_bedrock/page/demo_page/slide_out_page.dart';

class RouteName{

  static const String demo_page = "demo_page";
  static const String demo_exception_page = "demo_exception_page";
  static const String main_page = 'main_page';
  static const String login_page = 'login_page';
  static const String pick_image_page = 'pick_image_page';
  static const String demo_other_page = 'demo_other_page';
  static const String scroll_page = 'scroll_page';
  static const String little_util_page = 'little_util_page';
  static const String slide_out_page = 'slide_out_page';
  static const String timer_page = 'timer_page';
  static const String permissions_page = 'permissions_page';

  static const String route_anim_page = 'route_anim_page';
  static const String fade_page = 'fade_page';
  static const String scale_page = 'scale_page';
  static const String slide_page = 'slide_page';

  static const String local_i10l_page = 'local_i10l_page';



  ///对指定图片进行裁剪、并返回对应路径
  static const String editor_image_page = "editor_image_page";
  ///显示大图
  static const String show_big_image = "show_big_image";
  ///web/html
  static const String web_page = 'web_page';
  static const String html_page = 'html_page';




}


class Router{

  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name) {
      case RouteName.demo_page:
        return NoAnimRouteBuilder(DemoPage());
      case RouteName.scroll_page:
        return NoAnimRouteBuilder(ScrollPage());
      case RouteName.little_util_page:
        return NoAnimRouteBuilder(LittleUtilPage());
      case RouteName.permissions_page:
        return NoAnimRouteBuilder(RequestPermissionsPage());
      case RouteName.demo_other_page:
        return NoAnimRouteBuilder(OtherDemoPage());
      case RouteName.local_i10l_page:
        return NoAnimRouteBuilder(LocalPage());
      case RouteName.login_page:
        return SlideTopRouteBuilder(LoginPage());
      case RouteName.pick_image_page:
        return NoAnimRouteBuilder(PickImagePage());
      case RouteName.main_page:
        return NoAnimRouteBuilder(MainPage());
      case RouteName.demo_exception_page:
        return NoAnimRouteBuilder(HandleExceptionPage());
      case RouteName.slide_out_page:
        return SlideRightRouteBuilder(SlideOutPage());
      case RouteName.timer_page:
        return NoAnimRouteBuilder(TimerPage());

      case RouteName.route_anim_page:
        return NoAnimRouteBuilder(RouteAnimationPage());
      case RouteName.slide_page:
        return SlideTopRouteBuilder(SlidePage());
      case RouteName.fade_page:
        return ScaleRouteBuilder(FadePage());
      case RouteName.scale_page:
        return FadeRouteBuilder(ScalePage());

      case RouteName.web_page:
        return NoAnimRouteBuilder(WebPage(settings.arguments));
      case RouteName.html_page:
        return NoAnimRouteBuilder(HtmlPage(settings.arguments));

      case RouteName.editor_image_page:
        ///外层为动画
        return SlideTopRouteBuilder(ImageEditor(settings.arguments));
      case RouteName.show_big_image:
        return NoAnimRouteBuilder(DetailImageWidget(settings.arguments));
    }
  }

}