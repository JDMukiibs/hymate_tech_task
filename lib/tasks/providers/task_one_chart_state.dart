import 'package:equatable/equatable.dart';
import 'package:hymate_tech_task/api/api.dart';

/// State for the Task One controller (holds selections and loaded data)
class TaskOneChartState extends Equatable {
  const TaskOneChartState({
    required this.start,
    required this.end,
    required this.selectedSeriesNames,
    required this.availableSeriesNames,
    required this.totalPowerResponse,
    required this.priceResponse,
    required this.isLoading,
    required this.error,
    required this.selectedCountry,
    required this.selectedMetric,
    required this.selectedBzn,
    required this.errorIsNotFound,
  });

  final DateTime? start;
  final DateTime? end;
  final List<String> selectedSeriesNames;
  final List<String> availableSeriesNames;
  final TotalPowerResponse? totalPowerResponse;
  final PriceResponse? priceResponse;
  final bool isLoading;
  final String? error;
  final String selectedCountry;
  final String selectedMetric; // 'total_power' or 'price'
  final String selectedBzn; // bidding zone for price
  final bool errorIsNotFound;

  TaskOneChartState copyWith({
    DateTime? start,
    DateTime? end,
    List<String>? selectedSeriesNames,
    List<String>? availableSeriesNames,
    TotalPowerResponse? totalPowerResponse,
    PriceResponse? priceResponse,
    bool? isLoading,
    String? error,
    String? selectedCountry,
    String? selectedMetric,
    String? selectedBzn,
    bool? errorIsNotFound,
  }) {
    return TaskOneChartState(
      start: start ?? this.start,
      end: end ?? this.end,
      selectedSeriesNames: selectedSeriesNames ?? this.selectedSeriesNames,
      availableSeriesNames: availableSeriesNames ?? this.availableSeriesNames,
      totalPowerResponse: totalPowerResponse ?? this.totalPowerResponse,
      priceResponse: priceResponse ?? this.priceResponse,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      selectedCountry: selectedCountry ?? this.selectedCountry,
      selectedMetric: selectedMetric ?? this.selectedMetric,
      selectedBzn: selectedBzn ?? this.selectedBzn,
      errorIsNotFound: errorIsNotFound ?? this.errorIsNotFound,
    );
  }

  @override
  List<Object?> get props => [
        start,
        end,
        selectedSeriesNames,
        availableSeriesNames,
        totalPowerResponse,
        priceResponse,
        isLoading,
        error,
        selectedCountry,
        selectedMetric,
        selectedBzn,
        errorIsNotFound,
      ];

  static TaskOneChartState initial({String defaultCountry = 'de', String defaultBzn = 'NL'}) =>
      TaskOneChartState(
        start: null,
        end: null,
        selectedSeriesNames: const [],
        availableSeriesNames: const [],
        totalPowerResponse: null,
        priceResponse: null,
        isLoading: false,
        error: null,
        selectedCountry: defaultCountry,
        selectedMetric: 'total_power',
        selectedBzn: defaultBzn,
        errorIsNotFound: false,
      );
}
