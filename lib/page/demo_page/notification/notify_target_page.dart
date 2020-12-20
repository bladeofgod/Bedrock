



import 'package:flutter/material.dart';
import 'package:flutter_bedrock/base_framework/widget_state/page_state.dart';


class NotifyTargetPage extends PageState{
  @override
  Widget build(BuildContext context) {
    return switchStatusBar2Dark(child: Container(
      width: getWidthPx(750),height: getHeightPx(1334),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('点击通知所到达的页面。',style: TextStyle(fontSize: getSp(38)),)
        ],
      ),
    ));
  }

}




















