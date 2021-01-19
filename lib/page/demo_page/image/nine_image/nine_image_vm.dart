/*
* Author : LiJiqqi
* Date : 2021/1/19
*/

import 'dart:typed_data';

import 'package:flutter_bedrock/base_framework/view_model/single_view_state_model.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class ImageDataWrapper{
  final Asset asset;
  final ByteData byteData;

  const ImageDataWrapper(this.asset, this.byteData);
}

class NineImageVM extends SingleViewStateModel{


  final List<ImageDataWrapper> imageList = [];


  final String tag = 'edit';
  final ImageDataWrapper editWrapper =ImageDataWrapper(Asset('editIdentifier','edit',1,1), null);

  NineImageVM(){
    imageList.add(editWrapper);
  }


  void addImageList(List<ImageDataWrapper> list){
    imageList.insertAll(0, list);
    if(imageList.length > 9){
      imageList.removeLast();
    }
    checkLength(imageList.length);


  }



//  void addImage(Asset asset){
//    if(imageList.length == 9){
//      imageList.insert(8, asset);
//    }else{
//      imageList.insert(0, asset);
//    }
//    notifyListeners();
//  }
  void deleteImage(ImageDataWrapper asset){

    if(imageList.length == 9 && imageList.last.asset.name != tag){
      imageList.removeWhere((element) => element == asset);
      imageList.add(editWrapper);
    }else{
      imageList.removeWhere((element) => element.asset.name == asset.asset.name);
    }

    checkLength(imageList.length);
  }


  int row = 1;
  int nineImageLength = 1;
  void checkLength(int l){
    if(l != nineImageLength){
      if((nineImageLength/3).ceil() != (l/3).ceil()){
        nineImageLength = l;
        row = (nineImageLength/3).ceil();

      }
    }
    notifyListeners();
  }

  void clearAllData(){
    imageList.clear();
  }


  @override
  Future loadData() {

  }

  @override
  onCompleted(data) {

  }

}
