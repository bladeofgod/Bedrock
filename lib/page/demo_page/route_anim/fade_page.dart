

import 'package:flutter/material.dart';
import 'package:flutter_bedrock/base_framework/widget_state/base_state.dart';

class FadePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return FadePageState();
  }

}

class FadePageState extends BaseState<FadePage> {
  @override
  Widget build(BuildContext context) {
    return switchStatusBar2Dark(child: Container(
      color: Colors.orangeAccent,width: getWidthPx(750),height: getHeightPx(1334),
      alignment: Alignment.center,
      child: Text("fade page"),
    ));
  }
}



























