

/// 用于未登录等权限不够,需要跳转授权页面
class UnAuthorizedException implements Exception {

  @override
  String toString() => 'UnAuthorizedException';
}