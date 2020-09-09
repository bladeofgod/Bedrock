/*
* Author : LiJiqqi
* Date : 2020/9/9
*/

_RouterManager manager = _RouterManager();


///路由相关
///可以在此拓展功能，如记录、埋点等等根据自己的需求增加

abstract class RouterBinding{


  addRecord(String page){
    if(page.isEmpty == null)return;
    manager.add(page);
  }

  removeRecord(String page){
    if(page == null)return;
    manager.remove(page);
  }
}



class _RouterManager{
  final List<String> routeRecords = [];
  add(String page){
    routeRecords.add(page);
  }

  remove(String page){
    if(routeRecords.last == page){
      routeRecords.removeLast();
    }
  }


}