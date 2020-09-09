/*
* Author : LiJiqqi
* Date : 2020/8/24
*/


import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bedrock/base_framework/config/net/bedrock_http.dart';
import 'package:flutter_bedrock/base_framework/utils/isolate/app_private_ioslate.dart';
import 'package:flutter_bedrock/base_framework/utils/isolate/factory/worker_isolate.dart';

import 'package:flutter_bedrock/base_framework/widget_state/page_state.dart';



class IsolatePageState extends PageState {

  String result = '查看log';

  int count = 1;
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
              child: Text('get work 注意日志'),),
              SizedBox(width: 1,height: 20,),
              RaisedButton(onPressed: ()async{
                debugPrint('请求 google');
                bedRock.get('https://www.google.com');

              },
                child: Text('测试无网 取消所有连接，需要先启动上面的按钮'),),
              SizedBox(width: 1,height: 20,),
              RaisedButton(onPressed: ()async{
                List.generate(100, (index){
                  WorkerMainProxy.getInstance()
                  ///参数一：方法名字，参数二：方法对应的命名参数，
                  ///务必确保参数名与WorkList中的一致
                      .invokeWorker(methodName: 'test',nameArgs: {'n':'第$index次唤起','m':'第二个参数'});

                });

                count++;

              },
                child: Text('测试worker'),),

            ],
          ),
        ));
  }



}




















