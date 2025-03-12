import 'package:package_info_plus/package_info_plus.dart';

class VersionInfo {
  static late String version;
  static late String buildNumber;

  // Static method to initialize version info
  static Future<void> init() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;
    buildNumber = packageInfo.buildNumber;
  }

  // Method to retrieve formatted version info
  static String getVersionInfo() {
    return 'Version: $version  Build: $buildNumber';
  }
}
