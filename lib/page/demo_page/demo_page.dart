/*
* Author : LiJiqqi
* Date : 2020/5/28
*/


import 'package:flutter/material.dart';
import 'package:flutter_bedrock/base_framework/widget_state/base_state.dart';
import 'package:flutter_bedrock/service_api/bedrock_repository_proxy.dart';

class DemoPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {

    return DemoPageState();
  }

}

class DemoPageState extends BaseState<DemoPage> {
  @override
  Widget build(BuildContext context) {

    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          getSizeBox(height: getWidthPx(100)),
          RaisedButton(
            child: Text("test api o",style: TextStyle(color: Colors.black),),
            onPressed: ()async{
              try{
                await BedrockRepositoryProxy.getInstance().getSectionOne().getTest();
              }catch(e){
                debugPrint('--------');
                debugPrint(e.toString());
              }
            },
          ),
        ],
      ),
    );
  }
}