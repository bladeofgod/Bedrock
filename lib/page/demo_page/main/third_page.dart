

import 'package:flutter/material.dart';
import 'package:flutter_bedrock/base_framework/config/router_manager.dart';
import 'package:flutter_bedrock/base_framework/ui/widget/progress_widget.dart';
import 'package:flutter_bedrock/base_framework/ui/widget/provider_widget.dart';
import 'package:flutter_bedrock/base_framework/utils/platform_utils.dart';
import 'package:flutter_bedrock/base_framework/view_model/app_model/app_cache_model.dart';
import 'package:flutter_bedrock/base_framework/view_model/app_model/user_view_model.dart';
import 'package:flutter_bedrock/base_framework/widget_state/base_state.dart';
import 'package:flutter_bedrock/base_framework/widget_state/page_state.dart';
import 'package:flutter_bedrock/page/demo_page/main/login/login_page.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';


class ThirdPagePageState extends PageState with AutomaticKeepAliveClientMixin {

  UserViewModel userViewModel;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return switchStatusBar2Dark(child:
    Consumer2<UserViewModel,AppCacheModel>(
      builder: (ctx,userModel,cacheModel,child){
        userViewModel = userModel;
        return Container(
          color: Colors.white,
          width: getWidthPx(750),
          height: getHeightPx(1334),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              getSizeBox(height: getWidthPx(80)),
              //
              GestureDetector(
                onTap: (){
                  if(!userModel.hasUser){
                    push(LoginPageState());
                  }
                },
                child: buildUserInfo(),
              ),
              getSizeBox(height: getWidthPx(100)),

              Container(
                width: getWidthPx(750),
                height: getHeightPx(30),
                color: Colors.grey[400],
              ),

              getSizeBox(height: getWidthPx(60)),

              buildWidget("package info ","${cacheModel.packageInfo.appName} ${cacheModel.packageInfo.packageName}"),
              buildWidget("app version", cacheModel.appVersion),
              buildWidget("build number", cacheModel.buildNum??"未获取成功"),

              getSizeBox(height: getWidthPx(60)),
              GestureDetector(
                onTap: ()async{
                  showToastWidget(CircleProgressWidget(),duration: Duration(seconds: 2),
                    onDismiss: (){
                      showToast("退出成功");
                      userViewModel.userLogout();

                    });

                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: getWidthPx(10)),
                  color: Colors.grey[400],
                  alignment: Alignment.center,
                  width: getWidthPx(750),
                  child: Text("退出",style: TextStyle(color: Colors.black,fontSize: getSp(32),
                    fontWeight: FontWeight.bold),),

                ),
              ),

            ],
          ),
        );
      },
    ));
  }

  Widget buildWidget(String title, String info){
    return Container(
      margin: EdgeInsets.only(bottom: getWidthPx(20)),
      padding: EdgeInsets.symmetric(horizontal: getWidthPx(40)),
      color: Color.fromRGBO(235, 235, 235, 1),
      width: getWidthPx(750),height: getWidthPx(50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(title,style: TextStyle(color: Colors.grey,fontSize: getSp(30)),),
          Text(info,style: TextStyle(color: Colors.black,fontSize: getSp(26)),)
        ],
      ),
    );
  }

  Widget buildUserInfo(){
    return Row(
      children: <Widget>[
        getSizeBox(width: getWidthPx(40)),
        ///avatar
        CircleAvatar(
          backgroundColor:userViewModel.hasUser ?  Colors.amberAccent : Colors.grey[400],
          child: Icon(Icons.adb,color:userViewModel.hasUser ?  Colors.pink :Colors.grey ,
            size: getWidthPx(80),),
          radius: getWidthPx(60),
        ),
        getSizeBox(width: getWidthPx(80)),
        ///name
        Text("${userViewModel.hasUser?userViewModel.getUserName : "未登录"}",
          style: TextStyle(color: Colors.black,fontSize: getSp(40),),),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;

}