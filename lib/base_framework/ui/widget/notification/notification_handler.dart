


import 'package:flutter/cupertino.dart';
import 'package:flutter_bedrock/base_framework/ui/widget/notification/common_notification_widget.dart';

class NotificationHandler implements INotification{

  static NotificationHandler _singleton;

  factory NotificationHandler()=>getInstance();

  static NotificationHandler getInstance(){
    if(_singleton == null){
      _singleton = new NotificationHandler._();
    }
    return _singleton;
  }

  NotificationHandler._();




  @override
  void showNotificationFromTop(BuildContext context,{@required Widget child,Duration animationDuration, Duration notifyDwellTime}) {
    OverlayEntry overlayEntry = OverlayEntry(builder: (ctx){
          return FromTopNotifyWidget(child,animationDuration??Duration(milliseconds: 500),notifyDwellTime??Duration(milliseconds: 200)).generateWidget();
    });
    Overlay.of(context).insert(overlayEntry);
  }





}

abstract class INotification{
  void showNotificationFromTop(BuildContext context,{@required Widget child,Duration animationDuration, Duration notifyDwellTime});

}














