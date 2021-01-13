/*
* Author : LiJiqqi
* Date : 2020/9/8
*/



import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bedrock/base_framework/config/router_manager.dart';
import 'package:flutter_bedrock/base_framework/ui/widget/float_container_widget.dart';
import 'package:flutter_bedrock/base_framework/utils/image_helper.dart';
import 'package:flutter_bedrock/base_framework/view_model/view_state.dart';
import 'package:flutter_bedrock/base_framework/widget_state/base_state.dart';
import 'package:flutter_bedrock/base_framework/widget_state/widget_state.dart';


/// * 如果是页面，继承 [PageState]
/// * 如果是view，继承 [WidgetState]
/// 确保你的页面名字在项目中唯一，
/// 否则一些页面跳转的结果可能非你预期
/// ensure your page's name is unique in project,
/// will cause unexpected in navigator action if not.
///

/// 此处扩展功能应该只与page相关

abstract class PageState extends BaseState with WidgetGenerator,RouteAware,_RouteHandler{




  ///所有页面请务必使用此方法作为根布局
  ///[isSetDark]切换状态栏 模式：light or dark
  ///[child] 你的页面
  ///[edgeInsets] 一般用于屏幕虚拟的适配
  ///[needSlideOut]是否支持右滑返回、如果整个项目不需要，可以配置默认值为false
  Widget switchStatusBar2Dark({bool isSetDark = true,@required Widget child,
    EdgeInsets edgeInsets,bool needSlideOut = false}){
    if(! needSlideOut){
      ///不含侧滑退出
      return _getNormalPage(isSetDark: isSetDark,child: child,edgeInsets: edgeInsets);

    }else{
      ///侧滑退出
      return _getPageWithSlideOut(isSetDark: isSetDark,child: child,edgeInsets: edgeInsets,);
    }

  }

  Widget _getNormalPage({bool isSetDark = true,@required Widget child,
    EdgeInsets edgeInsets}){
    return AnnotatedRegion(
        value: isSetDark ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
        child: Material(
          color: Colors.white,
          child: Padding(
            padding: edgeInsets??EdgeInsets.only(bottom: ScreenUtil.getInstance().bottomBarHeight),
            child: child,
          ),
        )
    );
  }

  ///页面左边距
  double marginLeft = 0.0;
  ///拖动位置
  double dragPosition = 0.0;
  ///触发页面滑动动画
  bool slideOutActive = false;

  Widget _getPageWithSlideOut({bool isSetDark = true,@required Widget child,
    EdgeInsets edgeInsets}){
    return AnnotatedRegion(
        value: isSetDark ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
        child: Material(
          color: Colors.transparent,
          child: Padding(
            padding: edgeInsets??EdgeInsets.only(bottom: ScreenUtil.getInstance().bottomBarHeight),
            child: GestureDetector(
              onHorizontalDragStart: (dragStart){
                slideOutActive = dragStart.globalPosition.dx < (getScreenWidth() / 10);

              },
              onHorizontalDragUpdate: (dragDetails){
                if(!slideOutActive) return;
                marginLeft = dragDetails.globalPosition.dx;
                dragPosition = marginLeft;
                //if(marLeft > 250) return;
                if(marginLeft < getWidthPx(50)) marginLeft = 0;
                setState(() {

                });
              },
              onHorizontalDragEnd: (dragEnd){
                if(dragPosition > getScreenWidth()/5){
                  pop();
                }else{
                  marginLeft = 0.0;
                  setState(() {

                  });
                }
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: EdgeInsets.only(left: marginLeft),
                child: SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: child,
                ),
              ),

            ),
          ),
        )
    );

  }

  /// 一般页面的通用APP BAR 具体根据项目需求调整
  Widget commonAppBar({Widget leftWidget,String title,List<Widget> rightWidget ,
    Color bgColor = Colors.white,@required double leftPadding,@required double rightPadding}){
    return Container(
      width: getWidthPx(750),
      height: getHeightPx(115),
      color: bgColor??Color.fromRGBO(241, 241, 241, 1),
      padding: EdgeInsets.only(bottom: getHeightPx(10),left: leftPadding,right: rightPadding),
      alignment: Alignment.bottomCenter,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: <Widget>[
          Positioned(
            left: 0,
            child: leftWidget ?? Container(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Visibility(
              visible:  title != null,
              child: Text(
                "$title",
                style: TextStyle(fontSize: getSp(36),color: Colors.black,
                    decoration: TextDecoration.none),
              ),
            ),
          ),
          if(rightWidget != null)
            ...rightWidget,
        ],
      ),
    );
  }

  ///通用APP bar 统一后退键
  Widget buildAppBarLeft(){
    return GestureDetector(
      onTap: (){
        if(canPop()){
          pop();
        }else{
          ///增加需要的提示信息
        }

      },
      child: Container(
        color: Colors.white,
        width: getWidthPx(150),
        height: getHeightPx(90),
        alignment: Alignment.bottomLeft,
        child: Image.asset(ImageHelper.wrapAssetsIcon("icon_back_black"),width: getWidthPx(17),height: getHeightPx(32),),
      ),
    );
  }

  ///弹出自定义widget（效果类似dialog）
  ///你可以调整你的widget来达到预期的表现效果
  ///也可以通过PageRouteBuilder的参数进行调整
  void floatWidget(Widget child,{
    ///弹出层的退出由此参数控制
    ///默认值Navigator.pop(ctx)，或自定义
    FloatWidgetDismiss floatWidgetDismiss,
    bool barrierDismissible = false,
    ///浮层背景色
    Color bgColor = const Color.fromRGBO(34, 34, 34, 0.3),
    ///浮层对齐方式
    Alignment alignment = Alignment.center,
    ///回调
    Function afterPop,Function onComplete,
    ///页面进入/退出时间
    Duration transitionDuration = const Duration(milliseconds: 0),
    ///新版本 此参数已作废
    @deprecated
    Duration reverseTransitionDuration = const Duration(milliseconds: 0),
  }){
    Navigator.of(context).push(
        PageRouteBuilder(
          settings: RouteSettings(name: floatLayerRouteName),
          transitionDuration: transitionDuration,
        ///新版本无此参数
        //reverseTransitionDuration: reverseTransitionDuration,
        opaque: false,
        pageBuilder:(ctx,animation,secondAnimation){
          return FloatContainerWidget(child,
              floatWidgetDismiss: floatWidgetDismiss??(ctx)=>Navigator.pop(ctx),
              barrierDismissible:barrierDismissible ,bgColor: bgColor,alignment: alignment).generateWidget();
        }))
        .then((value) => afterPop??(){})
        .whenComplete(() => onComplete??(){});
  }

  //////////////////////////////////////////////////////
  ///页面出/入 监测
  //////////////////////////////////////////////////////
  @override
  void didChangeDependencies() {
    routeObserver.subscribe(this, ModalRoute.of(context));
    super.didChangeDependencies();
  }
  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPush() {
    handleDidPush();
    super.didPush();
  }

  @override
  void didPop() {
    handleDidPop();
    super.didPop();
  }

  @override
  void didPopNext() {
    handleDidPopNext();
    super.didPopNext();
  }

  @override
  void didPushNext() {
    handleDidPushNext();
    super.didPushNext();
  }

}

/// route aware's util
/// you can do something in this
/// e.g. create recordList at [_RouteHandler] and record something

mixin _RouteHandler on BaseState implements HandleRouteNavigate{
  @override
  void handleDidPop() {
    debugPrint("已经pop的页面 ${this.runtimeType}");
  }
  @override
  void handleDidPush() {
    debugPrint("push后,显示的页面 ${this.runtimeType}");
  }

  @override
  void handleDidPopNext() {
    debugPrint("pop后，将要显示的页面 ${this.runtimeType}");
  }
  @override
  void handleDidPushNext() {
    debugPrint("push后，被遮挡的页面 ${this.runtimeType}");
  }
}

abstract class HandleRouteNavigate{
  void handleDidPush();
  void handleDidPop();
  void handleDidPopNext();
  void handleDidPushNext();

}









