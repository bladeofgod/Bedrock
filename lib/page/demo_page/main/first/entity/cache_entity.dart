/*
* Author : LiJiqqi
* Date : 2020/6/15
*/


import 'dart:core';

class CacheEntity{
  String img;
  String title;

  CacheEntity(this.img, this.title);

  CacheEntity.fromJson(Map<String,dynamic> json){
    this.img = json['img'];
    this.title = json['title'];
  }
  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data = Map<String,dynamic>();
    data['img'] = this.img;
    data['title'] = this.title;
    return data;
  }
}





























