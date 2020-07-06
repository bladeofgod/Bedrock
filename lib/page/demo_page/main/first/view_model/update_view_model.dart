


import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bedrock/base_framework/config/net/bedrock_http.dart';
import 'package:flutter_bedrock/base_framework/config/storage_manager.dart';
import 'package:flutter_bedrock/base_framework/native/native_method_manager.dart';
import 'package:flutter_bedrock/base_framework/utils/platform_utils.dart';
import 'package:flutter_bedrock/base_framework/view_model/single_view_state_model.dart';
//import 'package:install_plugin/install_plugin.dart';
import 'package:oktoast/oktoast.dart';
import 'package:permission_handler/permission_handler.dart';

class UpdateViewModel extends SingleViewStateModel{



  final String url = 'https://imtt.dd.qq.com/16891/apk/12404EAD3910202D5DC1A19F0F27135A.apk?fsname=com.taobao.taobao_9.9.1_293.apk';

  ///这个包小一点  应用宝
  final String yybUrl='https://imtt.dd.qq.com/16891/apk/04C323804EC8929DF748C5B31EAFC12F.apk?fsname=com.tencent.android.qqdownloader_7.5.4_7542130.apk';

  final CancelToken cancelToken = CancelToken();

  String progress = '0';
  setProgress(String p){
    progress = p;
    notifyListeners();
  }


  void getNewApk()async{
    if(Platform.isAndroid){
      checkPermission();
    }else{
      ///ios 去 app store吧
    }


  }

  String getSavePath(){
    String path = StorageManager.externalDirectory.path + '/test/bedrock.apk';
    debugPrint(path);
    return path;
  }

  void cancelTask(){
    cancelToken?.cancel();
  }
  Dio dio = Dio();
  downloadAPK()async{
    try{
      await dio.download(yybUrl, getSavePath(),
          cancelToken:cancelToken,
          onReceiveProgress: (receive,total){
            //debugPrint('apk info $receive   $total');
            setProgress((receive/total *100).toStringAsFixed(1));
          } ).then((response){
            if(response.statusCode == 200){
              installAPK();
            }
      });
    }catch(e,s){
      ///如果通过cancelToken取消任务，那么会抛出一个dio exception . cancel
      ///你可以对它进行捕捉并操作，也可以啥都不做
    }
  }

  installAPK(){
    debugPrint("flutter  install apk");
    NativeMethodManager.getInstance().installApk(getSavePath());
//    try{
//      ///第二个参数要与你的包名一致
//      InstallPlugin.installApk(getSavePath(), 'com.lijiaqi.flutter_bedrock')
//        .then((result){
//          debugPrint(result);
//      } ).catchError((error){
//        debugPrint(error.toString());
//      });
//
//    }on PlatformException catch(e){
//      debugPrint(e.toString());
//    }

  }


  checkPermission()async{
    Map<Permission,PermissionStatus> permissions =
    await [
      Permission.storage,
    ].request();
    if(permissions.values.first.isGranted){
      downloadAPK();

    }else{
      showToast('需要权限');
    }

  }
  
  @override
  Future loadData() {
    return null;
  }

  @override
  onCompleted(data) {

  }
  
}






















