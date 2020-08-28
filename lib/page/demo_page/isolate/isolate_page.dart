/*
* Author : LiJiqqi
* Date : 2020/8/24
*/


import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bedrock/base_framework/config/net/bedrock_http.dart';
import 'package:flutter_bedrock/base_framework/utils/isolate/app_private_ioslate.dart';
import 'package:flutter_bedrock/base_framework/utils/isolate/isolate_pool_proxy.dart';
import 'package:flutter_bedrock/base_framework/widget_state/base_state.dart';

class IsolatePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return IsolatePageState();
  }

}

class IsolatePageState extends BaseState<IsolatePage> {

  String result = '查看log';

  @override
  Widget build(BuildContext context) {
    return switchStatusBar2Dark(
        child: Container(
          width: getWidthPx(750),height: getHeightPx(1334),
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(result),
              RaisedButton(onPressed: ()async{
                ///结果 在 log里
                AppPrivateIsolate.getInstance().initNetObserver();

              },
              child: Text('get work'),),
              SizedBox(width: 1,height: 20,),
              RaisedButton(onPressed: ()async{
                debugPrint('请求 google');
                bedRock.get('https://www.google.com');

              },
                child: Text('测试无网 取消所有连接'),),

            ],
          ),
        ));
  }

  Future<String> getWork()async{
    debugPrint('isolate start');
    sleep(Duration(seconds: 5));
    debugPrint('isolate done');
    return '结果是123';
  }


}




















