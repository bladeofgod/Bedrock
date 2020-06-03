/*
* Author : LiJiqqi
* Date : 2020/6/3
*
* 普通网页展示，需要的也可以自定义
*/

import 'package:flutter/material.dart';
import 'package:flutter_bedrock/base_framework/widget_state/base_state.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebPage extends StatefulWidget{

  final Map arguments;


  WebPage(this.arguments);

  @override
  State<StatefulWidget> createState() {
    return WebPageState(arguments['url']);
  }

}

class WebPageState extends BaseState<WebPage> {

  final String url;


  WebPageState(this.url);

  @override
  Widget build(BuildContext context) {
    return switchStatusBar2Dark(child: Container(
      width: getWidthPx(750),
      height: getHeightPx(1334),
      child: Column(
        children: <Widget>[
          commonAppBar(leftPadding: getWidthPx(40), rightPadding: getWidthPx(40)),
          Expanded(
            child: WebviewScaffold(
              url: url,
              withJavascript: true,
            ),
          ),
        ],
      ),
    ));
  }
}

















