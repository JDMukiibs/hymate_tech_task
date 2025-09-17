import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:hymate_tech_task/app/app.dart';
import 'package:hymate_tech_task/logging/logging.dart';
import 'package:hymate_tech_task/package_info/package_info.dart';
import 'package:hymate_tech_task/storage/storage.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> bootstrap() async {
  // turn off the # in the URLs on the web
  usePathUrlStrategy();

  // Initialize Logging
  final logger = Logger();
  final loggingService = LoggingService(logger: logger);
  final providerObserver = ProviderLogger(logger);

  // Initialize sharedPrefs
  final prefs = await SharedPreferences.getInstance();

  FlutterError.onError = (errorDetails) async {
    await loggingService.e(
      'Crash occurred',
      error: errorDetails.exception,
      stackTrace: errorDetails.stack,
    );

    FlutterError.presentError(errorDetails);
  };

  // initialize App Version Information
  final packageInfo = PackageInfo();
  await packageInfo.init();

  runApp(
    ProviderScope(
      observers: [providerObserver],
      overrides: [
        loggingServiceProvider.overrideWithValue(loggingService),
        packageInfoProvider.overrideWithValue(packageInfo),
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
      child: const App(),
    ),
  );
}
