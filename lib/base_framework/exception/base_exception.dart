


///异常基类
/// * 建议项目内异常都继承自此异常，方便后期管理
abstract class BaseException implements Exception{
  String message = "";

  bool _handled = false;

  BaseException(this.message);

  /// 是否已处理
  /// * 可以基于此值避免重复处理异常
  /// * 复写此方法可以调整"重复"判断逻辑
  bool handled() => _handled;

  @override
  String toString() {
    return "${this.runtimeType} : $message";
  }
}








