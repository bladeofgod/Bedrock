/*
* Author : LiJiqqi
* Date : 2020/4/27
*/

///google 推送

//import 'package:firebase_messaging/firebase_messaging.dart';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//import 'package:flutter_bedrock/fcm/facebook_message_push.dart';
//import 'dart:io';
//
//class NotificationUtil{
//
//  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin ;
//
//  factory NotificationUtil()=>_getInstance();
//  static NotificationUtil get instance => _getInstance();
//  static NotificationUtil _instance;
//  NotificationUtil._internal(){
//    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//  }
//  init()async{
//    var initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
//    var initializationSettingsIOS = IOSInitializationSettings(
//        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
//    var initializationSettings = InitializationSettings(
//        initializationSettingsAndroid, initializationSettingsIOS);
//    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
//        onSelectNotification: selectNotification);
//    fcm();
//  }
//
//  static NotificationUtil _getInstance(){
//    if(_instance == null){
//      _instance = NotificationUtil._internal();
//    }
//    return _instance;
//  }
//
//  FirebaseMessaging firebaseMessaging = FirebaseMessaging();
//
//  fcm(){
//    firebaseMessaging.getToken().then((token){
//      print("Push Messaging token: 33 $token");
//      print(token);
//    });
//    if (Platform.isIOS) {
//      if(firebaseMessaging.requestNotificationPermissions(const IosNotificationSettings(sound: true, badge: true, alert: true, provisional: true))){
//        ///IOS需要这个too
//        firebaseMessaging.onIosSettingsRegistered.listen((IosNotificationSettings settings) {
//          print("Settings registered: $settings");
//        });
//        ///获取设备的Token，每次重装APP会导致Token变化
//        firebaseMessaging.getToken().then((String token) {
//          print("Push Messaging token: $token");
//          assert(token != null);
//          print("Push Messaging token: $token");
//        });
//      }
//    }
//    firebaseMessaging.configure(
//      onMessage: (Map<String, dynamic> message) async {
//        print("__________onMessage: $message");
//        //_showItemDialog(message);
//        int id = (DateTime.now().millisecondsSinceEpoch/1000).ceil();
//        showNotification(id:id,msg: message.toString(),desc: "test msg");
//      },
//      onBackgroundMessage: myBackgroundMessageHandler,
//      onLaunch: (Map<String, dynamic> message) async {
//        print("onLaunch: $message");
//        //_navigateToItemDetail(message);
//      },
//      onResume: (Map<String, dynamic> message) async {
//        print("onResume: $message");
//        //_navigateToItemDetail(message);
//      },
//    );
//  }
//
//  ///tap notification
//  Future selectNotification(String payload)async{
//    debugPrint("notification   $payload");
//  }
//
//  Future onDidReceiveLocalNotification(int id, String title, String body, String payload)async{
//    //do something
//  }
//
//
//  showNotification({int id,String msg,String desc})async{
//    //安卓的通知配置，必填参数是渠道id, 名称, 和描述, 可选填通知的图标，重要度等等。
//    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
//        "$id", '$id ---- $msg', '$desc',
//        importance: Importance.Max, priority: Priority.High);
//    //IOS的通知配置
//    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
//    var platformChannelSpecifics = new NotificationDetails(
//        androidPlatformChannelSpecifics,
//        iOSPlatformChannelSpecifics
//    );
//    //显示通知，其中 0 代表通知的 id，用于区分通知。
//    await flutterLocalNotificationsPlugin.show(
//        id, 'title', 'content', platformChannelSpecifics,
//        payload: 'complete');
//  }
//
//
//}



















