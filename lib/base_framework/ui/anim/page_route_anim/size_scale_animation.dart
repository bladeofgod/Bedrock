

import 'package:flutter/material.dart';

class ScaleRouteBuilder extends PageRouteBuilder {
  final Widget page;

  ScaleRouteBuilder(this.page)
      : super(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionDuration: Duration(milliseconds: 300),
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
//                Align(
//                  child: SizeTransition(child: child, sizeFactor: animation),
//                ),
    ScaleTransition(
      scale: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
          parent: animation, curve: Curves.fastOutSlowIn)),
      child: child,
    ),
  );
}