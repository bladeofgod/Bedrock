import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bedrock/base_framework/factory/page/page_animation_builder.dart';
import 'package:flutter_bedrock/base_framework/ui/behavior/over_scroll_behavior.dart';
import 'package:flutter_bedrock/base_framework/ui/widget/progress_widget.dart';
import 'package:flutter_bedrock/base_framework/widget_state/base_stateless_widget.dart';
import 'package:flutter_bedrock/base_framework/widget_state/page_state.dart';
import 'package:flutter_bedrock/base_framework/widget_state/widget_state.dart';
import 'package:flutter_bedrock/base_framework/extension/size_adapter_extension.dart';

import 'binding/manipulate_widget_binding.dart';
export 'package:flutter_bedrock/base_framework/extension/size_adapter_extension.dart';

///用于创建 state
typedef StateBuilder = State Function();

/// * 请勿直接继承此类
/// * 如果是页面，继承 [PageState]
/// * 如果是view，继承 [WidgetState]
/// * 如果是stateless widget， 继承 [BaseStatelessWidget]
///
/// 此处扩展功能应该是 page和view通用功能

abstract class BaseState<T extends StatefulWidget> extends State<T> with ManipulateWidgetBinding {
  ///去掉 scroll view的 水印  e.g : listView scrollView
  ///当滑动到顶部或者底部时，继续拖动出现的蓝色水印
  Widget getNoInkWellListView({required Widget scrollView}) {
    return ScrollConfiguration(
      behavior: OverScrollBehavior(),
      child: scrollView,
    );
  }

  ///占位widget
  /// * 可以直接使用 [num.vGap] 或 [num.hGap]
  /// * 参考[SizeAdapterExtension]
  @Deprecated("已废弃，建议使用size_adapter_extension中的方法")
  Widget getSizeBox({double width = 1, double height = 1}) {
    return SizedBox(
      width: width,
      height: height,
    );
  }


  DialogLoadingController? _dialogLoadingController;

  ///在页面上方显示一个 loading widget
  ///共有两种方法，showProgressDialog是其中一种
  ///具体参见 : progress_widget.dart
  ///如果需要在 [dismissProgressDialog] 方法后跳转到其他页面或者执行什么
  ///使用 参数 [afterDismiss] 和 [dismissProgressDialog.afterPopTask] 不建议同时用使用。
  ///[loadingTimeOut] 超时时间，单位秒。
  /// * 抵达这个时间后，将自动关闭loading widget,默认15秒
  showProgressDialog(
      {Widget? progress,
        Color? bgColor, int loadingTimeOut = 15,
        AfterLoadingCallback? afterDismiss}) {
    if (_dialogLoadingController == null) {
      _dialogLoadingController = DialogLoadingController();
      Navigator.of(context)
          .push(PageRouteBuilder(
              settings: RouteSettings(name: loadingLayerRouteName),

              ///使用默认值效果可能不好
              transitionDuration: const Duration(milliseconds: 0),
              //reverseTransitionDuration: const Duration(milliseconds: 0),
              opaque: false,
              pageBuilder: (ctx, animation, secondAnimation) {
                return LoadingProgressState(
                  controller: _dialogLoadingController,
                  progress: progress,
                  bgColor: bgColor,
                  loadingTimeOut: loadingTimeOut
                ).transformToPageWidget();
              }))
          .then((value) {
        _dialogLoadingController?.invokeAfterPopTask(value);
        _dialogLoadingController = null;
        if (afterDismiss != null) {
          afterDismiss(value);
        }
      });
    }
  }

  ///隐藏loading
  /// * 注意： [afterPopTask] 会在loading隐藏后被调用，但是如果用户主动取消的话，将不会被调用
  /// *       用户主动取消的将会调用[showLoading]的[afterDismiss]
  void dismissProgressDialog({AfterLoadingCallback? afterPopTask}) {
    if (afterPopTask != null)
      _dialogLoadingController?.holdAfterPopTask(task: afterPopTask);
    _dialogLoadingController?.dismissDialog();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _dialogLoadingController = null;
    super.dispose();
  }

  /*
  * size adapter with tool ScreenUtil
  *
  * */

  ///得到适配后的高度
  /// * 可以直接使用 [num.w] 或 [num.h] 来获取适配后的尺寸
  /// * 参考[SizeAdapterExtension]
  @Deprecated("已废弃，建议使用size_adapter_extension中的方法")
  double getHeightPx(double height) => height.h;

  ///得到适配后的宽度
  /// * 可以直接使用 [num.w] 或 [num.h] 来获取适配后的尺寸
  /// * 参考[SizeAdapterExtension]
  @Deprecated("已废弃，建议使用size_adapter_extension中的方法")
  double getWidthPx(double width) => width.w;

  ///屏幕宽度
  double getScreenWidth() => ScreenUtil.getInstance().screenWidth;

  ///屏幕高度
  double getScreenHeight() => ScreenUtil.getInstance().screenHeight;

  //目前仅对于手机： 因为手机大多数情况下是长度变化较大，
  // 所以以高度来算出半径，保证异形屏的弧度不会缩小
  //有其他需求，还需要重改
  /// 得到适配后的圆角半径
  double getRadiusFromHeight(double radius) =>
      ScreenUtil.getInstance().getHeightPx(radius);

  ///得到适配后的字号
  /// * 可以直接使用 [num.w] 或 [num.h] 来获取适配后的尺寸
  /// * 参考[SizeAdapterExtension]
  @Deprecated("已废弃，建议使用size_adapter_extension中的方法")
  double getSp(double fontSize) => fontSize.sp;

/*
  * app 生命周期，建议在需要的地方自己注册监听
  *
  * */

//
//  /// current widget is visible and focusable if is true;
//  bool isResumed = true;
//
//  ///
//  bool isInactive = true;
//
//  ///cant not interact with user
//  bool isPause = false;

  ///生命周期变化时回调
//  resumed:应用可见并可响应用户操作
//  inactive:用户可见，但不可响应用户操作
//  paused:已经暂停了，用户不可见、不可操作
//  suspending：应用被挂起，此状态IOS永远不会回调

  /// just trigger at user is pressing home or back button;
//  @override
//  void didChangeAppLifecycleState(AppLifecycleState state) {
//    isResumed = state == AppLifecycleState.resumed;
//
//    isInactive = state == AppLifecycleState.inactive;
//    isPause = state == AppLifecycleState.paused;
//
//  }

}

///widget生成器
///并且装配原flutter Widget的功能

mixin WidgetGenerator on BaseState implements _RouteGenerator, _NavigateActor {

  ///为state生成 页面widget
  /// * 仅用于页面跳转生成widget
  /// * 用于生成页面内的widget 应使用[generateWidget]，否则可能会引起一些重建bug
  /// * 如通知、和悬浮窗依然使用此方法(其本质是页面)
  Widget transformToPageWidget({Key? key}) {
    return _CommonWidget(
      key: key,stateBuilder: () => this,
    );
  }

  ///为state 生成 widget
  /// * [StateBuilder] 用于回调生成一个新的state
  /// * 此方法生成的widget 为通用型widget
  /// * 相较于老版，用于解决 widget/state重建时出现的bug
  Widget generateWidget(StateBuilder stateBuilder) {
    return _CommonWidget(
      stateBuilder: stateBuilder,
    );
  }

  /// [routeName]  => 你的页面类名
  @override
  PageRoute<T> buildRoute<T>(Widget page, String routeName,
      {PageAnimation? animation = PageAnimation.Non, Object? args}) {
    final r = RouteSettings(name: routeName, arguments: args);

    switch (animation) {
      case PageAnimation.Fade:
        return pageBuilder!.wrapWithFadeAnim(page, r) as PageRoute<T>;
      case PageAnimation.Scale:
        return pageBuilder!.wrapWithScaleAnim(page, r) as PageRoute<T>;
      case PageAnimation.Slide:
        return pageBuilder!.wrapWithSlideAnim(page, r) as PageRoute<T>;
      default:
        return pageBuilder!.wrapWithNoAnim(page, r) as PageRoute<T>;
    }
  }

  ///@param animation : 页面过度动画
  ///@param animation : page transition's animation
  ///see details in [PageAnimationBuilder]

  @override
  Future push<T extends PageState>(T targetPage, {PageAnimation? animation}) {
    return Navigator.of(context).push(buildRoute(
        targetPage.transformToPageWidget(), targetPage.runtimeType.toString(),
        animation: animation));
  }

  @override
  Future pushReplacement<T extends Object, TO extends PageState>(TO targetPage,
      {PageAnimation? animation, T? result}) {
    return Navigator.of(context).pushReplacement(
        buildRoute(
            targetPage.transformToPageWidget(), targetPage.runtimeType.toString(),
            animation: animation),
        result: result);
  }

  @override
  Future pushAndRemoveUntil<T extends PageState>(T targetPage,
      {PageAnimation? animation, predicate}) {
    return Navigator.of(context).pushAndRemoveUntil(
        buildRoute(
            targetPage.transformToPageWidget(), targetPage.runtimeType.toString(),
            animation: animation),
        predicate ?? (route) => false);
  }

  @override
  void pop<T extends Object>({T? result}) {
    Navigator.of(context).pop(result);
  }

  @override
  void popUntil({predicate}) {
    Navigator.of(context).popUntil(predicate ?? (route) => false);
  }

  @override
  bool canPop() {
    return Navigator.of(context).canPop();
  }
}

///构建 route

abstract class _RouteGenerator {
  PageRoute<T> buildRoute<T>(Widget page, String routeName,
      {PageAnimation? animation, Object? args});
}

///路由操作
abstract class _NavigateActor {
  Future push<T extends PageState>(T targetPage, {PageAnimation? animation});

  Future pushAndRemoveUntil<T extends PageState>(T targetPage,
      {PageAnimation? animation, RoutePredicate? predicate});

  Future pushReplacement<T extends Object, TO extends PageState>(TO targetPage,
      {PageAnimation? animation, T? result});

  void pop<T extends Object>({
    T? result,
  });

  void popUntil({RoutePredicate? predicate});

  bool canPop();
}

class _CommonWidget extends StatefulWidget {

  final StateBuilder? stateBuilder;

  const _CommonWidget({Key? key, this.stateBuilder}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return stateBuilder!();
  }
}
