

import 'package:flutter/material.dart';
import 'package:flutter_bedrock/base_framework/widget_state/base_state.dart';
import 'package:flutter_bedrock/base_framework/widget_state/page_state.dart';
import 'package:oktoast/oktoast.dart';
import 'package:permission_handler/permission_handler.dart';


class RequestPermissionsPageState extends PageState {

  String status = '权限未请求';

  @override
  Widget build(BuildContext context) {
    return switchStatusBar2Dark(child: Container(
      width: getWidthPx(750), height: getHeightPx(1334),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(status,style: TextStyle(color: Colors.black,fontSize: getSp(30)),),
          getSizeBox(height: getWidthPx(100)),
          RaisedButton(
            child: Text('request location permission'),
            onPressed: (){
              request();
            },
          ),
        ],
      ),
    ));
  }


  request()async{
    Map<Permission,PermissionStatus> permissions = await [
      Permission.location,
    ].request();

    List<bool> results = permissions.values.toList()
        .map((status) => status == PermissionStatus.granted).toList();
    if(results == null || results.contains(false)){
      showToast('permissions denied');
      setState(() {
        status = '权限拒绝';
      });
    }else{
      showToast('permissions granted');
      setState(() {
        status = '权限通过';
      });
      ///do stuff
    }

  }

}















