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

abstract class ImageWidgetChangeListener{

  void addChildWidget(ImageDataWrapper dataWrapper);

  void addChildrenWidget(List<ImageDataWrapper> datas);

  void removeChildWidget(ImageDataWrapper dataWrapper);
}

class NineImageVM extends SingleViewStateModel{


  final List<ImageDataWrapper> imageList = [];
  final ImageWidgetChangeListener _changeListener;


  final String tag = 'edit';
  final ImageDataWrapper editWrapper =ImageDataWrapper(Asset('editIdentifier','edit',1,1), null);

  NineImageVM(this._changeListener);

  void addImageData({ImageDataWrapper data}){
    imageList.add(data??editWrapper);
    _changeListener.addChildWidget(data??editWrapper);
    notifyListeners();
  }

  ///进入这个方法，最多只会是9张自选图片
  /// * 如果多余9张，是不会进入到这个方法
  void addImageList(List<ImageDataWrapper> list){
    imageList.insertAll(0, list);
    if(imageList.length > 9){
      ///如果是9张自选图片，移除最后一张。
      imageList.removeLast();
    }
    _changeListener.addChildrenWidget(list);
    notifyListeners();
    //checkLength(imageList.length);


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
      imageList.removeWhere((element) => element.asset.name == asset.asset.name);
      imageList.add(editWrapper);
    }else{
      imageList.removeWhere((element) => element.asset.name == asset.asset.name);
    }
    _changeListener.removeChildWidget(asset);
    notifyListeners();

    //checkLength(imageList.length);
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
