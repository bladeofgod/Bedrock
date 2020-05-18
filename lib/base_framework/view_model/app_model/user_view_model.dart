/*
* Author : LiJiqqi
* Date : 2020/3/10
*/


import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';



class UserViewModel extends ChangeNotifier{
  //此字段保存上一个登录的用户ID，之后根据此ID去取用户缓存
  //默认自动登录上一个用户
  static const String last_user_id = "lastUserId";




  UserEntity _userEntity;

  get user => _userEntity;

  String get getUserId => _userEntity.id.toString();
  String get getUserName => _userEntity.nickname;
  String get getUserLastName => _userEntity.lastname;
  String get getUserHead => hasUser ? _userEntity.image : "";
  String get getUserDetail => _userEntity.message;

  String get getUserIphone => _userEntity.phone;
  String get getUserEmail => _userEntity.emails;


  bool get getUserWxId => _userEntity.identityWx.length ==0 ? false : true;
  bool get getUserGgId => _userEntity.identityGg.length ==0 ? false : true;
  bool get getUserFbId => _userEntity.identityFb.length ==0 ? false : true;

  bool get hasUser => _userEntity != null;



  double get getUserProgress => double.parse(_userEntity.percent.substring(0,_userEntity.percent.length-1))/100.0;

  String get userId => _userEntity == null ? "": _userEntity.id;

//  是否显示 动态轮播图


  UserViewModel(){
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
    debugPrint("写入用户----------\n ${userEntity.toJson().toString()}");
    _userEntity = userEntity;
    ///登录界面登录成功后，首页会build，所以并不需要notifyListeners() ,理论上
    SpUtil.putObject(last_user_id, userEntity);

  }


  updataUser() async{
    UserEntity userEntity= await TripaLinkRepository.getUserInfoPercent(user_id:getUserId);
    saveUser(userEntity);
    notifyListeners();
  }

  ///登出后，清除缓存，不再自动登录
  userLogout(){
    _userEntity = null;
    notifyListeners();
    SpUtil.remove(last_user_id);
  }

}














