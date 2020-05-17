

enum ViewState { idle, busy, empty, error, unAuthorized , unBind}

//enum ConnectivityStatus { WiFi, Cellular, Offline }

//enum ListViewState{idle,busy,empty,error,unAuthorized}




///method result entity

class MethodResultEntity{
  //0 or less than 0. mean exception
  int code = 0;
  String message = "";

  @override
  String toString() {
    // TODO: implement toString
    return "$code : $message";
  }
}














