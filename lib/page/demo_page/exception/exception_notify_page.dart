/*
* Author : LiJiqqi
* Date : 2021/1/8
*/


import 'package:flutter_bedrock/base_framework/config/net/base_http.dart';
import 'package:flutter_bedrock/base_framework/ui/widget/provider_widget.dart';
import 'package:flutter_bedrock/base_framework/view_model/single_view_state_model.dart';
import 'package:flutter_bedrock/base_framework/view_model/view_state_model.dart';
import 'package:flutter_bedrock/base_framework/widget_state/page_state.dart';
import 'package:flutter/material.dart';


class ExceptionNotifyPage extends PageState{
  @override
  Widget build(BuildContext context) {
    return switchStatusBar2Dark(child:
      ProviderWidget<NotifyPageVM>(
        model: NotifyPageVM(),
        onModelReady: (model){
          //todo
        },
        builder: (ctx,model,child){
          return Container(
            color: Colors.white,
            width: getWidthPx(750),height: getHeightPx(1334),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('没有现成的接口，请看一下这个页面的代码注释以了解使用方法吧。',
                  style: TextStyle(color: Colors.black,fontSize: getSp(32)),),
              ],
            ),
          );
        },
      ));
  }

}

/// test page

/// 此为[ExceptionNotifyPage] 页面的vm

class NotifyPageVM extends SingleViewStateModel
  with ExceptionBinding{


  /// 在vm内单独使用接口并需要监听异常时(非[loadData]内)，需要混入[ExceptionBinding]
  /// 调用[bindToExceptionHandler(listener)],随后实现[notifyException]
  NotifyPageVM(){
    /// 注册监听器
    bindToExceptionHandler(this);
  }


  ///我们通过model.initData()进行页面主数据的请求。
  ///父类会对此处的业务异常进行捕捉
  @override
  Future loadData() {

    ///调用页面 数据接口
    return null;
  }

  @override
  onCompleted(data) {

  }

  ///此 ViewModel内的所有 api业务异常都会通知到下面这个方法
  @override
  void notifyException({Exception exception, BaseResponseData rawData}) {
    // 根据异常实现对应逻辑
  }

}































