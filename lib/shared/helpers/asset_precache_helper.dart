import 'package:flutter/material.dart';
import 'package:hymate_tech_task/app/app.dart';

class AssetPrecacheHelper {
  AssetPrecacheHelper._();

  static Future<void> precacheImageAssets(BuildContext context) async {
    await Future.wait([
      precacheImage(const AssetImage(AppAssets.appLogo), context),
      precacheImage(const AssetImage(AppAssets.error404), context),
    ]);
  }
}
