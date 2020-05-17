import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tripalink/base_framework/widget_state/base_state.dart';


class TripaLiskToastUtils {
  // showShort
  static showShort(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        fontSize: 16,
        backgroundColor: Color(0xFF373C41),
        textColor: Color(0xFFFFFFFF));
  }

  // showToast
  static showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        fontSize: 16,
        backgroundColor: Color.fromRGBO(50,51,53,0.6),
        textColor: Color(0xFFFFFFFF));
  }

  // 显示对话框
  static Future<dynamic> showModelDialog(
      BuildContext _context, String _title, Widget _widget) {
    return showDialog<Null>(
      context: _context,
      builder: (BuildContext context) {
        return new SimpleDialog(
          title: new Text(_title),
          children: <Widget>[_widget],
        );
      },
    );
  }
  static show(String msg) {
    Fluttertoast.showToast(msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
    );
  }


  // 显示对话框
  static Future<dynamic> showAdvetDialog(
      BuildContext _context, Widget _widget)async{
    return await showDialog<Null>(
      context: _context,
      builder: (BuildContext context) {
        return new SimpleDialog(
          backgroundColor: Color(0x00FFFFFF),
          children: <Widget>[
            new GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: _widget,
            )
          ],
        );
      },
    );
  }
}
