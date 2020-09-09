/*
* Author : LiJiqqi
* Date : 2020/4/24
*/

import 'dart:io';
import 'dart:typed_data';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bedrock/base_framework/utils/image_helper.dart';
import 'package:flutter_bedrock/base_framework/widget_state/base_state.dart';
import 'package:flutter_bedrock/base_framework/widget_state/page_state.dart';
import 'package:flutter_bedrock/generated/l10n.dart';
import 'package:image_editor/image_editor.dart' as ie;
import 'package:path_provider/path_provider.dart';

///图片存储在了沙盒里，理论上兼容华为

class ImageEditorState extends PageState {

  final String name;///图片名字

  final Uint8List memoryImage;///图片数量


  ImageEditorState({@required this.name, @required this.memoryImage});

  final GlobalKey<ExtendedImageEditorState> editorKey =
  GlobalKey<ExtendedImageEditorState>();


  @override
  Widget build(BuildContext context) {

    return switchStatusBar2Dark(
        isSetDark: true,
        child: Container(
          color: Colors.white,
          width: getWidthPx(750),
          height: getHeightPx(1334),
          child: Column(
            children: <Widget>[
              Expanded(child: Container(
                child: Center(
                  child: ExtendedImage.memory(
                    memoryImage,
                    fit: BoxFit.contain,
                    mode: ExtendedImageMode.editor,
                    enableLoadState: true,
                    extendedImageEditorKey: editorKey,
                    initEditorConfigHandler: (state) {
                      return EditorConfig(
                        maxScale: 8.0,
                        cropRectPadding: EdgeInsets.all(20.0),
                        hitTestSize: 20.0,
                        initCropRectType: InitCropRectType.imageRect,);
                    },
                  ),
                ),
              )),
              bottomBar(),
            ],
          ),
        ));
  }

  bottomBar(){
    return Container(
      color: Colors.white,
      height: getHeightPx(100),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,

        children: <Widget>[
          OutlineButton(
              onPressed: (){
                editorKey.currentState.reset();
              },
            borderSide:BorderSide(color: Colors.black54,width: getWidthPx(2)) ,
            child: Text(S.of(context).reset,style: TextStyle(color: Colors.black54,fontSize: getSp(28)),),),
          OutlineButton(
            onPressed: (){
              saveImage();
            },
            borderSide:BorderSide(color: Colors.black54,width: getWidthPx(2)) ,
            child: Text(S.of(context).confirm,style: TextStyle(color: Colors.black54,fontSize: getSp(28)),),),
        ],
      ),
    );
  }

  saveImage()async{

    Rect rect = editorKey.currentState.getCropRect();
    var data = editorKey.currentState.rawImageData;
    ie.ImageEditorOption option = ie.ImageEditorOption();
    option.addOption(ie.ClipOption.fromRect(rect));
    await ie.ImageEditor.editImage(image: data, imageEditorOption: option).then((result){
      ImageHelper.saveImage(name, result).then((path){
        pop(result: path);
      });
    });

  }

}














