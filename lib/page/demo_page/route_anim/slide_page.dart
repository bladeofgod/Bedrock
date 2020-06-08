


import 'package:flutter/material.dart';
import 'package:flutter_bedrock/base_framework/widget_state/base_state.dart';

class SlidePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return SlidePageState();
  }

}

class SlidePageState extends BaseState<SlidePage> {
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