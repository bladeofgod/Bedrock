


import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bedrock/base_framework/ui/behavior/over_scroll_behavior.dart';
import 'package:flutter_bedrock/base_framework/ui/widget/progress_widget.dart';
import 'package:flutter_bedrock/base_framework/utils/image_helper.dart';
import 'package:flutter_bedrock/base_framework/widget_state/page_state.dart';
import 'package:flutter_bedrock/base_framework/widget_state/view_state.dart';
import 'package:oktoast/oktoast.dart';

/// * 请勿直接继承此类
/// * 如果是页面，继承 [PageState]
/// * 如果是view，继承 [ViewState]

abstract class BaseState<T extends StatefulWidget> extends State<T>  {


  ///去掉 scroll view的 水印  e.g : listView scrollView
  ///当滑动到顶部或者底部时，继续拖动出现的蓝色水印
  Widget getNoInkWellListView({@required Widget scrollView}){
    return ScrollConfiguration(
      behavior: OverScrollBehavior(),
      child: scrollView,
    );
  }


  ///占位widget
  Widget getSizeBox({double width = 1,double height = 1}){
    return SizedBox(
      width: width,
      height: height,
    );
  }

  ///在页面上方显示一个 loading widget
  ///共有两种方法，showProgressDialog是其中一种
  ///具体参见 : progress_widget.dart
  DialogLoadingController _dialogLoadingController;
  showProgressDialog({Widget progress,
    Color bgColor,}){
    if(_dialogLoadingController == null){
      _dialogLoadingController = DialogLoadingController();
      Navigator.of(context).push(PageRouteBuilder(
          opaque: false,
          pageBuilder: (ctx,animation,secondAnimation){
            return LoadingProgress(controller: _dialogLoadingController
              ,progress: progress,bgColor: bgColor,);
          }
      ));
    }
  }

  dismissProgressDialog(){
    _dialogLoadingController?.dismissDialog();
    _dialogLoadingController = null;
  }

  /*
  * size adapter with tool ScreenUtil
  *
  * */

  ///得到适配后的高度
  double getHeightPx(double height) => ScreenUtil.getInstance().getHeightPx
    (height);
  ///得到适配后的宽度
  double getWidthPx(double width) => ScreenUtil.getInstance().getWidthPx(width);

  ///屏幕宽度
  double getScreenWidth()=>ScreenUtil.getInstance().screenWidth;
  ///屏幕高度
  double getScreenHeight()=>ScreenUtil.getInstance().screenHeight;


  //目前仅对于手机： 因为手机大多数情况下是长度变化较大，
  // 所以以高度来算出半径，保证异形屏的弧度不会缩小
  //有其他需求，还需要重改
  /// 得到适配后的圆角半径
  double getRadiusFromHeight(double radius) => ScreenUtil.getInstance()
      .getHeightPx(radius) ;
  ///得到适配后的字号
  double getSp(double fontSize) => ScreenUtil.getInstance().getSp(fontSize);




/*
  * app 生命周期，建议在需要的页面自己监听
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

mixin WidgetGenerator on BaseState{
  Widget generateWidget({Key key}){
    return _CommonWidget(state: this,key: key,);
  }
}

class _CommonWidget extends StatefulWidget{
  final State state;

  const _CommonWidget({Key key, this.state}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return state;
  }

}