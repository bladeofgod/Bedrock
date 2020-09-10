


import 'package:flutter/material.dart';

class FadeRouteBuilder extends PageRouteBuilder {
  final Widget page;
  final RouteSettings routeSettings;

  FadeRouteBuilder(this.page,this.routeSettings)
      : super(settings:routeSettings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: Duration(milliseconds: 500),
      transitionsBuilder: (context, animation, secondaryAnimation,
          child) =>
          FadeTransition(
            opacity: Tween(begin: 0.1, end: 1.0).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.fastOutSlowIn,
            )),
            child: child,
          ));
}