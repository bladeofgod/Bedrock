/*
* Author : LiJiqqi
* Date : 2020/4/8
*/



import 'package:flutter/material.dart';

class AppCacheModel extends ChangeNotifier{

  ///城市id  <ID,NAME>
  Map<String,String> provinceMap = Map();
  setProvinceMap(Map<String,String> map){
    if(map == null) return ;
    provinceMap.clear();
    provinceMap.addAll(map);
    debugPrint("province map cache : ${provinceMap.toString()}");
  }

  ///current city(province)
  String cityId;
  setCityId(String cityId){
    this.cityId = cityId;
    notifyListeners();
  }
  String cityName;
  setCityName(String name){
    this.cityName = name;
    notifyListeners();
  }

  String areaId;
  setAreaId(String areaId){
    this.areaId = areaId;
    notifyListeners();
  }

  ///skeleton var
  String skeletonName = "";
  setSkeletonName(String name){
    skeletonName = name;
  }



  /*
  * 表单页 用缓存区域
  *
  * */
  String propertyId;
  String unitId;
  String roomId;

  String coverImg;//表单用封面图




}