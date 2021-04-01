/*
* Author : LiJiqqi
* Date : 2020/6/3
*
* 用于显示富文本
*/

import 'package:flutter/material.dart';
import 'package:flutter_bedrock/base_framework/widget_state/page_state.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HtmlPageState extends PageState {
  final String htmlContent;

  HtmlPageState(this.htmlContent);

  @override
  Widget build(BuildContext context) {
    return switchStatusBar2Dark(
        child: Container(
      width: getWidthPx(750),
      height: getHeightPx(1334),
      child: Column(
        children: <Widget>[
          commonAppBar(
              leftWidget: buildAppBarLeft(),
              leftPadding: getWidthPx(40),
              rightPadding: getWidthPx(40)),
          Expanded(
            child: WebView(
              initialUrl: Uri.dataFromString(htmlContent, mimeType: 'text/html')
                  .toString(),
            ),
          ),
        ],
      ),
    ));
  }
}
