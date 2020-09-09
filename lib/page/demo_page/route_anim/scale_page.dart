

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bedrock/base_framework/widget_state/page_state.dart';



class ScalePageState extends PageState {
  @override
  Widget build(BuildContext context) {
    return switchStatusBar2Dark(child: Container(
      color: Colors.red,width: getWidthPx(750),height: getHeightPx(1334),
      alignment: Alignment.center,
      child: Text("scale page"),
    ));
  }
}

















