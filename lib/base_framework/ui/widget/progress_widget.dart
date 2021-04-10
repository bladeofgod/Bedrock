/*
* Author : LiJiqqi
* Date : 2020/4/1
*/



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bedrock/base_framework/widget_state/base_stateless_widget.dart';
import 'package:flutter_bedrock/base_framework/widget_state/widget_state.dart';

class CircleProgressWidget extends BaseStatelessWidget{
  @override
  Widget build(BuildContext context) {

    return Container(

      width: getWidthPx(150),
      height: getWidthPx(150),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(getHeightPx(15)),
        color: Colors.white,
      ),
      child: Container(
        width: getWidthPx(60),
        height: getWidthPx(60),
        child: CircularProgressIndicator(),
      ),
    );
  }

}

///显示progress 方式 1
///这种方式，需要在布局中添加FullPageCircleProgressWidget
class FullPageCircleProgressWidget extends BaseStatelessWidget{
  @override
  Widget build(BuildContext context) {

    return Container(
      width: MediaQuery.of(context).size.width,
//      height: getWidthPx(1334),
      height: MediaQuery.of(context).size.height,
      alignment: Alignment.center,
      color: Color.fromRGBO(34, 34, 34, 0.3),
      child: CircleProgressWidget(),
    );
  }

}

///显示progress 方式 2
///这种方式，不需要在布局中添加

//typedef LoadingCreate = void Function(DialogLoadingController controller);

enum LoadingPopType{
  byUser,//用户结束
  byTimeOut,//超时结束
  byDismissMethod,//通过[dismissProgressDialog] 结束
}

class LoadingPopEntity{
  final LoadingPopType type;

  LoadingPopEntity(this.type);
}

/// 加载弹窗 [showProgressDialog] (页面)的 [RouteSettings].name
/// * 某些情况，可能需要当前route的名字，故这里标记上。
final String loadingLayerRouteName = 'LoadingProgressState';

class LoadingProgressState extends WidgetState {

  final Widget? progress;
  final Color? bgColor;
  final int? loadingTimeOut;
  //final LoadingCreate loadingCreate;
  DialogLoadingController? controller;

  LoadingProgressState({this.progress, this.bgColor, this.controller,this.loadingTimeOut});


  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: loadingTimeOut ?? 15)).then((value) {
      if(mounted) {
        Navigator.of(context).pop(LoadingPopEntity(LoadingPopType.byTimeOut));
      }
    });

    controller!.addListener(() {
      if(controller!.isShow){
        //todo
      }else{
        WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
          Navigator.of(context).pop(LoadingPopEntity(LoadingPopType.byDismissMethod));
        });
      }
    });
  }

  @override
  void dispose() {
    controller!.isShow = false;
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return WillPopScope(child: Container(
      color: bgColor??Color.fromRGBO(34, 34, 34, 0.3),
      width: size.width,height: size.height,
      alignment: Alignment.center,
      child:progress?? CircularProgressIndicator(),
    ), onWillPop: ()async{
      Navigator.of(context).pop(LoadingPopEntity(LoadingPopType.byUser));
      return false;
    });
  }
}

class DialogLoadingController extends ChangeNotifier{
  Function? _afterPopTask;

  bool isShow = true;

  ///隐藏loading
  dismissDialog() {
    if (isShow) {
      isShow = false;
      notifyListeners();
    }
  }

  ///[task] 将在loading消失后执行
  void holdAfterPopTask({Function? task}) {
    _afterPopTask = task;
  }

  void invokeAfterPopTask() {
    if (_afterPopTask != null) _afterPopTask!();
  }
}


