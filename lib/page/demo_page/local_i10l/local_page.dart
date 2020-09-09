


import 'package:flutter/material.dart';
import 'package:flutter_bedrock/base_framework/view_model/app_model/locale_model.dart';
import 'package:flutter_bedrock/base_framework/widget_state/base_state.dart';
import 'package:flutter_bedrock/base_framework/widget_state/page_state.dart';
import 'package:flutter_bedrock/generated/l10n.dart';
import 'package:provider/provider.dart';


class LocalPageState extends PageState{

  String introduce = '''
  使用介绍：\n
  国际化是基于插件Intl实现的，所以在使用之前你需要安装Intl，墙裂建议百度一下Intl的详细介绍。\n
  这里我简单介绍一下，在安装好Intl插件后，会在项目下生成I10n文件夹，内部应该有一个intl_en.arb，这个文件为语言资源文件
  （你还可以举一反三添加其他语种,需要同时在LocalModel修改），所有文本都要添加到这里，添加完成后ctrl+s保存，插件会根据资源文件内的文本生成代码，在
  generated文件夹下（一般情况下是不需要编辑这里面的文件的），之后通过S.of(context).你的文本 就可以访问了。\n
  这个插件的好处是，前期我们可以都写成一个语种，之后交给翻译，翻译完成后在覆盖重新生成即可
  ''';

  @override
  Widget build(BuildContext context) {
    return switchStatusBar2Dark(
        child:Consumer<LocaleModel>(
          builder: (ctx,localModel,child){
            return Container(
              color: Colors.white,
              width: getWidthPx(750),height: getHeightPx(1334),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(S.of(context).hello,style: TextStyle(color: Colors.black,fontSize: getSp(28)),),
                  getSizeBox(height: getWidthPx(40)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        onPressed: (){
                          localModel.switchLocale(1);
                        },
                        child: Text("切换中文"),
                      ),
                      getSizeBox(width: getWidthPx(40)),
                      RaisedButton(
                        onPressed: (){
                          localModel.switchLocale(2);
                        },
                        child: Text("切换英文"),
                      ),
                    ],
                  ),
                  getSizeBox(height: getWidthPx(40)),
                  Text(introduce,style: TextStyle(color: Colors.black),),
                ],
              ),
            );
          },
        ) );
  }
}


















