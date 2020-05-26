import 'dart:async';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bedrock/page/exception/exception_page.dart';

void main(){
  runZoned((){
    ErrorWidget.builder = (FlutterErrorDetails details){
      Zone.current.handleUncaughtError(details.exception, details.stack);
      ///出现异常时会进入下方页面（flutter原有的红屏），
      return ExceptionPage(details.exception.toString(),details.stack.toString());
    };
  },onError: (Object object,StackTrace trace){
    ///你可以将下面日志上传到服务器，用于release后的错误处理
    debugPrint(object);
    debugPrint(trace.toString());
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ///设计图尺寸
    setDesignWHD(750, 1334,density: 1.0);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: DemoPage(),
    );
  }
}

class DemoPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DemoPageState();
  }

}

class DemoPageState extends State<DemoPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Center(),
    );
  }
}

