

import 'package:flutter/material.dart';

class SlideTopRouteBuilder extends PageRouteBuilder {
  final Widget page;
  final RouteSettings routeSettings;

  SlideTopRouteBuilder(this.page,this.routeSettings)
      : super(settings:routeSettings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: Duration(milliseconds: 800),
      transitionsBuilder:
          (context, animation, secondaryAnimation, child) =>
          SlideTransition(
            position: Tween<Offset>(
                begin: Offset(0.0, -1.0), end: Offset(0.0, 0.0))
                .animate(CurvedAnimation(
                parent: animation, curve: Curves.fastOutSlowIn)),
            child: child,
          ));
}


class SlideBottomRouteBuilder extends PageRouteBuilder{
  final Widget page;

  SlideBottomRouteBuilder(this.page)
      : super(
    pageBuilder:(ctx,animation,secondaryAnimation)=>page,
    transitionDuration:Duration(milliseconds: 800),
    transitionsBuilder:(ctx,animation,secondaryAnimation,child)
        => SlideTransition(
          position: Tween<Offset>(
            begin: Offset(0.0,1.0),
            end: Offset(0.0,0.0),
          ).animate(CurvedAnimation(
            parent: animation,curve: Curves.fastOutSlowIn
          )),
          child: child,
        )
  );



}

///右滑进入，同时如果需要左侧滑动退出的，请使用此动画

class SlideRightRouteBuilder extends PageRouteBuilder{
  final Widget page;
  final RouteSettings routeSettings;


  SlideRightRouteBuilder(this.page,this.routeSettings)
      :super(settings:routeSettings,
      pageBuilder:(ctx,animation,secondaryAnimation)=>page,
      opaque:false,
      transitionDuration:Duration(milliseconds: 300),
      transitionsBuilder:(ctx,animation,secondaryAnimation,child)
      => SlideTransition(
        position: Tween<Offset>(
          begin: Offset(1.0,0.0),
          end: Offset(0.0,0.0),
        ).animate(CurvedAnimation(
            parent: animation,curve: Curves.fastOutSlowIn
        )),
        child: child,
      )
  );
}






















