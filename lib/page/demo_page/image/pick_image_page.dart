


import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bedrock/base_framework/config/net/bedrock_http.dart';
import 'package:flutter_bedrock/base_framework/config/router_manager.dart';
import 'package:flutter_bedrock/base_framework/ui/widget/image/image_editor.dart';
import 'package:flutter_bedrock/base_framework/utils/image_helper.dart';
import 'package:flutter_bedrock/base_framework/widget_state/base_state.dart';
import 'package:flutter_bedrock/base_framework/widget_state/page_state.dart';
import 'package:oktoast/oktoast.dart';
import 'package:permission_handler/permission_handler.dart';



class PickImagePageState extends PageState {

  String avatarPath = "";

  @override
  Widget build(BuildContext context) {
    return switchStatusBar2Dark(child: Container(
      color: Colors.white,
      width: getWidthPx(750),height: getHeightPx(1334),
      padding: EdgeInsets.symmetric(horizontal: getWidthPx(40)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("${avatarPath.isEmpty?"请选择图片":"图片路径：$avatarPath"}"),
          getSizeBox(height: getWidthPx(60)),
          ///avatar
          ClipOval(
            child: Container(
              width: getWidthPx(120),height: getWidthPx(120),
              child: avatarPath.isEmpty ? Icon(Icons.camera,size: getWidthPx(120),)
                  : Image.file(File(avatarPath),width: getWidthPx(110),height: getWidthPx(110),),
            ),
          ),

          getSizeBox(height: getWidthPx(40)),
          RaisedButton(
            child: Text("选择/拍照头像",style: TextStyle(color: Colors.black,fontSize: getSp(30)),),
            onPressed: (){
              checkPermission();

            },
          ),

          getSizeBox(height: getWidthPx(40)),
          Text('图片存储在了沙盒里，理论上兼容华为',textAlign: TextAlign.center,),

          getSizeBox(height: getWidthPx(40)),
          Text("因为没有测试服务器，所以上传图片的代码我注释掉了，可以查看该页面的源码，在最低端",
            style: TextStyle(color: Colors.black),),


        ],
      ),
    ));
  }



  checkPermission()async{
//    Map<Permission, PermissionStatus> permissions = await PermissionStatus ().requestPermissions(values);
    if (await Permission.camera.request().isGranted) {
      // Either the permission was already granted before or the user just granted it.
    }


    Map<Permission, PermissionStatus> permissions = await [
      Permission.camera,
      Permission.photos,
    ].request();
    print(permissions[Permission.camera]);

    List<bool> results = permissions.values.toList().map((status){
      return status == PermissionStatus.granted;
    }).toList();
    if(results == null || results.contains(false)){
      showToast("permission denied");
    }else{
      showImagePicker();
    }

  }

  ///DEMO 代码写的随意了一些

  ///保存路径到本地
  String avatarPathKey = "tripalink_avatar_path";
  showImagePicker(){
    ImageHelper.pickImage().then((assetList){
      if(assetList == null || assetList.length>1){
        showToast("only one image");
      }else{
        assetList[0].getByteData().then((data){
          push(ImageEditorState(name: "bedrock_user_avatar",memoryImage:data.buffer.asUint8List()))
              .then((path){
            SpUtil.putString(avatarPathKey, path);
            avatarPath = path;
            setState(() {

            });
            if(path.toString().length>0){
              ///将图片上传到服务器（暂时没有测试服务器，只能是注释掉了）
              //uploadAvatarServer();
              //model.setLoading(true);

            }
          });

        });

      }

    });

  }



  ///没有服务器，这里只是演示一下 怎么上传图片到服务器
///PS：上传的代码 是不应该出现在这个位置的

//  uploadAvatarServer(){
//    uploadHeadImg(path).then((res){
//      if(res!=null){
//        if(res.code==200){
//          SpUtil.putString(avatarPathKey, path);
//          showToast(res.message);
//          userViewModel.updataUser();
//        }
//      }
//    }).whenComplete((){
//      mineViewModel.setLoading(false);
//    });
//  }
//
//  Future uploadHeadImg({String resultPath,Function handleException})async{
//    FormData formData = new FormData.fromMap({
//      "uploadfile": await MultipartFile.fromFile(resultPath, filename: resultPath),
//    });
//    var response = await bedRock.post("$Index_php?r=user-center/upload-head-image",data: formData);
//    if(response == null) return null;
//    return response.data;
//  }




}













