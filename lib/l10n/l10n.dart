import 'package:flutter/widgets.dart';
import 'package:hymate_tech_task/l10n/arb/app_localizations.dart';

export 'package:hymate_tech_task/l10n/arb/app_localizations.dart';
export 'provider/provider.dart';

extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}

extension XlangauageName on Locale {
  String getLanguageName() {
    if (languageCode == 'en') {
      return 'English';
    } else if (languageCode == 'de') {
      return 'German';
    }

    return 'English';
  }
}
