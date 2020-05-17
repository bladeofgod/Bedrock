import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

const int _windowPopupDuration = 300;
const double _kWindowCloseIntervalEnd = 2.0 / 3.0;
const Duration _kWindowDuration = Duration(milliseconds: _windowPopupDuration);

/*
* 在指定位置弹出窗口
* */

class PopupWindowButton<T> extends StatefulWidget {
  PopupWindowButton({
    Key key,
    this.child,
    this.window,
    @required this.isLocalToGlobal,
    @required this.globalOffset,
    this.offset = Offset.zero,
    this.elevation = 2.0,
    this.duration = 300,
    this.type = MaterialType.card,
    this.pressCallBack,
    this.windowDismiss,
    this.barrierColor,
    this.barrierDismissible = true,
  }) : super(key: key);

  ///拓展该工具类的定位类型，true:以屏幕左上角为定位，false以child为基点定位
  final bool isLocalToGlobal;
  final Offset globalOffset;

  final Function windowDismiss;

  final Function pressCallBack;///点击时调用
  /// 显示按钮button
  final Widget child;

  /// window 出现的位置。
  final Offset offset;

  /// 阴影
  final double elevation;

  /// 需要显示的window
  final Widget window;

  /// 按钮按钮后到显示window 出现的时间
  final int duration;

  final MaterialType type;

  final Color barrierColor;

  final bool barrierDismissible;

  _PopupWindowRoute popupWindowRoute ;

  PopupWindowButtonState popWindowState;


  @override
  PopupWindowButtonState createState() {
    popWindowState = PopupWindowButtonState();
    return popWindowState;
  }
}

void showWindow<T>({
  @required _PopupWindowRoute popupWindowRoute,
  @required BuildContext context,
  RelativeRect position,
  @required Widget window,
  double elevation = 8.0,
  int duration = _windowPopupDuration,
  String semanticLabel,
  MaterialType type,
  Function windowDismiss
}) {

  Navigator.push(
    context,
    popupWindowRoute,
  ).then((_){
    windowDismiss();
  });
}

class PopupWindowButtonState<T> extends State<PopupWindowButton> {



  void mShowWindow() {
    final RenderBox button = context.findRenderObject();
    final RenderBox overlay = Overlay.of(context).context.findRenderObject();
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(widget.offset, ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset.zero),
            ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );

    widget.popupWindowRoute = _PopupWindowRoute<T>(
      isLocalToGlobal: widget.isLocalToGlobal,
      globalOffset: widget.globalOffset,
      barrierC: widget.barrierColor,
        barrierDis: widget.barrierDismissible,
        position: position,
        child: widget.window,
        elevation: widget.elevation,
        duration: widget.duration,
        semanticLabel: null,
        barrierLabel:
        MaterialLocalizations.of(context).modalBarrierDismissLabel,
        type: widget.type);

    showWindow<T>(
        popupWindowRoute: widget.popupWindowRoute,
        context: context,
        window: widget.window,
        position: position,
        duration: widget.duration,
        elevation: widget.elevation,
        type: widget.type,windowDismiss: widget.windowDismiss);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        mShowWindow();
        if(widget.pressCallBack != null) widget.pressCallBack();
      },
      child: widget.child,
    );
  }
}

class _PopupWindowRoute<T> extends PopupRoute<T> {
  _PopupWindowRoute({
    this.isLocalToGlobal,
    this.globalOffset,
    this.barrierC,
    this.barrierDis,
    this.position,
    this.child,
    this.elevation,
    this.theme,
    this.barrierLabel,
    this.semanticLabel,
    this.duration,
    this.type = MaterialType.card,
  });

  final bool barrierDis;
  final Color barrierC;

  final bool isLocalToGlobal;
  final Offset globalOffset;

  @override
  Animation<double> createAnimation() {
    return CurvedAnimation(
        parent: super.createAnimation(),
        curve: Curves.linear,
        reverseCurve: const Interval(0.0, _kWindowCloseIntervalEnd));
  }

  final RelativeRect position;
  final Widget child;
  final double elevation;
  final ThemeData theme;
  final String semanticLabel;
  @override
  final String barrierLabel;
  final int duration;
  final MaterialType type;

  @override
  Duration get transitionDuration =>
      duration == 0 ? _kWindowDuration : Duration(milliseconds: duration);

  @override
  bool get barrierDismissible => barrierDis;

  @override
  Color get barrierColor => barrierC;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    final CurveTween opacity =
        CurveTween(curve: const Interval(0.0, 1.0 / 3.0));

    return Builder(
      builder: (BuildContext context) {
        return CustomSingleChildLayout(
          delegate: _PopupWindowLayout(position,isLocalToGlobal,globalOffset),
          child: AnimatedBuilder(
              child: child,
              animation: animation,
              builder: (BuildContext context, Widget child) {
                return Opacity(
                  opacity: opacity.evaluate(animation),
                  child: Material(
                    color: Colors.transparent,
                    type: type,
                    elevation: elevation,
                    child: child,
                  ),
                );
              }),
        );
      },
    );
  }
}

class _PopupWindowLayout extends SingleChildLayoutDelegate {
  _PopupWindowLayout(this.position,this.isLocalToGlobal,this.globalOffset);

  // Rectangle of underlying button, relative to the overlay's dimensions.
  final RelativeRect position;

  final bool isLocalToGlobal;
  final Offset globalOffset;

  // We put the child wherever position specifies, so long as it will fit within
  // the specified parent size padded (inset) by 8. If necessary, we adjust the
  // child's position so that it fits.

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    // The menu can be at most the size of the overlay minus 8.0 pixels in each
    // direction.
    return BoxConstraints.loose(constraints.biggest);
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    // size: The size of the overlay.
    // childSize: The size of the menu, when fully open, as determined by
    // getConstraintsForChild.

    // Find the ideal vertical position.
    double y = position.top;

    // Find the ideal horizontal position.
    double x;
    if (position.left >= position.right) {
      // Menu button is closer to the right edge, so grow to the left, aligned to the right edge.
      x = size.width - position.right - childSize.width;
    } else if (position.left <= position.right) {
      // Menu button is closer to the left edge, so grow to the right, aligned to the left edge.
      x = position.left;
    }
    return isLocalToGlobal ? globalOffset : Offset(x, y);
  }

  @override
  bool shouldRelayout(_PopupWindowLayout oldDelegate) {
    return position != oldDelegate.position;
  }
}
