




import 'package:flutter/material.dart';
import 'package:flutter_bedrock/base_framework/factory/page/page_animation_builder.dart';
import 'package:flutter_bedrock/base_framework/ui/anim/page_route_anim/fade_animation.dart';
import 'package:flutter_bedrock/base_framework/ui/anim/page_route_anim/no_animation.dart';
import 'package:flutter_bedrock/base_framework/ui/anim/page_route_anim/size_scale_animation.dart';
import 'package:flutter_bedrock/base_framework/ui/anim/page_route_anim/slide_animation.dart';
import 'package:flutter_bedrock/base_framework/ui/widget/detail_image_widget.dart';
import 'package:flutter_bedrock/base_framework/ui/widget/image/image_editor.dart';
import 'package:flutter_bedrock/base_framework/ui/widget/progress_widget.dart';
import 'package:flutter_bedrock/base_framework/ui/widget/route/route_aware_widget.dart';
import 'package:flutter_bedrock/base_framework/ui/widget/web/html_page.dart';
import 'package:flutter_bedrock/base_framework/ui/widget/web/web_page.dart';
import 'package:flutter_bedrock/main.dart';
import 'package:flutter_bedrock/page/demo_page/demo_page.dart';
import 'package:flutter_bedrock/page/demo_page/exception/handle_exception_page.dart';
import 'package:flutter_bedrock/page/demo_page/image/pick_image_page.dart';
import 'package:flutter_bedrock/page/demo_page/isolate/isolate_page.dart';
import 'package:flutter_bedrock/page/demo_page/local_i10l/local_page.dart';
import 'package:flutter_bedrock/page/demo_page/main/first/cache_data_page.dart';
import 'package:flutter_bedrock/page/demo_page/main/first/ffloat_page.dart';
import 'package:flutter_bedrock/page/demo_page/main/first/update_page.dart';
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


///观测路由，可以对路由的push和pop进行观测
///具体可以查看 类：RouteAwareWidget
final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

///root widget的 key，暂时没什么用
/// 不过你可以用它进行无context跳转，eg：
/// navigatorKey.currentState.pop()
/// navigatorKey.currentState.pushNamed('update_page');
/// 不过我不太喜欢这样用(该框架内也并没有这样使用)
final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

/*
* 2020年9月9日16:02:34
*
* 路由改版后，下方全部废弃，你可以将它们删除
*
*
* */


//class RouteName{
//
//  static const String demo_page = "demo_page";
//  static const String demo_exception_page = "demo_exception_page";
//  static const String main_page = 'main_page';
//  static const String login_page = 'login_page';
//  static const String pick_image_page = 'pick_image_page';
//  static const String demo_other_page = 'demo_other_page';
//  static const String scroll_page = 'scroll_page';
//  static const String little_util_page = 'little_util_page';
//  static const String slide_out_page = 'slide_out_page';
//  static const String timer_page = 'timer_page';
//  static const String permissions_page = 'permissions_page';
//  static const String ffloat_page = 'ffloat_page';
//  static const String cache_data_page = 'cache_data_page';
//  static const String update_page = 'update_page';
//
//  static const String route_anim_page = 'route_anim_page';
//  static const String fade_page = 'fade_page';
//  static const String scale_page = 'scale_page';
//  static const String slide_page = 'slide_page';
//
//  static const String local_i10l_page = 'local_i10l_page';
//
//  static const String isolate_page = 'isolate_page';
//
//
//  ///对指定图片进行裁剪、并返回对应路径
//  static const String editor_image_page = "editor_image_page";
//  ///显示大图
//  static const String show_big_image = "show_big_image";
//  ///web/html
//  static const String web_page = 'web_page';
//  static const String html_page = 'html_page';
//
//  ///dialog式progress
//  //static const String dialog_progress = 'dialog_progress';
//
//
//
//}
//
//
//
//class Router{
//
//  static Route<dynamic> generateRoute(RouteSettings settings){
//    switch(settings.name) {
//      case RouteName.isolate_page:
//        return pageBuilder.wrapWithNoAnim(IsolatePage());
//      case RouteName.update_page:
//        return pageBuilder.wrapWithNoAnim(UpdatePage());
//      case RouteName.demo_page:
//        ///注意这个方法 :wrapAwareWidget()
//        ///这样包裹后，页面的pop和push就可以监听到，具体怎么使用可以根据你的业务需求来 eg:页面恢复、统计等
//        ///代码参见 :RouteAwareWidget 和日志
//        return pageBuilder.wrapWithNoAnim(wrapAwareWidget(RouteName.demo_page,DemoPage()));
//      case RouteName.scroll_page:
//        return pageBuilder.wrapWithNoAnim(ScrollPage());
//      case RouteName.cache_data_page:
//        return pageBuilder.wrapWithNoAnim(CacheDataPage());
//      case RouteName.little_util_page:
//        return pageBuilder.wrapWithNoAnim(LittleUtilPage());
//      case RouteName.ffloat_page:
//        return pageBuilder.wrapWithNoAnim(FFloatPage());
//      case RouteName.permissions_page:
//        return pageBuilder.wrapWithNoAnim(RequestPermissionsPage());
//      case RouteName.demo_other_page:
//        return pageBuilder.wrapWithNoAnim(OtherDemoPage());
//      case RouteName.local_i10l_page:
//        return pageBuilder.wrapWithNoAnim(LocalPage());
//      case RouteName.login_page:
//        return pageBuilder.wrapWithSlideTopAnim(LoginPage());
//      case RouteName.pick_image_page:
//        return pageBuilder.wrapWithNoAnim(PickImagePage());
//      case RouteName.main_page:
//        return pageBuilder.wrapWithNoAnim(MainPage());
//      case RouteName.demo_exception_page:
//        return pageBuilder.wrapWithNoAnim(wrapAwareWidget(RouteName.demo_exception_page, HandleExceptionPage()));
//      case RouteName.slide_out_page:
//        return pageBuilder.wrapWithSlideAnim(wrapAwareWidget(RouteName.slide_out_page, SlideOutPage()));
//      case RouteName.timer_page:
//        return pageBuilder.wrapWithNoAnim(TimerPage());
//
//      case RouteName.route_anim_page:
//        return pageBuilder.wrapWithNoAnim(RouteAnimationPage());
//      case RouteName.slide_page:
//        return pageBuilder.wrapWithSlideTopAnim(SlidePage());
//      case RouteName.fade_page:
//        return pageBuilder.wrapWithFadeAnim(FadePage());
//      case RouteName.scale_page:
//        return pageBuilder.wrapWithScaleAnim(ScalePage());
//
//      case RouteName.web_page:
//        return pageBuilder.wrapWithNoAnim(WebPageState(settings.arguments).generateWidget());
//      case RouteName.html_page:
//        return pageBuilder.wrapWithNoAnim(HtmlPage(settings.arguments));
//
//      case RouteName.editor_image_page:
//        ///外层为动画
//        return pageBuilder.wrapWithSlideTopAnim(ImageEditorState(settings.arguments).generateWidget());
//      case RouteName.show_big_image:
//        return pageBuilder.wrapWithNoAnim(DetailImageWidget(settings.arguments));
////      case RouteName.dialog_progress:
////        return NoAnimRouteBuilder(LoadingProgress());
//    }
//  }
//
//  static RouteAwareWidget wrapAwareWidget(String name,Widget page){
//    assert(name != null, 'name must not null');
//    assert(page != null,'page child must not null');
//    return RouteAwareWidget(name, page);
//  }
//
//}