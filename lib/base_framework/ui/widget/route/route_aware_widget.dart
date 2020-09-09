


import 'package:flutter/material.dart';
import 'package:flutter_bedrock/base_framework/widget_state/base_state.dart';
import 'package:flutter_bedrock/base_framework/config/router_manager.dart';

/*
* 2020年9月9日16:12:01
* 
* 路由改版后，此widget废弃
* 
* */

//class RouteAwareWidget extends StatefulWidget{
//
//  final String name;
//  final Widget child;
//
//
//  RouteAwareWidget(this.name, this.child);
//
//  @override
//  State<StatefulWidget> createState() {
//    return RouteAwareWidgetState();
//  }
//
//}
//
//class RouteAwareWidgetState extends BaseState<RouteAwareWidget> with RouteAware {
//
//  @override
//  void didChangeDependencies() {
//    super.didChangeDependencies();
//    routeObserver.subscribe(this, ModalRoute.of(context));
//  }
//  @override
//  void dispose() {
//    routeObserver.unsubscribe(this);
//    super.dispose();
//  }
//
//  @override
//  void didPush() {
//    ///将要进入的页面
//    debugPrint("push ${widget.name}");
//    super.didPush();
//  }
//
//  @override
//  void didPop() {
//    ///将要弹出的页面
//    debugPrint("pop ${widget.name}");
//    super.didPop();
//  }
//
//  @override
//  void didPopNext() {
//    ///弹出后显示的页面
//    debugPrint("pop next ${widget.name}");
//    super.didPopNext();
//  }
//
//  @override
//  void didPushNext() {
//    ///进入后，被遮挡的页面
//    debugPrint("push next ${widget.name}");
//    super.didPushNext();
//  }
//
//
//  @override
//  Widget build(BuildContext context) {
//    return widget.child;
//  }
//}
//
//















