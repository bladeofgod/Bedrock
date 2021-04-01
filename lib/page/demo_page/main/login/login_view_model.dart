


import 'package:flutter/cupertino.dart';
import 'package:flutter_bedrock/base_framework/view_model/app_model/user_view_model.dart';
import 'package:flutter_bedrock/base_framework/view_model/single_view_state_model.dart';
import 'package:flutter_bedrock/service_api/bedrock_repository_proxy.dart';
import 'package:oktoast/oktoast.dart';

class LoginViewModel extends SingleViewStateModel{

  TextEditingController? nameController;
  TextEditingController? passController;

  final UserViewModel userViewModel;


  LoginViewModel(this.userViewModel){
    nameController = TextEditingController();
    passController = TextEditingController();
  }

  String? name;
  String? pass;


  login(){
    ///可以用这个，也可以自己定义
    setBusy(true);
    BedrockRepositoryProxy.getInstance()!.getSectionOne().login(name, pass)
    .then((user){
      if(user != null){
        showToast("登陆成功");
        userViewModel.saveUser(user);
      }
    })
        .whenComplete((){
      setBusy(false);
    });

  }

  @override
  Future? loadData() {
    ///在这里写入登录接口也可以，灵活随意
    return null;

  }

  @override
  onCompleted(data) {

  }

}













