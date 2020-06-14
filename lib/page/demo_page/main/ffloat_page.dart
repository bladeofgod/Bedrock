


import 'package:flutter/material.dart';
import 'package:flutter_bedrock/base_framework/widget_state/base_state.dart';

class FFloatPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return FFloatPageState();
  }

}

class FFloatPageState extends BaseState<FFloatPage> {
  @override
  Widget build(BuildContext context) {
    return switchStatusBar2Dark(child: Container(
      width: getWidthPx(750), height: getHeightPx(1334),
    ));
  }
}






















