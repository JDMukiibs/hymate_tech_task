import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'arb/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
  ];

  /// Text shown in the AppBar of the Home Page
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeAppBarTitle;

  /// Text shown in the body of the Home Page
  ///
  /// In en, this message translates to:
  /// **'Welcome to the Homepage'**
  String get homeAppBarMessage;

  /// Text for Settings page app bar title
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsAppBarTitle;

  /// Text for Select Language page app bar title
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageAppBarTitle;

  /// Text for Select Language page app bar title
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// AppBar title for Task One page
  ///
  /// In en, this message translates to:
  /// **'Task One'**
  String get taskOnePageAppBarTitle;

  /// Placeholder message for Task One page body
  ///
  /// In en, this message translates to:
  /// **'This is where Task One will be implemented.'**
  String get taskOnePagePlaceholderMessage;

  /// AppBar title for Task Two page
  ///
  /// In en, this message translates to:
  /// **'Task Two'**
  String get taskTwoPageAppBarTitle;

  /// Placeholder message for Task Two page body
  ///
  /// In en, this message translates to:
  /// **'This is where Task Two will be implemented.'**
  String get taskTwoPagePlaceholderMessage;

  /// Text for the navigation button to Task One on the Home Page
  ///
  /// In en, this message translates to:
  /// **'Go to Task One'**
  String get homePageNavigateToTaskOneButtonText;

  /// Text for the navigation button to Task Two on the Home Page
  ///
  /// In en, this message translates to:
  /// **'Go to Task Two'**
  String get homePageNavigateToTaskTwoButtonText;

  /// No description provided for @biddingZonesLabel.
  ///
  /// In en, this message translates to:
  /// **'Bidding Zones'**
  String get biddingZonesLabel;

  /// No description provided for @countriesLabel.
  ///
  /// In en, this message translates to:
  /// **'Countries'**
  String get countriesLabel;

  /// No description provided for @startDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Start Date'**
  String get startDateLabel;

  /// No description provided for @endDateLabel.
  ///
  /// In en, this message translates to:
  /// **'End Date'**
  String get endDateLabel;

  /// No description provided for @selectMetricsLabel.
  ///
  /// In en, this message translates to:
  /// **'Select Metrics'**
  String get selectMetricsLabel;

  /// No description provided for @fetchDataButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Fetch Data'**
  String get fetchDataButtonLabel;

  /// No description provided for @generatePlotButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Generate Plot'**
  String get generatePlotButtonLabel;

  /// No description provided for @noDataMessage.
  ///
  /// In en, this message translates to:
  /// **'No data available for the selected options.'**
  String get noDataMessage;

  /// No description provided for @selectAtLeastOneMetricMessage.
  ///
  /// In en, this message translates to:
  /// **'Please select at least one metric.'**
  String get selectAtLeastOneMetricMessage;

  /// No description provided for @fetchingDataMessage.
  ///
  /// In en, this message translates to:
  /// **'Fetching data...'**
  String get fetchingDataMessage;

  /// No description provided for @errorFetchingDataMessage.
  ///
  /// In en, this message translates to:
  /// **'Error fetching data. Please try again.'**
  String get errorFetchingDataMessage;

  /// Title for the generated plot request panel
  ///
  /// In en, this message translates to:
  /// **'Generated Plot Request'**
  String get generatedPlotRequestTitle;

  /// Shown when no plot has been generated yet
  ///
  /// In en, this message translates to:
  /// **'No plot generated yet. Select datapoints and click \"Generate Plot\".'**
  String get noPlotGeneratedMessage;

  /// Error message when generating plot fails
  ///
  /// In en, this message translates to:
  /// **'Error generating plot: {error}'**
  String errorGeneratingPlotMessage(Object error);

  /// Shown when datapoints fail to load
  ///
  /// In en, this message translates to:
  /// **'Error loading data: {error}'**
  String errorLoadingDataMessage(Object error);

  /// Label for the datapoints hierarchy section
  ///
  /// In en, this message translates to:
  /// **'Data Points'**
  String get datapointsLabel;

  /// Validation message shown when form is invalid
  ///
  /// In en, this message translates to:
  /// **'Invalid form'**
  String get invalidFormMessage;

  /// Validation message shown when date range is invalid
  ///
  /// In en, this message translates to:
  /// **'Invalid date range'**
  String get invalidDateRangeMessage;

  /// Label for the data series section
  ///
  /// In en, this message translates to:
  /// **'Data Series'**
  String get dataSeriesLabel;

  /// Button text to clear selected datapoints
  ///
  /// In en, this message translates to:
  /// **'Clear Selections'**
  String get clearSelectionsButtonText;

  /// Button text used to retry an operation
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retryButtonText;

  /// Label for showing the legend toggle
  ///
  /// In en, this message translates to:
  /// **'Show Legend'**
  String get showLegendLabel;

  /// Label showing application version
  ///
  /// In en, this message translates to:
  /// **'Version {version}'**
  String appVersionLabel(Object version);

  /// Shown when API returns a not found for requested data
  ///
  /// In en, this message translates to:
  /// **'The requested data was not found. Please check your selections.'**
  String get requestedDataNotFoundMessage;

  /// Shown when API returns a validation error
  ///
  /// In en, this message translates to:
  /// **'There was an issue with your request. Please check your inputs.'**
  String get validationErrorMessage;

  /// Shown when a server error occurs while fetching data
  ///
  /// In en, this message translates to:
  /// **'A server error occurred while fetching data. Please try again.'**
  String get serverErrorMessage;

  /// Generic unexpected error shown to the user
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred. Please try again.'**
  String get unexpectedErrorMessage;

  /// Fallback unknown error message
  ///
  /// In en, this message translates to:
  /// **'An unknown error occurred.'**
  String get unknownErrorMessage;

  /// Title for the chart legend modal
  ///
  /// In en, this message translates to:
  /// **'Chart Legend'**
  String get chartLegendTitle;

  /// Generic close button text
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get closeButtonText;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
