



import 'package:flutter/material.dart';
import 'package:flutter_bedrock/base_framework/ui/widget/progress_widget.dart';
import 'package:flutter_bedrock/base_framework/ui/widget/provider_widget.dart';
import 'package:flutter_bedrock/base_framework/view_model/app_model/user_view_model.dart';
import 'package:flutter_bedrock/base_framework/widget_state/base_state.dart';
import 'package:flutter_bedrock/base_framework/widget_state/page_state.dart';
import 'package:flutter_bedrock/page/demo_page/main/login/login_view_model.dart';
import 'package:provider/provider.dart';


class LoginPageState extends PageState {


  LoginViewModel loginViewModel;

  @override
  Widget build(BuildContext context) {
    return switchStatusBar2Dark(
        child: Consumer<UserViewModel>(
          builder: (ctx,userModel,child){

            return ProviderWidget<LoginViewModel>(
              model: LoginViewModel(userModel),
              onModelReady: (model){

              },
              builder: (ctx,loginModel,child){


                if(userModel.hasUser){
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                    pop();
                  });
                }
                loginViewModel = loginModel;

                return Container(
                  color: Colors.white,
                  width: getWidthPx(750),height: getHeightPx(1334),
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          inputName(),
                          getSizeBox(height: getWidthPx(20)),
                          inputPassword(),
                          getSizeBox(height: getWidthPx(40)),
                          confirmBtn(),
                        ],
                      ),
                      Visibility(
                        visible: loginModel.busy,
                        child: FullPageCircleProgressWidget(),
                      )
                    ],
                  ),
                );

              },
            );
          },
        ));
  }

  Widget confirmBtn(){
    return GestureDetector(
      onTap: ()async{
        await loginViewModel.login();
      },
      child: Container(
        color: Colors.blue,
        width: getWidthPx(400),
        height: getWidthPx(80),
        alignment: Alignment.center,
        child: Text("登录",style: TextStyle(color: Colors.white,fontSize: getSp(30)),),
      ),
    );

  }

  Widget inputName(){
    return Container(
      width: getWidthPx(450),
      height: getWidthPx(80),
      child: TextField(
        onChanged: (text){
          loginViewModel.name = text;
        },
        controller: loginViewModel.nameController,
        decoration: InputDecoration(
          hintText: "enter name"
        ),
      ),
    );
  }

  Widget inputPassword(){
    return Container(
      width: getWidthPx(450),
      height: getWidthPx(80),
      child: TextField(
        onChanged: (text){
          loginViewModel.pass = text;
        },
        controller: loginViewModel.passController,
        decoration: InputDecoration(
            hintText: "enter password"
        ),
      ),
    );
  }






}


















