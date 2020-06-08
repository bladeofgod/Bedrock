


import 'package:flutter/material.dart';
import 'package:flutter_bedrock/base_framework/widget_state/base_state.dart';

class LocalPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return LocalPageState();
  }

}

class LocalPageState extends BaseState<LocalPage> {
  @override
  Widget build(BuildContext context) {
    return switchStatusBar2Dark(child: Container(
      color: Colors.black,
      width: getWidthPx(750),height: getHeightPx(1334),
    ));
  }
}


















