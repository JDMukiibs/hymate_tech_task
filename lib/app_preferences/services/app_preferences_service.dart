import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hymate_tech_task/app_preferences/app_preferences.dart';
import 'package:hymate_tech_task/logging/logging.dart';
import 'package:hymate_tech_task/storage/storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

final appPreferencesServiceProvider = Provider<AppPreferencesService>(
  (ref) {
    final sharedPrefs = ref.watch(sharedPreferencesProvider);
    final logger = ref.watch(loggingServiceProvider);

    return AppPreferencesService(sharedPrefs: sharedPrefs, logger: logger);
  },
);

class AppPreferencesService {
  AppPreferencesService({
    required this.sharedPrefs,
    required this.logger,
  });

  final SharedPreferences sharedPrefs;
  final LoggingService logger;

  static const String _appPrefsKey = 'app_preferences';

  Future<void> clear() async {
    await sharedPrefs.remove(_appPrefsKey);
    logger.i('Cleared AppPreferences');
  }

  Future<AppPreferences> getPreferences() async {
    final prefsString = sharedPrefs.getString(_appPrefsKey);

    if (prefsString == null) {
      logger.i('No AppPreferences found, returning defaults');
      return AppPreferences.withDefaults();
    }

    try {
      final prefsMap = jsonDecode(prefsString) as Map<String, dynamic>;
      final prefs = AppPreferences.fromMap(prefsMap);
      logger.i('Retrieved AppPreferences: $prefs');
      return prefs;
    } on Exception catch (e, st) {
      await logger.e(
        'Error parsing AppPreferences',
        error: e,
        stackTrace: st,
      );
      return AppPreferences.withDefaults();
    }
  }

  Future<void> savePreferences(AppPreferences preferences) async {
    final prefsMap = preferences.toMap();
    final prefsString = jsonEncode(prefsMap);

    await sharedPrefs.setString(_appPrefsKey, prefsString);
    logger.i('Saved AppPreferences: $preferences');
  }

  Future<void> setActiveTheme({required String activeTheme}) async {
    logger.i('Setting activeTheme to $activeTheme');
    final prefs = await getPreferences();
    prefs.activeTheme = activeTheme;
    await savePreferences(prefs);
  }

  Future<void> setPreferredLanguageCode({required String languageCode}) async {
    logger.i('Setting preferredLanguageCode to $languageCode');
    final prefs = await getPreferences();
    prefs.preferredLanguageCode = languageCode;
    await savePreferences(prefs);
  }
}
