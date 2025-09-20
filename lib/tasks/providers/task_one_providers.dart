import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hymate_tech_task/api/api.dart';
import 'package:hymate_tech_task/tasks/tasks.dart';
import 'package:reactive_forms/reactive_forms.dart';

final taskOneControllerProvider =
AsyncNotifierProvider<TaskOneController, TaskOneChartState>(
  TaskOneController.new,
);

class TaskOneController extends AsyncNotifier<TaskOneChartState> {
  late final FormGroup formGroup;

  @override
  Future<TaskOneChartState> build() async {
    _initializeForm();
    return TaskOneChartState.initial();
  }

  void _initializeForm() {
    formGroup = FormGroup({
      'metric': FormControl<String>(
        value: 'total_power',
        validators: [Validators.required],
      ),
      'country': FormControl<String>(
        value: 'de',
        validators: [Validators.required],
      ),
      'bzn': FormControl<String>(
        value: 'NL',
        validators: [Validators.required],
      ),
      'startDate': FormControl<DateTime>(),
      'endDate': FormControl<DateTime>(),
      'selectedSeries': FormArray<String>([]),
    });

    // Listen to metric changes to trigger data fetching
    formGroup
        .control('metric')
        .valueChanges
        .listen((_) => _onMetricChange());
    formGroup
        .control('country')
        .valueChanges
        .listen((_) => _onCountryChange());
    formGroup
        .control('bzn')
        .valueChanges
        .listen((_) => _onBznChange());
  }

  String get selectedMetric =>
      formGroup
          .control('metric')
          .value as String;

  String get selectedCountry =>
      formGroup
          .control('country')
          .value as String;

  String get selectedBzn =>
      formGroup
          .control('bzn')
          .value as String;

  DateTime? get startDate =>
      formGroup
          .control('startDate')
          .value as DateTime?;

  DateTime? get endDate =>
      formGroup
          .control('endDate')
          .value as DateTime?;

  bool get canFetchData => formGroup.valid && _hasValidDateRange();

  bool get hasChartData => state.value?.generatedChartData.isNotEmpty ?? false;

  bool _hasValidDateRange() {
    final start = startDate;
    final end = endDate;
    return start == null || end == null || start.isBefore(end);
  }

  Future<void> setMetric(String metric) async {
    formGroup
        .control('metric')
        .value = metric;
  }

  Future<void> setCountry(String country) async {
    formGroup
        .control('country')
        .value = country;
  }

  Future<void> setBzn(String bzn) async {
    formGroup
        .control('bzn')
        .value = bzn;
  }

  Future<void> setDateRange(DateTime? start, DateTime? end) async {
    formGroup
        .control('startDate')
        .value = start;
    formGroup
        .control('endDate')
        .value = end;
  }

  void toggleSeriesSelection(String seriesName) {
    final currentState = state.value!;
    final currentSelected = List<String>.from(currentState.selectedSeriesNames);

    if (currentSelected.contains(seriesName)) {
      currentSelected.remove(seriesName);
      _removeColorAssignment(seriesName);
    } else {
      currentSelected.add(seriesName);
      _assignColor(seriesName);
    }

    final newState = currentState.copyWith(
      selectedSeriesNames: currentSelected,
    );
    state = AsyncValue.data(newState);
    _syncFormWithState();
  }

  void _assignColor(String seriesName) {
    final currentState = state.value!;
    final newColors = Map<String, Color>.from(currentState.assignedColors);

    if (!newColors.containsKey(seriesName)) {
      newColors[seriesName] = ColorHelper.assignColorBasedOnHashCode(
        seriesName,
      );
    }

    state = AsyncValue.data(currentState.copyWith(assignedColors: newColors));
  }

  void _removeColorAssignment(String seriesName) {
    final currentState = state.value!;
    final newColors = Map<String, Color>.from(currentState.assignedColors);
    newColors.remove(seriesName);
    state = AsyncValue.data(currentState.copyWith(assignedColors: newColors));
  }

  void _syncFormWithState() {
    final currentState = state.value!;
    final seriesArray =
    formGroup.control('selectedSeries') as FormArray<String>;
    seriesArray.value = currentState.selectedSeriesNames;
    formGroup.updateValueAndValidity();
  }

  void _onMetricChange() {
    final currentState = state.value!;
    /// Clear the legend so that previous selections don't persist across metrics
    state = AsyncValue.data(
      currentState.copyWith(selectedSeriesNames: [],
        availableSeriesNames: [],
        assignedColors: {},),
    );

    if (canFetchData) {
      fetchData();
    }
  }

  void _onCountryChange() {
    if (canFetchData && (selectedMetric != 'price')) {
      fetchData();
    }
  }

  void _onBznChange() {
    if (canFetchData && selectedMetric == 'price') {
      fetchData();
    }
  }

  Future<void> fetchData() async {
    if (state.isLoading) return;

    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final api = ref.read(taskOneApiServiceProvider);
      final currentState = state.value ?? TaskOneChartState.initial();

      switch (selectedMetric) {
        case 'total_power':
          final response = await _fetchTotalPower(api);
          final seriesNames = response.productionTypes
              .map((e) => e.name)
              .toList();
          return currentState.copyWith(
            totalPowerResponse: response,
            availableSeriesNames: seriesNames,
            selectedSeriesNames: currentState.selectedSeriesNames.isEmpty
                ? seriesNames
                : currentState.selectedSeriesNames,
          );

        case 'price':
          final response = await _fetchPrice(api);
          return currentState.copyWith(
            priceResponse: response,
            availableSeriesNames: ['Price (${response.unit})'],
            selectedSeriesNames: ['Price (${response.unit})'],
          );

        case 'solar_share':
          final response = await api.getSolarShare(country: selectedCountry);
          final seriesName = 'Solar Share (${response.unit})';
          return currentState.copyWith(
            solarShareResponse: response,
            availableSeriesNames: [seriesName],
            selectedSeriesNames: [seriesName],
          );

        case 'wind_onshore_share':
          final response = await api.getWindOnshoreShare(
            country: selectedCountry,
          );
          final seriesName = 'Wind Onshore Share (${response.unit})';
          return currentState.copyWith(
            windOnshoreShareResponse: response,
            availableSeriesNames: [seriesName],
            selectedSeriesNames: [seriesName],
          );

        default:
          throw Exception('Unknown metric: $selectedMetric');
      }
    });

    if (state.hasValue) {
      _syncFormWithState();
    }
  }

  Future<TotalPowerResponse> _fetchTotalPower(
      TaskOneApiServiceInterface api,) async {
    final request = TotalPowerRequest(
      country: selectedCountry,
      start: getUnixSeconds(startDate),
      end: getUnixSeconds(endDate),
    );
    return api.getTotalPower(request: request);
  }

  Future<PriceResponse> _fetchPrice(TaskOneApiServiceInterface api) async {
    final request = PriceRequest(
      bzn: selectedBzn,
      start: getUnixSeconds(startDate),
      end: getUnixSeconds(endDate),
    );
    return api.getPrice(request: request);
  }

  void clearSelections() {
    final currentState = state.value!;
    state = AsyncValue.data(
      currentState.copyWith(
        selectedSeriesNames: [],
        assignedColors: {},
      ),
    );
    _syncFormWithState();
  }

  bool isSeriesSelected(String seriesName) {
    return state.value?.selectedSeriesNames.contains(seriesName) ?? false;
  }

  String getUnixSeconds(DateTime? date) {
    if (date == null) return '';
    return (date
        .toUtc()
        .millisecondsSinceEpoch ~/ 1000).toString();
  }
}
