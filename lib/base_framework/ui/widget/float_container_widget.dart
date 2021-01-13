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

///浮层(页面)的 [RouteSettings].name
/// * 某些情况，可能需要当前route的名字，故这里标记上。
final String floatLayerRouteName = 'FloatContainerWidget';

class FloatContainerWidget extends WidgetState{

  ///背景颜色
  final Color bgColor;
  final Widget child;
  ///对齐方式
  final Alignment alignment;
  ///是否点击背景可以退出
  final bool barrierDismissible;
  ///‘pop’ 退出 外置
  ///例如，我们需要做一个动画后再弹出。
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





















