


import 'package:flutter/material.dart';

class NineFlowDelegate extends MultiChildLayoutDelegate{

  final int length;

  NineFlowDelegate(this.length);

  @override
  void performLayout(Size size) {
    final double itemWidth = size.width/3-30;
    debugPrint("$size-----$itemWidth");
    for(int i = 0; i< length ; i++){
      final BoxConstraints constraints = BoxConstraints(
        minWidth: 0.0,
        maxWidth: itemWidth, // The leading widget shouldn't take up more than 1/3 of the space.
        minHeight: itemWidth, // The height should be exactly the height of the bar.
        maxHeight: itemWidth,
      );
      /// 行内 child的X位置 系数
      final rowX = i%3;

      layoutChild(i,constraints);
      switch(i){
        case 0:
        case 1:
        case 2:
          positionChild(i, Offset((rowX*itemWidth)+10,0));
          break;
        case 3:
        case 4:
        case 5:
          positionChild(i, Offset((rowX*itemWidth)+10,(1*itemWidth)+10));
          break;
        case 6:
        case 7:
        case 8:
          positionChild(i, Offset((rowX*itemWidth)+10,(2*itemWidth)+10));
          break;
      }
    }
  }

  @override
  bool shouldRelayout(NineFlowDelegate oldDelegate) {
    return oldDelegate.length != length;
  }


}