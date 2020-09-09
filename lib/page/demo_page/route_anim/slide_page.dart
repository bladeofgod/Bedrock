


import 'package:flutter/material.dart';
import 'package:flutter_bedrock/base_framework/widget_state/base_state.dart';
import 'package:flutter_bedrock/base_framework/widget_state/page_state.dart';

class SlidePageState extends PageState {
  @override
  Widget build(BuildContext context) {
    return switchStatusBar2Dark(child: Container(
      color: Colors.blue,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("滑动页面"),
          ],
        )),
    );
  }
}