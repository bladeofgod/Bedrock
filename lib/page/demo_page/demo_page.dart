/*
* Author : LiJiqqi
* Date : 2020/5/28
*/


import 'package:flutter/material.dart';
import 'package:flutter_bedrock/base_framework/config/router_manager.dart';
import 'package:flutter_bedrock/base_framework/ui/widget/web/html_page.dart';
import 'package:flutter_bedrock/base_framework/ui/widget/web/web_page.dart';
import 'package:flutter_bedrock/base_framework/widget_state/base_state.dart';
import 'package:flutter_bedrock/base_framework/widget_state/page_state.dart';
import 'package:flutter_bedrock/page/demo_page/exception/exception_main_page.dart';
import 'package:flutter_bedrock/page/demo_page/exception/handle_exception_page.dart';
import 'package:flutter_bedrock/page/demo_page/image/image_main_demo.dart';
import 'package:flutter_bedrock/page/demo_page/image/pick_image_page.dart';
import 'package:flutter_bedrock/page/demo_page/isolate/isolate_page.dart';
import 'package:flutter_bedrock/page/demo_page/local_i10l/local_page.dart';
import 'package:flutter_bedrock/page/demo_page/main_page.dart';
import 'package:flutter_bedrock/page/demo_page/notification/notification_page.dart';
import 'package:flutter_bedrock/page/demo_page/other/custom_dialog_page.dart';
import 'package:flutter_bedrock/page/demo_page/other/part_refresh_page.dart';
import 'package:flutter_bedrock/page/demo_page/other_demo_page.dart';
import 'package:flutter_bedrock/page/demo_page/route_anim/route_animation_page.dart';
import 'package:flutter_bedrock/page/demo_page/slide_out_page.dart';
import 'package:flutter_bedrock/page/demo_page/start/start_page.dart';
import 'package:flutter_bedrock/page/exception/exception_page.dart';
import 'package:flutter_bedrock/service_api/bedrock_repository_proxy.dart';

///demo，代码分包比较随意


class DemoPageState extends PageState {

  final String htmlData = """
        <div>
          <h1>Demo Page</h1>
          <p>This is a fantastic product that you should buy!</p>
          <h3>Features</h3>
          <ul>
            <li>It actually works</li>
            <li>It exists</li>
            <li>It doesn't cost much!</li>
          </ul>
          <!--You can pretty much put any html in here!-->
        </div>
      """;

  @override
  Widget build(BuildContext context) {

    return switchStatusBar2Dark(child: Container(
      width: getWidthPx(750),height: getHeightPx(1334),
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            getSizeBox(height: getWidthPx(100)),

            buildIntro("看这里！入门第一步"),
            RaisedButton(
              child: Text("build page & push/pop demo ",style: TextStyle(color: Colors.black),),
              onPressed: (){
                push(StartPage());
              },
            ),
            getSizeBox(height: getHeightPx(40)),
            buildIntro("综合性框架功能演示DEMO"),
            RaisedButton(
              child: Text("main page",style: TextStyle(color: Colors.black),),
              onPressed: (){
                push(MainPageState());
              },
            ),
            /// part refresh
            getSizeBox(height: getHeightPx(40)),
            buildIntro("局部刷新 demo"),
            RaisedButton(
              child: Text("局部刷新 page",style: TextStyle(color: Colors.black),),
              onPressed: (){
                push(PartRefreshPage());
              },
            ),

            getSizeBox(height: getHeightPx(40)),
            buildIntro("app observe 功能演示"),
            RaisedButton(
              child: Text("app observe ",style: TextStyle(color: Colors.black),),
              onPressed: (){
                push(IsolatePageState());
              },
            ),
            getSizeBox(height: getHeightPx(40)),
            buildIntro("app 内部通知演示"),
            RaisedButton(
              child: Text("app 内部通知 ",style: TextStyle(color: Colors.black),),
              onPressed: (){
                push(NotificationPage());
              },
            ),

            getSizeBox(height: getWidthPx(40)),
            ///重构后不再使用pushname，所以屏蔽这里
//            buildIntro("路由丢失DEMO"),
//            RaisedButton(
//              child: Text("route missing",style: TextStyle(color: Colors.black),),
//              onPressed: (){
//                Navigator.of(context).pushNamed("missing");
//              },
//            ),
//            getSizeBox(height: getHeightPx(40)),
            buildIntro("API请求的异常捕获和处理DEMO"),
            RaisedButton(
              child: Text("demo handle exception",style: TextStyle(color: Colors.black),),
              onPressed: (){
                push(ExceptionMainPage());
              },
            ),
            getSizeBox(height: getHeightPx(40)),
            buildIntro("自定义浮层 demo"),
            RaisedButton(
              child: Text("弹出自定义的widget 演示",style: TextStyle(color: Colors.black),),
              onPressed: (){
                push(CustomDialogPage());
              },
            ),

            getSizeBox(height: getHeightPx(40)),
            buildIntro("左侧滑动返回上一页"),
            RaisedButton(
              child: Text("left slide to pop page",style: TextStyle(color: Colors.black),),
              onPressed: (){
                push(SlideOutPageState());
              },
            ),
            getSizeBox(height: getHeightPx(40)),
            buildIntro("web/html DEMO"),
            RaisedButton(
              child: Text("web page",style: TextStyle(color: Colors.black),),
              onPressed: (){
                String url = 'https://github.com/bladeofgod/Bedrock';
                push(WebPageState(url));
              },
            ),
            getSizeBox(height: getHeightPx(20)),
            RaisedButton(
              child: Text("html page",style: TextStyle(color: Colors.black),),
              onPressed: (){
                push(HtmlPageState(htmlData));
              },
            ),
            getSizeBox(height: getHeightPx(40)),
            buildIntro("图片相关 DEMO"),
            RaisedButton(
              child: Text("image page",style: TextStyle(color: Colors.black),),
              onPressed: (){
                push(ImageMainDemo());
              },
            ),
            getSizeBox(height: getHeightPx(40)),
            buildIntro("页面跳转动画 DEMO"),
            RaisedButton(
              child: Text("route animation page",style: TextStyle(color: Colors.black),),
              onPressed: (){
                push(RouteAnimationPageState());
              },
            ),
            getSizeBox(height: getHeightPx(40)),
            buildIntro("国际化 DEMO"),
            RaisedButton(
              child: Text("i10l page",style: TextStyle(color: Colors.black),),
              onPressed: (){
                push(LocalPageState());
              },
            ),
            getSizeBox(height: getHeightPx(40)),
            buildIntro("实验室 DEMO"),
            RaisedButton(
              child: Text("laboratory page",style: TextStyle(color: Colors.black),),
              onPressed: (){
                push(OtherDemoPageState());
              },
            ),
            getSizeBox(height: getHeightPx(40)),
            buildIntro("dialog 式 loading 演示"),
            RaisedButton(
              child: Text("dialog progress page",style: TextStyle(color: Colors.black),),
              onPressed: (){
                showProgressDialog();
                Future.delayed(Duration(seconds: 2)).then((value) => dismissProgressDialog());
              },
            ),
            getSizeBox(height: getHeightPx(40)),
          ],
        ),
      ),
    ));
  }

  Widget buildIntro(String str){
    return Text(str,style: TextStyle(color: Colors.black,fontSize: getSp(28)),);
  }
}