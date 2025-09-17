import 'package:hymate_tech_task/app_preferences/app_preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_preferences_controller.g.dart';

@Riverpod(keepAlive: true)
class AppPreferencesController extends _$AppPreferencesController {
  @override
  FutureOr<AppPreferences> build() async {
    final appPreferencesService = ref.watch(appPreferencesServiceProvider);
    return await appPreferencesService.getPreferences();
  }

  Future<void> setActiveTheme({required String activeTheme}) async {
    state = const AsyncLoading();
    final appPreferencesService = ref.watch(appPreferencesServiceProvider);

    state = await AsyncValue.guard(() async {
      await appPreferencesService.setActiveTheme(
        activeTheme: activeTheme,
      );
      return appPreferencesService.getPreferences();
    });
  }

  Future<void> setPreferredLanguageCode({required String languageCode}) async {
    state = const AsyncLoading();
    final appPreferencesService = ref.watch(appPreferencesServiceProvider);

    state = await AsyncValue.guard(() async {
      await appPreferencesService.setPreferredLanguageCode(
        languageCode: languageCode,
      );
      return appPreferencesService.getPreferences();
    });
  }

  Future<void> clearPreferences() async {
    state = const AsyncLoading();
    final appPreferencesService = ref.watch(appPreferencesServiceProvider);

    state = await AsyncValue.guard(() async {
      await appPreferencesService.clear();
      return appPreferencesService.getPreferences();
    });
  }
}
