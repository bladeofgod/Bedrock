


import 'package:flutter/cupertino.dart';
import 'package:flutter_bedrock/base_framework/view_model/view_state_single_model.dart';

class LoginViewModel extends ViewStateSingleModel{

  TextEditingController nameController;
  TextEditingController passController;


  LoginViewModel(){
    nameController = TextEditingController();
    passController = TextEditingController();
  }

  String name;
  String pass;


  login(){}

  @override
  Future loadData() {
    return null;

  }

  @override
  onCompleted(data) {

  }

}













