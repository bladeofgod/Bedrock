
import 'package:flutter/material.dart';
import 'package:flutter_bedrock/base_framework/ui/widget/float_container_widget.dart';
import 'package:flutter_bedrock/base_framework/widget_state/base_state.dart';
import 'package:flutter_bedrock/base_framework/widget_state/page_state.dart';
import 'package:flutter_bedrock/base_framework/widget_state/widget_state.dart';


/// 对widget的操作类
/// * [PageState] 或者 [WidgetState] 相关widget的操控放入此类内
/// * 一般混入[BaseState]

mixin ManipulateWidgetBinding<T extends StatefulWidget> on State<T> {
  ///弹出自定义widget（效果类似dialog）
  ///你可以调整你的widget来达到预期的表现效果
  ///也可以通过PageRouteBuilder的参数进行调整
  void floatWidget(Widget child,{
    //弹出层的退出由此参数控制
    //默认值Navigator.pop(ctx)，或自定义
    FloatWidgetDismiss? floatWidgetDismiss,
    bool barrierDismissible = false,
    //浮层背景色
    Color bgColor = const Color.fromRGBO(34, 34, 34, 0.3),
    //浮层对齐方式
    Alignment alignment = Alignment.center,
    //回调
    Function? afterPop,Function? onComplete,
    //页面进入/退出时间
    Duration transitionDuration = const Duration(milliseconds: 0),
    //新版本 此参数已作废
    @deprecated
    Duration reverseTransitionDuration = const Duration(milliseconds: 0),
  }){
    Navigator.of(context).push(
        PageRouteBuilder(
            settings: RouteSettings(name: floatLayerRouteName),
            transitionDuration: transitionDuration,
            //新版本无此参数
            //reverseTransitionDuration: reverseTransitionDuration,
            opaque: false,
            pageBuilder:(ctx,animation,secondAnimation){
              return FloatContainerWidget(child,
                  floatWidgetDismiss: floatWidgetDismiss??(ctx)=>Navigator.pop(ctx),
                  barrierDismissible:barrierDismissible ,bgColor: bgColor,alignment: alignment).transformToPageWidget();
            }))
        .then((value) => afterPop??(){})
        .whenComplete(() => onComplete??(){});
  }
}

























