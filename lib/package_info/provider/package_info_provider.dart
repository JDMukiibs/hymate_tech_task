import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hymate_tech_task/app/app.dart';
import 'package:package_info_plus/package_info_plus.dart' as pip;

final packageInfoProvider = Provider<PackageInfo>(
  (ref) => PackageInfo(),
);

class PackageInfo {
  late final String appName;
  late final String appVersion;
  late final String buildNumber;

  Future<void> init() async {
    final packageInfoFromPlatform = await pip.PackageInfo.fromPlatform();
    appName = AppConstants.appName;
    appVersion = packageInfoFromPlatform.version;
    buildNumber = packageInfoFromPlatform.buildNumber;
  }
}
