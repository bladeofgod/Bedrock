


import 'package:flutter/material.dart';
import 'package:flutter_bedrock/base_framework/widget_state/base_state.dart';
import 'package:flutter_bedrock/main.dart';

class RouteAwareWidget extends StatefulWidget{

  final String name;
  final Widget child;


  RouteAwareWidget(this.name, this.child);

  @override
  State<StatefulWidget> createState() {
    return RouteAwareWidgetState();
  }

}

class RouteAwareWidgetState extends BaseState<RouteAwareWidget> with RouteAware {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context));
  }
  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPush() {
    debugPrint("push ${widget.name}");
    super.didPush();
  }

  @override
  void didPop() {
    debugPrint("pop ${widget.name}");
    super.didPop();
  }


  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

















