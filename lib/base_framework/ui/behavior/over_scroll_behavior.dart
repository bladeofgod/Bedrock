


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


/// dislodge the any subclass of ScrollView's inkwell
/// 去除scroll view的 水印

class OverScrollBehavior extends ScrollBehavior{

  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    // TODO: implement buildViewportChrome
    switch(getPlatform(context)){
      //case TargetPlatform.macOS:
      case TargetPlatform.iOS:
        return child;
      case TargetPlatform.fuchsia:
      case TargetPlatform.android:
        return GlowingOverscrollIndicator(
          child: child,
          //do not show head's inkwell
          showLeading: false,
          //do not show tail's inkwell
          showTrailing: false,
          axisDirection: axisDirection,
          color: Theme.of(context).accentColor,
        );

    }
    return null;
  }

}