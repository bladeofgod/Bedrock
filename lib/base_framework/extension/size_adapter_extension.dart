

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';

extension SizeAdapterExtension on num{

  ///获取适配后的宽度
  double get w => ScreenUtil.getInstance().getWidthPx(this.toDouble());

  ///获取适配后的高度
  double get h => ScreenUtil.getInstance().getHeightPx(this.toDouble());

  ///获取适配后的文本尺寸
  double get sp => ScreenUtil.getInstance().getSp(this.toDouble());

  ///获取一个用于纵向占位的[SizedBox]
  /// * eg. [Column] 的空间占位
  SizedBox get vGap => SizedBox(width: 1,height: w,);

  ///获取一个用于横向占位的sizeBox[SizedBox]
  /// * eg. [Row] 的空间占位
  SizedBox get hGap => SizedBox(width: w,height: 1,);

}

























