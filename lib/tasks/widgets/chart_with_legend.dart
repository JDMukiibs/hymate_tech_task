import 'dart:math' as math;

import 'package:custom_charts/custom_charts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hymate_tech_task/api/models/models.dart';
import 'package:hymate_tech_task/tasks/tasks.dart';

class ChartWithLegend extends ConsumerWidget {
  const ChartWithLegend({
    required this.state,
    required this.selectedMetric,
    super.key,
  });

  final TaskOneChartState state;
  final String selectedMetric;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!_hasAnyData()) {
      return const EmptyChartState();
    }

    // Check for specific renewable data issues
    if (selectedMetric == 'solar_share' &&
        state.solarShareResponse != null &&
        !_hasValidRenewableData(state.solarShareResponse!)) {
      return const NoValidRenewableDataWidget(metricName: 'Solar Share');
    }

    if (selectedMetric == 'wind_onshore_share' &&
        state.windOnshoreShareResponse != null &&
        !_hasValidRenewableData(state.windOnshoreShareResponse!)) {
      return const NoValidRenewableDataWidget(metricName: 'Wind Onshore Share');
    }

    final seriesList = _buildSeriesList();

    if (seriesList.isEmpty) {
      return const NoDataAvailableWidget();
    }

    final visibleSeries = _getVisibleSeries(seriesList);

    if (visibleSeries.isEmpty) {
      return const NoSeriesSelectedWidget();
    }

    return ChartDisplay(
      series: visibleSeries,
      allSeries: seriesList,
      selectedNames: state.selectedSeriesNames,
      dataKey: _getDataKey(),
    );
  }

  bool _hasValidRenewableData(RenewableShareResponse response) {
    return response.data.any((value) => value != null && value > 0);
  }

  bool _hasAnyData() {
    return state.totalPowerResponse != null ||
        state.priceResponse != null ||
        state.solarShareResponse != null ||
        state.windOnshoreShareResponse != null;
  }

  List<ChartSeries> _buildSeriesList() {
    final seriesList = <ChartSeries>[];

    final totalPowerResp = state.totalPowerResponse;
    if (totalPowerResp != null) {
      seriesList.addAll(_buildTotalPowerSeries(totalPowerResp));
    }

    final priceResp = state.priceResponse;
    if (priceResp != null) {
      seriesList.addAll(_buildPriceSeries(priceResp));
    }

    final solarShareResp = state.solarShareResponse;
    if (solarShareResp != null && _hasValidRenewableData(solarShareResp)) {
      seriesList.addAll(
        _buildRenewableSeries(
          solarShareResp,
          'Solar Share',
        ),
      );
    }

    final windOnshoreShareResp = state.windOnshoreShareResponse;
    if (windOnshoreShareResp != null &&
        _hasValidRenewableData(windOnshoreShareResp)) {
      seriesList.addAll(
        _buildRenewableSeries(
          windOnshoreShareResp,
          'Wind Onshore Share',
        ),
      );
    }

    return seriesList;
  }

  List<ChartSeries> _buildTotalPowerSeries(TotalPowerResponse response) {
    final seriesList = <ChartSeries>[];
    final unixSeconds = response.unixSeconds;

    for (var i = 0; i < response.productionTypes.length; i++) {
      final productionType = response.productionTypes[i];
      final points = <ChartPoint>[];

      for (
        var j = 0;
        j < productionType.data.length && j < unixSeconds.length;
        j++
      ) {
        final seconds = unixSeconds[j];
        final timestamp = DateTime.fromMillisecondsSinceEpoch(seconds * 1000);
        final value = productionType.data[j] ?? 0;
        points.add(ChartPoint(timestamp, value));
      }

      final color =
          state.assignedColors[productionType.name] ??
          Colors.primaries[i % Colors.primaries.length];

      seriesList.add(
        ChartSeries(
          points: points,
          color: color,
          name: productionType.name,
        ),
      );
    }

    return seriesList;
  }

  List<ChartSeries> _buildPriceSeries(PriceResponse response) {
    final points = <ChartPoint>[];
    final unixSeconds = response.unixSeconds;

    for (var j = 0; j < response.price.length && j < unixSeconds.length; j++) {
      final seconds = unixSeconds[j];
      final timestamp = DateTime.fromMillisecondsSinceEpoch(seconds * 1000);
      points.add(ChartPoint(timestamp, response.price[j]));
    }

    final seriesName = 'Price (${response.unit})';
    final color = state.assignedColors[seriesName] ?? Colors.blue;

    return [
      ChartSeries(
        points: points,
        color: color,
        name: seriesName,
      ),
    ];
  }

  List<ChartSeries> _buildRenewableSeries(
    RenewableShareResponse response,
    String baseName,
  ) {
    final points = <ChartPoint>[];
    final unixSeconds = response.unixSeconds;

    // Use the shorter of the two arrays to prevent index out of bounds
    final dataLength = math.min(response.data.length, unixSeconds.length);

    for (var j = 0; j < dataLength; j++) {
      final seconds = unixSeconds[j];
      final timestamp = DateTime.fromMillisecondsSinceEpoch(seconds * 1000);
      final value =
          response.data[j] ?? 0.0; // Handle null values by treating as 0
      points.add(ChartPoint(timestamp, value));
    }

    final seriesNameWithUnit = '$baseName (${response.unit})';
    final color = state.assignedColors[seriesNameWithUnit] ??
        (baseName.contains('Solar') ? Colors.orange : Colors.green);

    return [
      ChartSeries(
        points: points,
        color: color,
        name: baseName,
      ),
    ];
  }

  List<ChartSeries> _getVisibleSeries(List<ChartSeries> allSeries) {
    return allSeries
        .where((series) => state.selectedSeriesNames.contains(series.name))
        .toList();
  }

  String _getDataKey() {
    final keys = <String>[];

    if (state.totalPowerResponse != null) {
      keys.add(state.totalPowerResponse!.unixSeconds.join(','));
    }
    if (state.priceResponse != null) {
      keys.add(state.priceResponse!.unixSeconds.join(','));
    }
    if (state.solarShareResponse != null) {
      keys.add(state.solarShareResponse!.unixSeconds.join(','));
    }
    if (state.windOnshoreShareResponse != null) {
      keys.add(state.windOnshoreShareResponse!.unixSeconds.join(','));
    }

    return keys.join('|');
  }
}
