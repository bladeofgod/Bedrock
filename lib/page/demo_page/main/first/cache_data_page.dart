/*
* Author : LiJiqqi
* Date : 2020/6/15
*/


import 'package:flutter/material.dart';
import 'package:flutter_bedrock/base_framework/ui/widget/provider_widget.dart';
import 'package:flutter_bedrock/base_framework/widget_state/base_state.dart';
import 'package:flutter_bedrock/page/demo_page/main/first/view_model/cache_page_vm.dart';

class CacheDataPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return CacheDataPageState();
  }

}

class CacheDataPageState extends BaseState<CacheDataPage> {
  @override
  Widget build(BuildContext context) {

    return switchStatusBar2Dark(
      child: ProviderWidget<CachePageVM>(
        model: CachePageVM(),
        onModelReady: (model){
          model.initData();
        },
        builder: (ctx,model,child){
          return switchStatusBar2Dark(child: null)
        },
      )
    );
  }
}




















