import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hymate_tech_task/api/api.dart';
import 'package:hymate_tech_task/tasks/providers/providers.dart';

/// Controller/provider for Task One charting
final NotifierProvider<TaskOneController, TaskOneChartState>
taskOneControllerProvider =
    NotifierProvider.autoDispose<TaskOneController, TaskOneChartState>(
      TaskOneController.new,
    );

/// Controller that manages user selections and fetching data from the Task One API.
class TaskOneController extends Notifier<TaskOneChartState> {
  TaskOneController();

  @override
  TaskOneChartState build() {
    // Schedule an initial fetch after the notifier is created
    Future.microtask(() {
      if (state.selectedMetric == 'price') {
        fetchPrice(bzn: state.selectedBzn);
      } else {
        fetchData(country: state.selectedCountry);
      }
    });
    return TaskOneChartState.initial();
  }

  /// Set the metric to fetch: 'total_power' or 'price'
  Future<void> setMetric(String metric) async {
    state = state.copyWith(selectedMetric: metric, errorIsNotFound: false);
    if (metric == 'price') {
      await fetchPrice(bzn: state.selectedBzn);
    } else {
      await fetchData(country: state.selectedCountry);
    }
  }

  /// Set the bidding zone (bzn) for price and refresh
  Future<void> setBzn(String bzn) async {
    state = state.copyWith(selectedBzn: bzn, errorIsNotFound: false);
    if (state.selectedMetric == 'price') {
      await fetchPrice(bzn: bzn);
    }
  }

  /// Set the country to use for API calls. When set, a fetch will be triggered to refresh data.
  Future<void> setCountry(String country) async {
    state = state.copyWith(selectedCountry: country, errorIsNotFound: false);
    if (state.selectedMetric == 'price') {
      await fetchPrice(bzn: state.selectedBzn);
    } else {
      await fetchData(country: country);
    }
  }

  /// Update selected time window (auto-fetches if a country is set)
  Future<void> setTimeWindow(DateTime? start, DateTime? end) async {
    state = state.copyWith(start: start, end: end, errorIsNotFound: false);
    // Auto fetch using the currently selected metric
    if (state.selectedMetric == 'price') {
      await fetchPrice(bzn: state.selectedBzn);
    } else {
      await fetchData(country: state.selectedCountry);
    }
  }

  /// Toggle a series selection by name (auto-fetches when selection changes)
  Future<void> toggleSeriesSelection(String name) async {
    final current = List<String>.from(state.selectedSeriesNames);
    if (current.contains(name)) {
      current.remove(name);
    } else {
      current.add(name);
    }
    state = state.copyWith(
      selectedSeriesNames: current,
      errorIsNotFound: false,
    );

    // Auto fetch using the currently selected metric
    if (state.selectedMetric == 'price') {
      await fetchPrice(bzn: state.selectedBzn);
    } else {
      await fetchData(country: state.selectedCountry);
    }
  }

  /// Manual chart update: fetches data from API using current time window and updates state
  Future<void> fetchData({required String country}) async {
    // Prevent overlapping requests if already loading
    if (state.isLoading) return;

    state = state.copyWith(isLoading: true, errorIsNotFound: false);

    try {
      final api = ref.read(taskOneApiServiceProvider);

      final req = TotalPowerRequest(
        country: country,
        start: state.start?.millisecondsSinceEpoch.toString(),
        end: state.end?.millisecondsSinceEpoch.toString(),
      );

      final response = await api.getTotalPower(request: req);

      // If the provider was disposed while awaiting, avoid updating state
      if (!ref.mounted) return;

      // If no available names set, populate
      final names = response.productionTypes
          .map<String>((e) => e.name)
          .toList();

      state = state.copyWith(
        totalPowerResponse: response,
        availableSeriesNames: names,
        // keep selected as-is unless empty, then select all
        selectedSeriesNames: state.selectedSeriesNames.isEmpty
            ? List<String>.from(names)
            : state.selectedSeriesNames,
        isLoading: false,
        selectedCountry: country,
      );
    } on HymateTechTaskNotFoundException catch (e) {
      if (!ref.mounted) return;
      state = state.copyWith(
        isLoading: false,
        error: e.message ?? 'Not found',
        errorIsNotFound: true,
      );
    } on HymateTechTaskValidationErrorException catch (e) {
      if (!ref.mounted) return;
      state = state.copyWith(
        isLoading: false,
        error: e.message ?? 'Validation failed',
      );
    } on HymateTechTaskException catch (e) {
      if (!ref.mounted) return;
      state = state.copyWith(
        isLoading: false,
        error: e.message ?? 'Server error',
      );
    } catch (e) {
      if (!ref.mounted) return;
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Fetch price data using the price endpoint
  Future<void> fetchPrice({required String bzn}) async {
    if (state.isLoading) return;

    state = state.copyWith(isLoading: true, errorIsNotFound: false);

    try {
      final api = ref.read(taskOneApiServiceProvider);

      final req = PriceRequest(
        bzn: bzn,
        start: state.start?.millisecondsSinceEpoch.toString(),
        end: state.end?.millisecondsSinceEpoch.toString(),
      );

      final response = await api.getPrice(request: req);

      if (!ref.mounted) return;

      state = state.copyWith(
        priceResponse: response,
        isLoading: false,
        selectedBzn: bzn,
      );
    } on HymateTechTaskNotFoundException catch (e) {
      if (!ref.mounted) return;
      state = state.copyWith(
        isLoading: false,
        error: e.message ?? 'Not found',
        errorIsNotFound: true,
      );
    } on HymateTechTaskValidationErrorException catch (e) {
      if (!ref.mounted) return;
      state = state.copyWith(
        isLoading: false,
        error: e.message ?? 'Validation failed',
      );
    } on HymateTechTaskException catch (e) {
      if (!ref.mounted) return;
      state = state.copyWith(
        isLoading: false,
        error: e.message ?? 'Server error',
      );
    } catch (e) {
      if (!ref.mounted) return;
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}
