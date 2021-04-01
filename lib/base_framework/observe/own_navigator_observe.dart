/*
* Author : LiJiqqi
* Date : 2020/7/17
*/



import 'package:flutter/material.dart';

class OwnNavigatorObserve extends NavigatorObserver{


  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {

  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {

  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    log('pop route', route?.settings?.name);
    log('pop previous', previousRoute?.settings?.name);
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    log('push route', route?.settings?.name);
    log('push previous', previousRoute?.settings?.name);

  }

  void log(String title,String? info){}
}





















