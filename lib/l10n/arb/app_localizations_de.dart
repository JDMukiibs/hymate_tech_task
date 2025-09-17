// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get homeAppBarTitle => 'Startseite';

  @override
  String get homeAppBarMessage => 'Willkommen auf der Startseite';

  @override
  String get settingsAppBarTitle => 'Einstellungen';

  @override
  String get languageAppBarTitle => 'Sprache';

  @override
  String get selectLanguage => 'Sprache auswählen';

  @override
  String get taskOnePageAppBarTitle => 'Task One';

  @override
  String get taskOnePagePlaceholderMessage =>
      'This is where Task One will be implemented.';

  @override
  String get taskTwoPageAppBarTitle => 'Task Two';

  @override
  String get taskTwoPagePlaceholderMessage =>
      'This is where Task Two will be implemented.';

  @override
  String get homePageNavigateToTaskOneButtonText => 'Zu Aufgabe Eins';

  @override
  String get homePageNavigateToTaskTwoButtonText => 'Zu Aufgabe Zwei';
}
