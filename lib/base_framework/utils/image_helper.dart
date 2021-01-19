
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path_provider/path_provider.dart';


class ImageHelper {
  ///这里需要更换为对应地址
  static const String baseUrl = 'http://www.baidu.com';
  static const String imagePrefix = '$baseUrl/uimg/';

  ///图片扩展名，：建议使用webP，使用前先了解一下它（据说安卓4.0以下可能不兼容，不过微信都放弃4.0了）
  static const String extensionsType = ".png";


  static String addWebp(String url){
    return  "$url.webp";
  }

  ///缩略图

  static String convertSmallUrl(String url){
    return addWebp("$url.small");
  }
  ///详情图
  static String convertRegularUrl(String url){
    return addWebp(url);
  }

  static String wrapUrl(String url) {
    if (url.startsWith('http')) {
      return url;
    } else {}
    return imagePrefix + url;
  }



  static String wrapAssets(String url,{String fileExtensions = extensionsType}) {
    return "assets/images/" + url + fileExtensions;
  }

  static String wrapAssetsIcon(String url,{bool need1x = false,String fileExtensions = extensionsType}){
    return 'assets/images/icons/${need1x?"/1.0x":""}' + url + fileExtensions;
  }

  static String wrapAssetsBG(String url,{String fileExtensions = extensionsType}){
    return 'assets/images/backgrounds/' + url + fileExtensions;
  }

  static String wrapAssetsLogo(String url,{String fileExtensions = extensionsType}){
    return 'assets/images/logos/' + url + fileExtensions;
  }

  static String wrapAssetsDefault(String url,{String fileExtensions = extensionsType}){
    return 'assets/images/default/' + url + fileExtensions;
  }
  static String wrapAssetsBanner(String url,{String fileExtensions = extensionsType}){
    return 'assets/images/backgrounds/banner/' + url + fileExtensions;
  }

  static Widget placeHolder({double width, double height}) {
    return SizedBox(
        width: width, height: height, child: CupertinoActivityIndicator(
        radius: min(10.0, width / 3)
    ));
  }
  static Widget placeHolderGoodsDefaultImg({double width,double height}){
    return SizedBox(
      width: width,height: height,
      child: Image.asset(wrapAssetsDefault("icon_default_goodsdetail.png"),
        fit: BoxFit.fill,),
    );
  }
  static Widget goodsErrorStatusImg({double width,double height}){
    return SizedBox(
      width: width,height: height,
      child: Image.asset(wrapAssetsDefault("icon_default_goodsdetail.png"),
        fit: BoxFit.fill,),
    );
  }





  /// * 从相册选择或者拍照一张照片picker   插件：MultiImagePicker

  static Future<List<Asset>> pickImage({int maxImages = 1})async{
    List<Asset> images = List<Asset>();
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: maxImages,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Bedrock App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    return resultList;

  }

  /// * 保存图片到临时路径
  static Future<String> saveImage(String name, Uint8List fileData) async {
    //Image image = Image.memory(fileData);
    Directory tempDir = await getTemporaryDirectory();
    debugPrint(tempDir.path);
    File file = File("${tempDir.path}/$name.png");
    file.writeAsBytesSync(fileData);
    debugPrint(file.path);
    return file.path;


    //return await ImagePickerSaver.saveFile(fileData: fileData);
  }


}












