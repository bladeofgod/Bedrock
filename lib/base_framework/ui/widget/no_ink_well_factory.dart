

import 'package:flutter/material.dart';


/*
*    Theme(
*      data: ThemeData(splashFactory: NoInkWellFactory()),
*      child: childWidget,
*   );
*
*
* */


class NoInkWellFactory extends InteractiveInkFeatureFactory{
  @override
  InteractiveInkFeature create({MaterialInkController controller, RenderBox referenceBox, Offset position,
    Color color, TextDirection textDirection, bool containedInkWell = false, rectCallback, BorderRadius borderRadius,
    ShapeBorder customBorder, double radius, onRemoved}) {

    return NoInkWell(
      controller: controller,referenceBox: referenceBox
    );
  }



}


class NoInkWell extends InteractiveInkFeature{

  NoInkWell({@required MaterialInkController controller,@required RenderBox referenceBox})
      : assert(controller != null),
        assert(referenceBox != null),
        super(controller:controller,referenceBox:referenceBox);

  @override
  void paintFeature(Canvas canvas, Matrix4 transform) {

  }

}