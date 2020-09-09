


import 'package:flutter/material.dart';
import 'package:flutter_bedrock/base_framework/ui/widget/provider_widget.dart';
import 'package:flutter_bedrock/base_framework/widget_state/base_state.dart';
import 'package:flutter_bedrock/base_framework/widget_state/page_state.dart';
import 'package:flutter_bedrock/page/demo_page/main/first/view_model/update_view_model.dart';


class UpdatePageState extends PageState {

  String text = '''
    更新功能展示\n
    IOS建议直接跳app store\n
    未使用flutter_downloader，可能会引起与fluwx插件的冲突，不过也不是无法解决的，这个可以自己百度
    
  ''';

  @override
  Widget build(BuildContext context) {

    return switchStatusBar2Dark(
        child: ProviderWidget<UpdateViewModel>(
          model: UpdateViewModel(),
          onModelReady: (model){
            //todo
          },
          builder: (ctx,updateVM,child){
            return Container(
              color: Colors.white,
              width: getWidthPx(750),height: getHeightPx(1334),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(text,),
                  getSizeBox(height: getWidthPx(50)),
                  RaisedButton(
                    child: Text('升级',style: TextStyle(color: Colors.black),),
                    onPressed: updateVM.getNewApk,
                  ),
                  getSizeBox(height: getWidthPx(50)),
                  Text('下载进度： ${updateVM.progress}/100',style: TextStyle(color: Colors.lightBlue),),
                  getSizeBox(height: getWidthPx(50)),
                  RaisedButton(
                    child: Text('取消',style: TextStyle(color: Colors.black),),
                    onPressed: updateVM.cancelTask,
                  ),
                ],
              ),
            );
          },
        ));
  }
}























