/*
* Author : LiJiqqi
* Date : 2020/6/15
*/

abstract class CacheDataFactory{
  ///缓存单一数据
  String cacheData();
  void fetchCacheData(String cache);
  ///缓存list类型数据
  List<String> cacheListData();
  void fetchListCacheData(List<String> cacheList);

}























