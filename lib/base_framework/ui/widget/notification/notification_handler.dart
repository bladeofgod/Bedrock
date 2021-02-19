


import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bedrock/base_framework/ui/widget/notification/common_notification_widget.dart';


///通知状态
enum NotifyStatus { Running, Completed }

///通知显示类型
enum NotifyType {
  ///顶部滑出
  FromTop
}

///通知状态回调
typedef NotifyStatusListener = void Function(NotifyStatus notifyStatus);

class NotificationHandler extends Notification {
  static NotificationHandler _singleton;

  factory NotificationHandler() => getInstance();

  static NotificationHandler getInstance() {
    if (_singleton == null) {
      _singleton = new NotificationHandler._();
    }
    return _singleton;
  }



  ///批量通知是否全部显示完毕
  bool streamDone = true;

  StreamController<NotifyListItemWrapper> _streamController;
  StreamSink<NotifyListItemWrapper> _sink;

  StreamSubscription<NotifyListItemWrapper> _subscription;

  NotificationHandler._() {
    _streamController = StreamController<NotifyListItemWrapper>();
    _sink = _streamController.sink;

    _subscription = _streamController.stream.listen((event) {
      if (event == null) {
        streamDone = true;
        if (!_subscription.isPaused) {
          _subscription.pause();
        }
        if (listCompleter != null) {
          listCompleter.complete();
          listCompleter = null;
        }
        return;
      }
      _subscription.pause();
      showNotificationFromTop(child: event.child, animationDuration: event.animationDuration, notifyDwellTime: event.notifyDwellTime);
    });

    _subscription.pause();
  }

  ///注册监听列表
  final List<NotifyStatusListener> _listeners = [];

  void _notifyListener(NotifyStatus notifyStatus) {
    _listeners.forEach((element) {
      element(notifyStatus);
    });
  }

  /// @param [animationDuration] child 从顶部滑出/收回所需时间
  /// @param [notifyDwellTime]  通知 停留时间
  @override
  Future showNotificationFromTop({@required Widget child, Duration animationDuration, Duration notifyDwellTime}) async {
    Completer completer = Completer();
    NotifyOverlayEntry notifyOverlayEntry =
    NotifyOverlayEntry(child, animationDuration ?? Duration(milliseconds: 500), notifyDwellTime ?? Duration(seconds: 2000), callback: () {
      completer.complete();
      if (!streamDone) {
        _subscription.resume();
      }

      ///通知结束回调
      _notifyListener(NotifyStatus.Completed);
    });

    /// assume [.insert] is start notify in [NotifyStatus.Running].
    _notifyListener(NotifyStatus.Running);
    Overlay.of(context).insert(notifyOverlayEntry.overlayEntry);
    return completer.future;
  }

  /// if you wanna custom show type or anyway,
  /// plz refer to the [showNotificationFromTop] method.
  @override
  Future showNotificationCustom({Widget child, Duration animationDuration, Duration notifyDwellTime}) {
    // TODO: implement showNotificationCustom
  }

  @override
  void addNotifyListener(NotifyStatusListener listener) {
    _listeners.add(listener);
  }

  @override
  void removeNotifyListener(NotifyStatusListener listener) {
    _listeners.remove(listener);
  }

  @override
  void clearAllListener() {
    _listeners.clear();
  }

  Completer listCompleter;

  ///批量显示通知
  /// * 依然要慎重使用，例如： 服务器积压过多通知，导致用户界面长期弹出通知造成较差的用户体验
  @override
  Future showNotifyListFromTop({List<Widget> children, Duration animationDuration, Duration notifyDwellTime}) async {
    listCompleter = Completer();

    children.forEach((element) {
      _sink.add(NotifyListItemWrapper(element, animationDuration, notifyDwellTime));
    });
    _sink.add(null);
    if (streamDone) {
      streamDone = false;
      _subscription.resume();
    }

    return listCompleter.future;
  }



}

///通知内容实体
class NotifyOverlayEntry {
  final Widget notifyWidget;

  ///通知滑出所需时间
  final Duration animationDuration;

  ///通知停滞时间
  final Duration notifyDwellTime;

  ///通知结束
  final VoidCallback callback;

  ///通知类型（动画）
  final NotifyType notifyType;

  OverlayEntry entry;
  bool notifyDone = false;

  OverlayEntry get overlayEntry => entry;

  NotifyOverlayEntry(this.notifyWidget, this.animationDuration, this.notifyDwellTime,
      {@required this.callback, this.notifyType = NotifyType.FromTop}) {
    _generateOverlay();
  }

  ///根据类型 构建不同显示方式的通知
  ///目前只有一个从顶部滑出的方式
  ///如果需要拓展，请务必遵从下面的设计方式
  void _generateOverlay() {
    switch (notifyType) {
      case NotifyType.FromTop:
        entry = OverlayEntry(builder: (ctx) {
          return FromTopNotifyWidget(notifyWidget, animationDuration, notifyDwellTime, (notifyDone) {
            this.notifyDone = notifyDone;
            if (notifyDone) overlayEntry.remove();
            callback();
          }).generateWidget();
        });
        break;
    }
  }
}

///通知操作模块
class NotifyListItemWrapper {
  final Widget child;
  final Duration animationDuration;
  final Duration notifyDwellTime;

  NotifyListItemWrapper(this.child, this.animationDuration, this.notifyDwellTime);
}


///通知基类
abstract class Notification {

  BuildContext context;

  ///建议在跟页面调用此方法
  void init(BuildContext context){
    if(this.context != null)return;
    this.context = context;
  }

  Future showNotificationFromTop({@required Widget child, Duration animationDuration, Duration notifyDwellTime});

  Future showNotifyListFromTop({@required List<Widget> children, Duration animationDuration, Duration notifyDwellTime});

  Future showNotificationCustom({@required Widget child, Duration animationDuration, Duration notifyDwellTime});

  void addNotifyListener(NotifyStatusListener listener);

  void removeNotifyListener(NotifyStatusListener listener);

  void clearAllListener();

  ///特殊情况，你需要刷新context
  /// * 一般情况下，在项目根页面初始化[NotificationHandler]后，不需要下面这个方法
  /// * 如果你在子页面，即生命周期较短的页面来初始化后，再次使用可能需要调用此方法

  void refreshContext(BuildContext context){
    this.context = context;
  }
}