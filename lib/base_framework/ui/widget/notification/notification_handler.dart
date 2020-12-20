


import 'package:flutter/cupertino.dart';
import 'package:flutter_bedrock/base_framework/ui/widget/notification/common_notification_widget.dart';

typedef NotifyStatusListener = void Function(NotifyStatus notifyStatus);

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

  final List<NotifyStatusListener> listeners = [];

  @override
  void showNotificationFromTop(BuildContext context,{@required Widget child,Duration animationDuration, Duration notifyDwellTime}) {
    NotifyOverlayEntry notifyOverlayEntry = NotifyOverlayEntry(child,
        animationDuration??Duration(milliseconds: 500),
        notifyDwellTime??Duration(milliseconds: 200));
    Overlay.of(context).insert(notifyOverlayEntry.overlayEntry);
  }

  /// if you wanna custom show type or anyway,
  /// plz refer to the [showNotificationFromTop] method.
  @override
  void showNotificationCustom(BuildContext context, {Widget child, Duration animationDuration, Duration notifyDwellTime}) {
    // TODO: implement showNotificationCustom
  }

  @override
  void addNotifyListener(NotifyStatusListener listener) {
    listeners.add(listener);
  }

  @override
  void removeNotifyListener(NotifyStatusListener listener) {
    listeners.remove(listener);
  }

  @override
  void clearAllListener() {
    listeners.clear();
  }


}

enum NotifyStatus{
  Running,Completed
}

abstract class INotification{
  void showNotificationFromTop(BuildContext context,{@required Widget child,Duration animationDuration, Duration notifyDwellTime});
  void showNotificationCustom(BuildContext context,{@required Widget child,Duration animationDuration, Duration notifyDwellTime});
  void addNotifyListener(NotifyStatusListener listener);
  void removeNotifyListener(NotifyStatusListener listener);
  void clearAllListener();
}

enum NotifyType{
  FromTop
}

class NotifyOverlayEntry{
  final Widget notifyWidget;

  final Duration animationDuration;
  final Duration notifyDwellTime;

  OverlayEntry entry;
  bool notifyDone = false;

  OverlayEntry get  overlayEntry => entry;

  NotifyOverlayEntry(this.notifyWidget, this.animationDuration, this.notifyDwellTime,{NotifyType notifyType = NotifyType.FromTop}){
    switch(notifyType){
      case NotifyType.FromTop:
        entry = OverlayEntry(builder: (ctx){
          return FromTopNotifyWidget(notifyWidget,(notifyDone){
            this.notifyDone = notifyDone;
            if(notifyDone) overlayEntry.remove();
          },
              animationDuration,notifyDwellTime).generateWidget();
        });
        break;
    }
  }



}













