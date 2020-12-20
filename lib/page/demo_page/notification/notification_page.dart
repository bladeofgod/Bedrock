


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bedrock/base_framework/ui/widget/notification/notification_handler.dart';
import 'package:flutter_bedrock/base_framework/widget_state/page_state.dart';
import 'package:flutter_bedrock/page/demo_page/notification/notify_target_page.dart';


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
          buildBtn('弹出通知', (){
            NotificationHandler()
                ..showNotificationFromTop(context,notifyDwellTime: Duration(seconds: 2),
                  child: Material(
                    child: GestureDetector(
                      onTap: (){
                        push(NotifyTargetPage());
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: getWidthPx(80),left: getWidthPx(20),right: getWidthPx(20)),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(getWidthPx(10)),
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0, 1),spreadRadius: 0.5,
                                  blurRadius:0.5,color: Color.fromRGBO(34, 34, 34, 0.3)),
                            ]
                        ),

                        alignment: Alignment.center,
                        width: getWidthPx(750),height: getWidthPx(200),
                        child: Text('notification'),
                      ),
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




















