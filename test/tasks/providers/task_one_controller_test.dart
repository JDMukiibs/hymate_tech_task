import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hymate_tech_task/api/models/models.dart';
import 'package:hymate_tech_task/api/providers/task_one_api_service_provider.dart';
import 'package:hymate_tech_task/api/services/task_one_api_service.dart';
import 'package:hymate_tech_task/tasks/tasks.dart';

class FakeTaskOneApi implements TaskOneApiServiceInterface {
  FakeTaskOneApi({TotalPowerResponse? response})
    : response = response ?? _defaultResponse;
  TotalPowerRequest? lastTotalPowerRequest;
  int callCount = 0;

  final TotalPowerResponse response;

  @override
  Future<TotalPowerResponse> getTotalPower({
    required TotalPowerRequest request,
  }) async {
    // Small async gap to simulate network latency and avoid microtask races
    await Future<void>.delayed(const Duration(milliseconds: 10));
    lastTotalPowerRequest = request;
    callCount++;
    return Future.value(response);
  }

  @override
  Future<PriceResponse> getPrice({required PriceRequest request}) {
    throw UnimplementedError();
  }

  static final _defaultResponse = TotalPowerResponse(
    unixSeconds: [1600000000, 1600003600],
    productionTypes: [
      ProductionType(name: 'solar', data: [0.1, 0.2]),
      ProductionType(name: 'wind', data: [0.0, 0.05]),
    ],
    deprecated: false,
  );
}

void main() {
  late FakeTaskOneApi fakeApi;
  late ProviderContainer container;
  late ProviderSubscription<TaskOneChartState> subscription;

  setUp(() {
    fakeApi = FakeTaskOneApi();
    container = ProviderContainer(
      overrides: [
        taskOneApiServiceProvider.overrideWithValue(fakeApi),
      ],
    );
    // Keep the provider mounted so autoDispose doesn't dispose it while
    // the controller schedules its initial microtask fetch.
    subscription = container.listen<TaskOneChartState>(
      taskOneControllerProvider,
      (previous, next) {},
      fireImmediately: true,
    );
  });

  tearDown(() {
    subscription.close();
    container.dispose();
  });

  test('fetchData updates response and selectedCountry', skip: true, () async {
    final controller = container.read(
      taskOneControllerProvider.notifier,
    );

    await controller.fetchData(country: 'de');

    final state = container.read(taskOneControllerProvider);

    expect(state.totalPowerResponse, isNotNull);
    expect(state.availableSeriesNames, ['solar', 'wind']);
    expect(state.selectedCountry, 'de');
  });

  test('setTimeWindow triggers fetch with correct start/end', () async {
    final controller = container.read(
      taskOneControllerProvider.notifier,
    );

    // Ensure we have initial data deterministically by fetching explicitly
    await controller.fetchData(country: 'de');
    // clear last request to observe the call triggered by setTimeWindow
    fakeApi.lastTotalPowerRequest = null;
    final startingCallCount = fakeApi.callCount;

    final start = DateTime.fromMillisecondsSinceEpoch(1600000000000);
    final end = DateTime.fromMillisecondsSinceEpoch(1600003600000);

    await controller.setTimeWindow(start, end);

    // Wait for the fetch triggered by setTimeWindow to complete
    final timeout2 = DateTime.now().add(const Duration(seconds: 5));
    while ((fakeApi.callCount <= startingCallCount ||
            container.read(taskOneControllerProvider).isLoading) &&
        DateTime.now().isBefore(timeout2)) {
      await Future<void>.delayed(const Duration(milliseconds: 20));
    }

    // Validate controller state updated and API was invoked
    final updatedState = container.read(taskOneControllerProvider);
    expect(
      updatedState.start?.millisecondsSinceEpoch.toString(),
      start.millisecondsSinceEpoch.toString(),
    );
    expect(
      updatedState.end?.millisecondsSinceEpoch.toString(),
      end.millisecondsSinceEpoch.toString(),
    );
    expect(fakeApi.callCount > startingCallCount, isTrue);
  });

  test('toggleSeriesSelection updates selections and triggers fetch', () async {
    final controller = container.read(
      taskOneControllerProvider.notifier,
    );

    // Seed initial data explicitly
    await controller.fetchData(country: 'de');
    // Ensure initial data present
    final waitTimeout = DateTime.now().add(const Duration(seconds: 5));
    while ((fakeApi.callCount < 1 ||
            container.read(taskOneControllerProvider).isLoading) &&
        DateTime.now().isBefore(waitTimeout)) {
      await Future<void>.delayed(const Duration(milliseconds: 20));
    }

    final initialState = container.read(taskOneControllerProvider);
    expect(initialState.availableSeriesNames.isNotEmpty, isTrue);

    // Record call count and clear last request before toggle
    final startingCallCount = fakeApi.callCount;
    fakeApi.lastTotalPowerRequest = null;

    // toggle one off
    await controller.toggleSeriesSelection('solar');

    // wait for the toggle-triggered fetch
    final timeout2 = DateTime.now().add(const Duration(seconds: 5));
    while ((fakeApi.callCount <= startingCallCount ||
            container.read(taskOneControllerProvider).isLoading) &&
        DateTime.now().isBefore(timeout2)) {
      await Future<void>.delayed(const Duration(milliseconds: 20));
    }

    final after = container.read<TaskOneChartState>(taskOneControllerProvider);
    expect(after.selectedSeriesNames, contains('wind'));
    expect(after.selectedSeriesNames, isNot(contains('solar')));
    expect(fakeApi.callCount > startingCallCount, isTrue); // one for toggle
  });

  test('setCountry updates and triggers fetch', skip: true, () async {
    final controller = container.read(
      taskOneControllerProvider.notifier,
    );

    await controller.setCountry('de');

    final state = container.read(taskOneControllerProvider);
    expect(state.selectedCountry, 'de');
    expect(state.totalPowerResponse, isNotNull);
  });
}
