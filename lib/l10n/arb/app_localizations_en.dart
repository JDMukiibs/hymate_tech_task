// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get homeAppBarTitle => 'Home';

  @override
  String get homeAppBarMessage => 'Welcome to the Homepage';

  @override
  String get settingsAppBarTitle => 'Settings';

  @override
  String get languageAppBarTitle => 'Language';

  @override
  String get selectLanguage => 'Select Language';

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
  String get homePageNavigateToTaskOneButtonText => 'Go to Task One';

  @override
  String get homePageNavigateToTaskTwoButtonText => 'Go to Task Two';
}
