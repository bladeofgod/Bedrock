


import 'package:package_info/package_info.dart';

const bool inProduction = const bool.fromEnvironment("dart.vm.product");

class PlatformUtils {
  /// * 获取包信息
  static Future<PackageInfo> getAppPackageInfo() {
    return PackageInfo.fromPlatform();
  }

  /// * 获取版本号
  static Future<String> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  /// * 获取 buildNumber
  static Future<String> getBuildNum() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.buildNumber;
  }



}