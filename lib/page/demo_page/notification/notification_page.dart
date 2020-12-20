


import 'package:flutter/material.dart';
import 'package:flutter_bedrock/base_framework/ui/widget/notification/notification_handler.dart';
import 'package:flutter_bedrock/base_framework/widget_state/page_state.dart';


class NotificationPage extends PageState{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NotificationHandler().addNotifyListener((notifyStatus) {
      debugPrint('notify status : $notifyStatus');
    });
  }


  @override
  Widget build(BuildContext context) {
    debugPrint('notification page build');
    return switchStatusBar2Dark(child: Container(
      width: getWidthPx(750),height: getHeightPx(1334),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildBtn('顶部弹出通知', (){
            NotificationHandler()
                ..showNotificationFromTop(context,
                  child: Material(
                    child: Container(
                    margin: EdgeInsets.only(top: getWidthPx(80)),
                    color: Colors.lightBlueAccent,
                    alignment: Alignment.center,
                    width: getWidthPx(750),height: getWidthPx(200),
                    child: Text('notification'),
                  ),
                ),);
          }),

        ],
      ),
    ));
  }

  Widget buildBtn(String title,Function onTap){
    return RaisedButton(
        onPressed: onTap,
        child: Text(title),
    );
  }

}




















