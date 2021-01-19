/*
* Author : LiJiqqi
* Date : 2021/1/19
*/

import 'package:flutter_bedrock/base_framework/widget_state/page_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bedrock/page/demo_page/image/nine_image/nine_image_state.dart';

class NineImagePage extends PageState{
  @override
  Widget build(BuildContext context) {
    return switchStatusBar2Dark(child: Container(
      width: getWidthPx(750),height: getHeightPx(1334),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          NineImageEditorState().generateWidget(),
          //getSizeBox(height: getWidthPx(80)),

        ],
      ),
    ));
  }

}



















