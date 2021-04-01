/*
* Author : LiJiqqi
* Date : 2020/6/4
*/

import 'package:flutter/material.dart';
import 'package:flutter_bedrock/base_framework/ui/widget/skeleton/base_skeleton/base_skeleton_widget.dart';

/// 继承 BaseSkeletonWidget，
class FirstSkeletonPage extends BaseSkeletonWidget {
  @override
  Widget build(BuildContext context) {
    return switchStatusBar2Dark(
        child: Container(
      padding: EdgeInsets.symmetric(horizontal: getWidthPx(40)),
      width: getWidthPx(750),
      height: getHeightPx(1334),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            getSizeBox(height: getWidthPx(100)),

            ///banner
            buildBanner(),
            getSizeBox(height: getWidthPx(30)),

            ///transform
            buildTransform(),

            ///list
            ...buildList(),
          ],
        ),
      ),
    ));
  }

  List<Widget> buildList() {
    return List.generate(5, (index) => buildItem());
  }

  Widget buildItem() {
    return getShimmer(Container(
      width: getWidthPx(670),
      height: getWidthPx(310),
      decoration: BoxDecoration(
          color: skeletonColor,
          borderRadius: BorderRadius.circular(getHeightPx(10))),
      margin: EdgeInsets.only(top: getWidthPx(28)),
    ));
  }

  Widget buildTransform() {
    return Container(
      width: getWidthPx(670),
      height: getHeightPx(100),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          buildOval("", skeletonColor),
          buildOval("", skeletonColor),
          buildOval("", skeletonColor),
          buildOval("", skeletonColor),
        ],
      ),
    );
  }

  Widget buildOval(String str, Color color) {
    return getShimmer(Container(
      alignment: Alignment.center,
      width: getWidthPx(100),
      height: getWidthPx(100),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        boxShadow: [
          BoxShadow(
            color: Colors.grey[400]!,
            spreadRadius: 1.0,
            offset: Offset(0.8, 0.8),
          )
        ],
      ),
      child: Text(
        str,
        style: TextStyle(color: Colors.white, fontSize: getSp(28)),
      ),
    ));
  }

  Widget buildBanner() {
    return getShimmer(Container(
      width: getWidthPx(670),
      height: getWidthPx(292),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(getHeightPx(6)),
          color: skeletonColor),
    ));
  }
}
