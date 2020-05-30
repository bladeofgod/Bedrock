/*
* Author : LiJiqqi
* Date : 2020/5/29
*/



import 'package:flutter/material.dart';
import 'package:flutter_bedrock/base_framework/ui/widget/progress_widget.dart';
import 'package:flutter_bedrock/base_framework/ui/widget/provider_widget.dart';
import 'package:flutter_bedrock/base_framework/widget_state/base_state.dart';
import 'package:flutter_bedrock/page/demo_page/exception/exception_view_model.dart';

class HandleExceptionPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {

    return HandleExceptionPageState();
  }

}

class HandleExceptionPageState extends BaseState<HandleExceptionPage> {
  @override
  Widget build(BuildContext context) {

    return switchStatusBar2Dark(
        child: ProviderWidget<ExceptionViewModel>(
      model: ExceptionViewModel(),
      onModelReady: (model){
      },
      builder: (ctx,model,child){
        if(model.unAuthorized){
          return Container(
            width: getWidthPx(750),
            height: getHeightPx(1334),
            child: Center(
              child: Text("need sign in"),
            ),
          );
        }

        if(model.busy){
          return Center(
            child: CircleProgressWidget(),
          );
        }

        return Container(
          width: getWidthPx(750),height: getHeightPx(1334),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                child: Text("click request api"),
                onPressed: (){
                  model.initData();
                },
              ),
            ],
          ),
        );

      },
    ));

  }
}






















