import 'package:flutter/material.dart';

class NoAnimRouteBuilder extends PageRouteBuilder {
  final Widget page;
  final RouteSettings routeSettings;

  NoAnimRouteBuilder(this.page,this.routeSettings)
      : super(settings:routeSettings,
      opaque: false,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: Duration(milliseconds: 0),
      transitionsBuilder:
          (context, animation, secondaryAnimation, child) => child);
}