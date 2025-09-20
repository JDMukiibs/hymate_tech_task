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

  @override
  String get biddingZonesLabel => 'Bidding Zones';

  @override
  String get countriesLabel => 'Countries';

  @override
  String get startDateLabel => 'Start Date';

  @override
  String get endDateLabel => 'End Date';

  @override
  String get selectMetricsLabel => 'Select Metrics';

  @override
  String get fetchDataButtonLabel => 'Fetch Data';

  @override
  String get generatePlotButtonLabel => 'Generate Plot';

  @override
  String get noDataMessage => 'No data available for the selected options.';

  @override
  String get selectAtLeastOneMetricMessage =>
      'Please select at least one metric.';

  @override
  String get fetchingDataMessage => 'Fetching data...';

  @override
  String get errorFetchingDataMessage =>
      'Error fetching data. Please try again.';

  @override
  String get generatedPlotRequestTitle => 'Generated Plot Request';

  @override
  String get noPlotGeneratedMessage =>
      'No plot generated yet. Select datapoints and click \"Generate Plot\".';

  @override
  String errorGeneratingPlotMessage(Object error) {
    return 'Error generating plot: $error';
  }

  @override
  String errorLoadingDataMessage(Object error) {
    return 'Error loading data: $error';
  }

  @override
  String get datapointsLabel => 'Data Points';

  @override
  String get invalidFormMessage => 'Invalid form';

  @override
  String get invalidDateRangeMessage => 'Invalid date range';

  @override
  String get dataSeriesLabel => 'Data Series';

  @override
  String get clearSelectionsButtonText => 'Clear Selections';

  @override
  String get retryButtonText => 'Retry';

  @override
  String get showLegendLabel => 'Show Legend';

  @override
  String appVersionLabel(Object version) {
    return 'Version $version';
  }

  @override
  String get requestedDataNotFoundMessage =>
      'The requested data was not found. Please check your selections.';

  @override
  String get validationErrorMessage =>
      'There was an issue with your request. Please check your inputs.';

  @override
  String get serverErrorMessage =>
      'A server error occurred while fetching data. Please try again.';

  @override
  String get unexpectedErrorMessage =>
      'An unexpected error occurred. Please try again.';

  @override
  String get unknownErrorMessage => 'An unknown error occurred.';

  @override
  String get chartLegendTitle => 'Chart Legend';

  @override
  String get closeButtonText => 'Close';
}
