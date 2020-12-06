/*
* Author : LiJiqqi
* Date : 2020/12/4
* 浮层，用于承载类似对话框的widget
*
*
* 基础性浮层 ：仅提供一个 container，具体复现内容由你定。
*/

import 'package:flutter/cupertino.dart';
import 'package:flutter_bedrock/base_framework/widget_state/widget_state.dart';


typedef FloatWidgetDismiss = void Function(BuildContext context);

class FloatContainerWidget extends WidgetState{

  final Color bgColor;
  final Widget child;
  final Alignment alignment;
  final bool barrierDismissible;
  final FloatWidgetDismiss floatWidgetDismiss;

  FloatContainerWidget(this.child,{@required this.floatWidgetDismiss,this.bgColor,this.alignment,this.barrierDismissible})
    :assert(child != null),assert(floatWidgetDismiss != null);


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: (){
        if(barrierDismissible){
          floatWidgetDismiss(context);
        }
      },
      child: Container(
        color: bgColor,
        width: size.width,height: size.height,
        alignment:alignment,
        child:child,
      ),
    );
  }

}





















