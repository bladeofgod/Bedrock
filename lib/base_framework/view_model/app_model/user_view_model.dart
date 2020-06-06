/*
* Author : LiJiqqi
* Date : 2020/3/10
*/


import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bedrock/page/mine/entity/user_entity.dart';




class UserViewModel extends ChangeNotifier{
  //此字段保存上一个登录的用户ID，之后根据此ID去取用户缓存
  //默认自动登录上一个用户
  static const String last_user_id = "lastUserId";




  UserEntity _userEntity;

  get user => _userEntity;

  String get getUserId => _userEntity.id.toString();
  String get getUserName => _userEntity.nickName;



  bool get hasUser => _userEntity != null;



  String get userId => _userEntity == null ? "": _userEntity.id;

//  是否显示 动态轮播图


  UserViewModel(){
    ///用户登陆后会在本地缓存用户实体，可以根据自己的实际需求改变
    var entity = SpUtil.getObject(last_user_id);
    if(entity != null){
      _userEntity = UserEntity.fromJson(entity);
    }else{
      _userEntity = null;
    }
  }

  updateUserModelInfo(){
    notifyListeners();
  }


  saveUser(UserEntity userEntity){
    if(userEntity == null){
      return ;
    }
    _userEntity = userEntity;
    notifyListeners();
    SpUtil.putObject(last_user_id, userEntity);

  }



  ///登出后，清除缓存，不再自动登录
  userLogout(){
    _userEntity = null;
    notifyListeners();
    SpUtil.remove(last_user_id);
  }

}














