/*
* Author : LiJiqqi
* Date : 2020/9/10
*/




import 'package:flutter/material.dart';
import 'package:flutter_bedrock/base_framework/widget_state/page_state.dart';
import 'package:flutter_bedrock/page/demo_page/start/pages/page_1.dart';
import 'package:flutter_bedrock/page/demo_page/start/with_value_page.dart';

class StartPage extends PageState{

  String info ='添加页面时，重写build方法，总会引入framework\n官方不推荐引入这个(虽然不会出错)\n'
      '建议在（AS）File-setting-editor-live templates设置快捷键引入 Material或者cupertinol';


  String backValue = '等待WithValuePage的返回值';
  @override
  Widget build(BuildContext context) {
    return switchStatusBar2Dark(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            getSizeBox(height: getHeightPx(100)),
            Text('这里是基本的页面创建和路由操作，请参考代码来学习',style: TextStyle(color: Colors.black),),
            getSizeBox(height: getHeightPx(20)),
            Text(info,style: TextStyle(color: Colors.black),),
            getSizeBox(height: getHeightPx(40)),
            RaisedButton(
              child: Text('go page 1 with pushAndRemoveUntil',style: TextStyle(color: Colors.black),),
              onPressed: (){
                push(Page1());
              },
            ),
            Container(
              width: getWidthPx(750),height: getHeightPx(10),
              color: Colors.green,
            ),
            getSizeBox(height: getHeightPx(40)),
            Text(backValue,style: TextStyle(color: Colors.black,fontSize: getSp(24)),),
            RaisedButton(
              child: Text('push with value',style: TextStyle(color: Colors.black),),
              onPressed: (){
                push(WithValuePage('start page送了一个西瓜'))
                  .then((value){
                    setState(() {
                      backValue = value??'啥都没给';
                    });
                });
              },
            ),
          ],
        ),
      )
    );
  }

}


















