



abstract class BaseException implements Exception{
  String message = "";


  BaseException(this.message);

  @override
  String toString() {

    return "${this.runtimeType} : $message";
  }
}








