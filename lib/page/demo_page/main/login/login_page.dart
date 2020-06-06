



import 'package:flutter/material.dart';
import 'package:flutter_bedrock/base_framework/ui/widget/provider_widget.dart';
import 'package:flutter_bedrock/base_framework/view_model/app_model/user_view_model.dart';
import 'package:flutter_bedrock/base_framework/widget_state/base_state.dart';
import 'package:flutter_bedrock/page/demo_page/main/login/login_view_model.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }

}

class LoginPageState extends BaseState<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return switchStatusBar2Dark(
        child: Consumer<UserViewModel>(
          builder: (ctx,userModel,childw){
            return ProviderWidget<LoginViewModel>(
              model: LoginViewModel(),
              onModelReady: (model){

              },
              builder: (ctx,loginModel,child){

                return Container(
                  width: getWidthPx(750),height: getHeightPx(1334),
                  child: ,
                );

              },
            );
          },
        ));
  }
}


















