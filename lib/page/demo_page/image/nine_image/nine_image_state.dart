/*
* Author : LiJiqqi
* Date : 2021/1/19
*/
import 'dart:typed_data';

import 'package:flutter_bedrock/base_framework/ui/widget/provider_widget.dart';
import 'package:flutter_bedrock/base_framework/utils/image_helper.dart';
import 'package:flutter_bedrock/base_framework/widget_state/widget_state.dart';

import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:oktoast/oktoast.dart';
import 'package:permission_handler/permission_handler.dart';

import 'nine_image_vm.dart';

class NineImageEditorState extends WidgetState {

  final NineImageVM nineImageVM = NineImageVM();


  @override
  void initState() {

    super.initState();
  }

  @override
  void dispose() {
    nineImageVM.clearAllData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<NineImageVM>(
      model: nineImageVM,
      onModelReady: (model){},
      builder: (ctx,model,child){
        return Container(
          color: Color.fromRGBO(238, 238, 238, 1),
          margin: EdgeInsets.symmetric(horizontal: getWidthPx(40)),
          //constraints: BoxConstraints().tighten(width: getWidthPx(670),height: getWidthPx(170)),
          height: getWidthPx(nineImageVM.row/3 * 520),
          child: GridView.count(
            crossAxisCount: 3,childAspectRatio: 168/121,
            crossAxisSpacing: getWidthPx(15),mainAxisSpacing: getWidthPx(20),
            padding: const EdgeInsets.all(0),
            children: nineImageVM.imageList.map<Widget>((e) => buildItem(e)).toList(),),
        );
      },
    );
  }

  Widget buildItem(ImageDataWrapper data){
    if(data.asset.name == nineImageVM.tag){
      return GestureDetector(
        onTap: (){
          checkPermission();
        },
        child: Container(

          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Color.fromRGBO(153, 153, 153, 1),
                  width: getWidthPx(2)),
              borderRadius: BorderRadius.circular(getWidthPx(6))
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(ImageHelper.wrapAssetsIcon('suggestion_camera'),
                width: getWidthPx(48),height: getWidthPx(40),),
              getSizeBox(height: getWidthPx(17)),
              Text('Add picture ',style: TextStyle(
                  color: Color.fromRGBO(153, 153, 153, 1),fontSize: getSp(18)
              ),),
            ],
          ),
        ),
      );
    }else{
      if(data.byteData?.buffer?.lengthInBytes != 0){
        return Container(
          child: Stack(
            children: [
              ///image
              Positioned(
                left: 0,bottom: 0,
                child: Container(
                  color: const Color.fromRGBO(250, 250, 250, 1),
                  width: getWidthPx(200),height: getWidthPx(140),
                  //margin: EdgeInsets.only(top: getWidthPx(16),right: getWidthPx(16)),
                  child: Image.memory(data.byteData.buffer.asUint8List(),fit: BoxFit.fill,),
                ),
              ),
              ///delete
              Positioned(
                right: 0,top: 0,
                child: GestureDetector(
                  onTap: (){
                    nineImageVM.deleteImage(data);
                    //widget.lengthCallback(nineImageVM.imageList.length);
                  },
                  child: Container(
                    padding: EdgeInsets.all(getWidthPx(4)),
                    width: getWidthPx(30),height: getWidthPx(30),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Color.fromRGBO(153, 153, 153, 1),
                            width: getWidthPx(2))
                    ),alignment: Alignment.center,
                    child: Icon(Icons.clear,size: getWidthPx(18),),
                  ),
                ),
              )
            ],
          ),
        );
      }else{
        return Container();
      }
    }
  }


  checkPermission()async{
//    Map<Permission, PermissionStatus> permissions = await PermissionStatus ().requestPermissions(values);
//    if (await Permission.camera.request().isGranted) {
//      // Either the permission was already granted before or the user just granted it.
//    }


    Map<Permission, PermissionStatus> permissions = await [
      Permission.camera,
      Permission.photos,
      Permission.mediaLibrary,
      Permission.storage
    ].request();

    List<bool> results = permissions.values.toList().map((status){
      return status == PermissionStatus.granted;
    }).toList();
    if(results == null || results.contains(false)){
      showToast("permission denied");
      tapOpenAppSettings();
    }else{
      showImagePicker();
    }

  }

  showImagePicker(){
    ImageHelper.pickImage(maxImages: 9).then((List<Asset> assetList){
      if(assetList == null){
        showToast("need one more image");
      }else{
        if((assetList.length + nineImageVM.imageList.length) >10){
          showToast('maximum of 9 images');
        }else{
          if(assetList == null || assetList.isEmpty)return;
          //nineImageVM.addImageList(assetList);
          showProgressDialog();

          final List<Future<ByteData>> futures = [];
          assetList.forEach((element) {
            futures.add(element.getThumbByteData(200, 200));
          });

          Future.wait<ByteData>(futures).then((value){
            final List<ImageDataWrapper> datas = [];
            for(int i = 0;i<value.length;i++){
              datas.add(ImageDataWrapper(assetList[i],value[i]));
            }
            dismissProgressDialog();
            nineImageVM.addImageList(datas);
          });
          //nineImageVM.checkLength(nineImageVM.imageList.length);
          //widget.lengthCallback(nineImageVM.imageList.length);
        }

      }


    });

  }

  void  tapOpenAppSettings()async{
    await openAppSettings();
  }

}