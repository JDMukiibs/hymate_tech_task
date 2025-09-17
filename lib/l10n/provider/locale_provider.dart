import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hymate_tech_task/app_preferences/app_preferences.dart';
import 'package:hymate_tech_task/l10n/l10n.dart';

final localeProvider = NotifierProvider<LocaleNotifier, Locale>(
  LocaleNotifier.new,
);

class LocaleNotifier extends Notifier<Locale> {
  @override
  Locale build() {
    const supported = AppLocalizations.supportedLocales;
    final deviceLocale = WidgetsBinding.instance.platformDispatcher.locale;
    final match = supported.firstWhere(
          (locale) => locale.languageCode == deviceLocale.languageCode,
      orElse: () => supported.first,
    );
    return match;
  }

  Future<void> getLastSavedLocale() async {
    final prefs = await ref
        .read(appPreferencesServiceProvider)
        .getPreferences();
      const supported = AppLocalizations.supportedLocales;
    final languageCode = prefs.preferredLanguageCode;
    if (languageCode != null) {
      final match = supported.firstWhere(
            (locale) => locale.languageCode == languageCode,
        orElse: () => supported.first,
      );
      state = match;
    } else {
      final deviceLocale = WidgetsBinding.instance.platformDispatcher.locale;
      final match = supported.firstWhere(
            (locale) => locale.languageCode == deviceLocale.languageCode,
        orElse: () => supported.first,
      );
      state = match;
    }
  }

  Future<void> updateCurrentLanguage(String languageCode) async {
    const supported = AppLocalizations.supportedLocales;
    final newLocale = supported.firstWhere(
          (locale) => locale.languageCode == languageCode,
      orElse: () => supported.first,
    );

    state = newLocale;

    await ref
        .read(appPreferencesServiceProvider)
        .setPreferredLanguageCode(languageCode: languageCode);
  }
}
