


import 'dart:io';

import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';


class StorageManager{


  /// 临时目录 eg: cookie
  static Directory temporaryDirectory;

  static init()async{
    await SpUtil.getInstance();
    temporaryDirectory = await getTemporaryDirectory();
    ///本地缓存基本都可以使用此工具
    ///后续页面可以同步使用


  }

}