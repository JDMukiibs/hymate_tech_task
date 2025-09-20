class TaskConstants {
  TaskConstants._();

  static const String biddingZonesLabel = 'Bidding Zones';
  static const String countriesLabel = 'Countries';
  static const String startDateLabel = 'Start Date';
  static const String endDateLabel = 'End Date';
  static const String selectMetricsLabel = 'Select Metrics';
  static const String fetchDataButtonLabel = 'Fetch Data';
  static const String generatePlotButtonLabel = 'Generate Plot';
  static const String noDataMessage = 'No data available for the selected options.';
  static const String selectAtLeastOneMetricMessage = 'Please select at least one metric.';
  static const String fetchingDataMessage = 'Fetching data...';
  static const String errorFetchingDataMessage = 'Error fetching data. Please try again.';

  static const Map<String, String> task1Metrics = {
    'total_power': 'Total Power',
    'price': 'Price',
    'solar_share': 'Solar Share',
    'wind_onshore_share': 'Wind Onshore Share',
  };

  /// Bidding zones available for selection in the UI as a map.
  ///
  /// The key is the abbreviation used for API requests, and the value is the
  /// user-friendly name for display.
  static const Map<String, String> availableBiddingZones = {
    'AT': 'Austria',
    'BE': 'Belgium',
    'CH': 'Switzerland',
    'CZ': 'Czech Republic',
    'DE-LU': 'Germany, Luxembourg',
    'DE-AT-LU': 'Germany, Austria, Luxembourg',
    'DK1': 'Denmark 1',
    'DK2': 'Denmark 2',
    'FR': 'France',
    'HU': 'Hungary',
    'IT-North': 'Italy North',
    'NL': 'Netherlands',
    'NO2': 'Norway 2',
    'PL': 'Poland',
    'SE4': 'Sweden 4',
    'SI': 'Slovenia',
  };

  /// Countries available for selection in the UI as a map.
  ///
  /// The key is the abbreviation used for API requests, and the value is the
  /// user-friendly name for display.
  static const Map<String, String> availableCountries = {
    'de': 'Germany',
    'ch': 'Switzerland',
    'eu': 'European Union',
    'all': 'Europe',
    'al': 'Albania',
    'am': 'Armenia',
    'at': 'Austria',
    'az': 'Azerbaijan',
    'ba': 'Bosnia-Herzegovina',
    'be': 'Belgium',
    'bg': 'Bulgaria',
    'by': 'Belarus',
    'cy': 'Cyprus',
    'cz': 'Czech Republic',
    'dk': 'Denmark',
    'ee': 'Estonia',
    'es': 'Spain',
    'fi': 'Finland',
    'fr': 'France',
    'ge': 'Georgia',
    'gr': 'Greece',
    'hr': 'Croatia',
    'hu': 'Hungary',
    'ie': 'Ireland',
    'it': 'Italy',
    'lt': 'Lithuania',
    'lu': 'Luxembourg',
    'lv': 'Latvia',
    'md': 'Moldova',
    'me': 'Montenegro',
    'mk': 'North Macedonia',
    'mt': 'Malta',
    'nie': 'North Ireland',
    'nl': 'Netherlands',
    'no': 'Norway',
    'pl': 'Poland',
    'pt': 'Portugal',
    'ro': 'Romania',
    'rs': 'Serbia',
    'ru': 'Russia',
    'se': 'Sweden',
    'si': 'Slovenia',
    'sk': 'Slovak Republic',
    'tr': 'Turkey',
    'ua': 'Ukraine',
    'uk': 'United Kingdom',
    'xk': 'Kosovo',
  };
}
