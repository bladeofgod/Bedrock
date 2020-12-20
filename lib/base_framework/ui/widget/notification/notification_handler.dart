


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


  void _notifyListener(NotifyStatus notifyStatus){
    listeners.forEach((element) {
      element(notifyStatus);
    });
  }

  /// @param [animationDuration] child 从顶部滑出/收回所需时间
  /// @param [notifyDwellTime]  通知 停留时间
  @override
  void showNotificationFromTop(BuildContext context,{@required Widget child,Duration animationDuration, Duration notifyDwellTime}) {
    NotifyOverlayEntry notifyOverlayEntry = NotifyOverlayEntry(child,
        animationDuration??Duration(milliseconds: 500),
        notifyDwellTime??Duration(milliseconds: 200),callback: (){
        ///通知结束回调
         _notifyListener(NotifyStatus.Completed);
        });
    /// assume [.insert] is start notify in [NotifyStatus.Running].
    _notifyListener(NotifyStatus.Running);
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

///

class NotifyOverlayEntry{
  final Widget notifyWidget;

  final Duration animationDuration;
  final Duration notifyDwellTime;
  final VoidCallback callback;

  OverlayEntry entry;
  bool notifyDone = false;

  OverlayEntry get  overlayEntry => entry;

  NotifyOverlayEntry(this.notifyWidget, this.animationDuration, this.notifyDwellTime,{@required this.callback,
    NotifyType notifyType = NotifyType.FromTop}){
    ///根据类型 构建不同显示方式的通知
    ///目前只有一个从底部滑出的方式
    ///如果需要拓展，请务必遵从下面的设计方式
    switch(notifyType){
      case NotifyType.FromTop:
        entry = OverlayEntry(builder: (ctx){
          return FromTopNotifyWidget(notifyWidget,(notifyDone){
            this.notifyDone = notifyDone;
            if(notifyDone) overlayEntry.remove();
            callback();
          },
              animationDuration,notifyDwellTime).generateWidget();
        });
        break;
    }
  }



}













