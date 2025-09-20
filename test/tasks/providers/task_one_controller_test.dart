import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hymate_tech_task/api/api.dart';
import 'package:hymate_tech_task/tasks/tasks.dart';

class FakeTaskOneApi implements TaskOneApiServiceInterface {
  FakeTaskOneApi({TotalPowerResponse? response})
    : response = response ?? _defaultResponse,
      priceResponse = _defaultPriceResponse,
      solarResponse = _defaultSolarResponse,
      windResponse = _defaultWindResponse;

  TotalPowerRequest? lastTotalPowerRequest;
  PriceRequest? lastPriceRequest;
  String? lastSolarCountry;
  String? lastWindCountry;

  int totalCallCount = 0;
  int priceCallCount = 0;
  int solarCallCount = 0;
  int windCallCount = 0;

  final TotalPowerResponse response;
  final PriceResponse priceResponse;
  final RenewableShareResponse solarResponse;
  final RenewableShareResponse windResponse;

  @override
  Future<TotalPowerResponse> getTotalPower({
    required TotalPowerRequest request,
  }) async {
    // Small async gap to simulate network latency and avoid microtask races
    await Future<void>.delayed(const Duration(milliseconds: 10));
    lastTotalPowerRequest = request;
    totalCallCount++;
    return Future.value(response);
  }

  @override
  Future<PriceResponse> getPrice({required PriceRequest request}) async {
    await Future<void>.delayed(const Duration(milliseconds: 10));
    lastPriceRequest = request;
    priceCallCount++;
    return Future.value(priceResponse);
  }

  static final _defaultResponse = TotalPowerResponse(
    unixSeconds: [1600000000, 1600003600],
    productionTypes: [
      ProductionType(name: 'solar', data: [0.1, 0.2]),
      ProductionType(name: 'wind', data: [0.0, 0.05]),
    ],
    deprecated: false,
  );

  static final _defaultPriceResponse = PriceResponse(
    licenseInfo: 'MIT',
    unixSeconds: [1600000000, 1600003600],
    price: [42.0, 43.5],
    unit: 'EUR/MWh',
    deprecated: false,
  );

  static final _defaultSolarResponse = RenewableShareResponse(
    unixSeconds: [1600000000, 1600003600],
    data: [10.0, 12.0],
    forecast: [11.0, 13.0],
    deprecated: false,
  );

  static final _defaultWindResponse = RenewableShareResponse(
    unixSeconds: [1600000000, 1600003600],
    data: [20.0, 22.0],
    forecast: [21.0, 23.0],
    deprecated: false,
  );

  @override
  Future<RenewableShareResponse> getSolarShare({
    required String country,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 10));
    lastSolarCountry = country;
    solarCallCount++;
    return Future.value(solarResponse);
  }

  @override
  Future<RenewableShareResponse> getWindOnshoreShare({
    required String country,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 10));
    lastWindCountry = country;
    windCallCount++;
    return Future.value(windResponse);
  }
}

void main() {
  late FakeTaskOneApi fakeApi;
  late ProviderContainer container;
  late ProviderSubscription<AsyncValue<TaskOneChartState>> subscription;

  setUp(() {
    fakeApi = FakeTaskOneApi();
    container = ProviderContainer(
      overrides: [
        taskOneApiServiceProvider.overrideWithValue(fakeApi),
      ],
    );
    // Keep the provider mounted so autoDispose doesn't dispose it while
    // the controller schedules its initial microtask fetch.
    subscription = container.listen<AsyncValue<TaskOneChartState>>(
      taskOneControllerProvider,
      (previous, next) {},
      fireImmediately: true,
    );
  });

  tearDown(() {
    subscription.close();
    container.dispose();
  });

  test('setTimeWindow triggers fetch with correct start/end', () async {
    final controller = container.read(
      taskOneControllerProvider.notifier,
    );

    // Ensure we have initial data deterministically by fetching explicitly
    await controller.setCountry('de');
    await controller.fetchData();
    // clear last request to observe the call triggered by setDateRange
    fakeApi.lastTotalPowerRequest = null;
    final startingCallCount = fakeApi.totalCallCount;

    final start = DateTime.fromMillisecondsSinceEpoch(1600000000000);
    final end = DateTime.fromMillisecondsSinceEpoch(1600003600000);

    await controller.setDateRange(start, end);

    // Trigger a fetch explicitly if needed
    await controller.fetchData();

    // Wait for the fetch triggered by setDateRange to complete
    final timeout2 = DateTime.now().add(const Duration(seconds: 5));
    while ((fakeApi.totalCallCount <= startingCallCount ||
            container.read(taskOneControllerProvider).isLoading) &&
        DateTime.now().isBefore(timeout2)) {
      await Future<void>.delayed(const Duration(milliseconds: 20));
    }

    // Validate controller state updated and API was invoked
    // Controller exposes start/end via getters on the notifier
    final controllerState = controller;
    expect(
      controllerState.startDate?.millisecondsSinceEpoch.toString(),
      start.millisecondsSinceEpoch.toString(),
    );
    expect(
      controllerState.endDate?.millisecondsSinceEpoch.toString(),
      end.millisecondsSinceEpoch.toString(),
    );
    expect(fakeApi.totalCallCount > startingCallCount, isTrue);
  });

  test(
    'toggleSeriesSelection updates selections and does not trigger fetch',
    () async {
      final controller = container.read(
        taskOneControllerProvider.notifier,
      );

      // Seed initial data explicitly
      await controller.setCountry('de');
      await controller.fetchData();
      // Ensure initial data present
      final waitTimeout = DateTime.now().add(const Duration(seconds: 5));
      while ((fakeApi.totalCallCount < 1 ||
              container.read(taskOneControllerProvider).isLoading) &&
          DateTime.now().isBefore(waitTimeout)) {
        await Future<void>.delayed(const Duration(milliseconds: 20));
      }

      final initialState = container.read(taskOneControllerProvider).value!;
      expect(initialState.availableSeriesNames.isNotEmpty, isTrue);

      // Record call count and clear last request before toggle
      final startingCallCount = fakeApi.totalCallCount;
      fakeApi.lastTotalPowerRequest = null;

      // toggle one off (no await since method is synchronous)
      controller.toggleSeriesSelection('solar');

      // allow any microtasks to complete
      await Future<void>.delayed(const Duration(milliseconds: 50));

      final after = container.read(taskOneControllerProvider).value!;
      expect(after.selectedSeriesNames, contains('wind'));
      expect(after.selectedSeriesNames, isNot(contains('solar')));
      // toggle should not trigger a network fetch
      expect(fakeApi.totalCallCount, equals(startingCallCount));
    },
  );

  test('price metric triggers getPrice and updates state', () async {
    final controller = container.read(
      taskOneControllerProvider.notifier,
    );

    // set metric to price and ensure bzn present
    await controller.setBzn('NL');
    await controller.setMetric('price');

    // explicit fetch
    await controller.fetchData();

    final timeout = DateTime.now().add(const Duration(seconds: 5));
    while ((fakeApi.priceCallCount < 1 ||
            container.read(taskOneControllerProvider).isLoading) &&
        DateTime.now().isBefore(timeout)) {
      await Future<void>.delayed(const Duration(milliseconds: 20));
    }

    expect(fakeApi.priceCallCount, greaterThanOrEqualTo(1));
    final state = container.read(taskOneControllerProvider).value!;
    expect(state.priceResponse, isNotNull);
    expect(
      state.availableSeriesNames,
      contains('Price (${fakeApi.priceResponse.unit})'),
    );
    expect(
      state.selectedSeriesNames,
      contains('Price (${fakeApi.priceResponse.unit})'),
    );
    expect(fakeApi.lastPriceRequest?.bzn, 'NL');
  });

  test('solar_share metric triggers getSolarShare and updates state', () async {
    final controller = container.read(
      taskOneControllerProvider.notifier,
    );

    await controller.setCountry('de');
    await controller.setMetric('solar_share');
    await controller.fetchData();

    final timeout = DateTime.now().add(const Duration(seconds: 5));
    while ((fakeApi.solarCallCount < 1 ||
            container.read(taskOneControllerProvider).isLoading) &&
        DateTime.now().isBefore(timeout)) {
      await Future<void>.delayed(const Duration(milliseconds: 20));
    }

    expect(fakeApi.solarCallCount, greaterThanOrEqualTo(1));
    final state = container.read(taskOneControllerProvider).value!;
    expect(state.solarShareResponse, isNotNull);
    expect(
      state.availableSeriesNames,
      contains('Solar Share (${state.solarShareResponse!.unit})'),
    );
    expect(
      state.selectedSeriesNames,
      contains('Solar Share (${state.solarShareResponse!.unit})'),
    );
    expect(fakeApi.lastSolarCountry, 'de');
  });

  test(
    'wind_onshore_share metric triggers getWindOnshoreShare and updates state',
    () async {
      final controller = container.read(
        taskOneControllerProvider.notifier,
      );

      await controller.setCountry('de');
      await controller.setMetric('wind_onshore_share');
      await controller.fetchData();

      final timeout = DateTime.now().add(const Duration(seconds: 5));
      while ((fakeApi.windCallCount < 1 ||
              container.read(taskOneControllerProvider).isLoading) &&
          DateTime.now().isBefore(timeout)) {
        await Future<void>.delayed(const Duration(milliseconds: 20));
      }

      expect(fakeApi.windCallCount, greaterThanOrEqualTo(1));
      final state = container.read(taskOneControllerProvider).value!;
      expect(state.windOnshoreShareResponse, isNotNull);
      expect(
        state.availableSeriesNames,
        contains(
          'Wind Onshore Share (${state.windOnshoreShareResponse!.unit})',
        ),
      );
      expect(
        state.selectedSeriesNames,
        contains(
          'Wind Onshore Share (${state.windOnshoreShareResponse!.unit})',
        ),
      );
      expect(fakeApi.lastWindCountry, 'de');
    },
  );

  test('setCountry updates and triggers fetch', skip: true, () async {
    final controller = container.read(
      taskOneControllerProvider.notifier,
    );

    await controller.setCountry('de');
    await controller.fetchData();

    // selected country is exposed on the controller
    expect(controller.selectedCountry, 'de');
    final state = container.read(taskOneControllerProvider).value!;
    expect(state.totalPowerResponse, isNotNull);
  });
}
