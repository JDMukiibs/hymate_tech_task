import 'package:custom_charts/custom_charts.dart';
import 'package:flutter/material.dart';
import 'package:hymate_tech_task/shared/error/custom_error_widget.dart';
import 'package:hymate_tech_task/shared/layout/layout.dart';
import 'package:hymate_tech_task/tasks/tasks.dart';

typedef OnToggleSeries = void Function(String name);

/// Chart area + legend widget extracted from the original view.
/// Delegates retry and series toggles to the parent.
class ChartWithLegend extends StatelessWidget {
  const ChartWithLegend({
    required this.state,
    required this.onToggleSeries,
    required this.onRetry,
    super.key,
  });

  final TaskOneChartState state;
  final OnToggleSeries onToggleSeries;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    if (state.isLoading) {
      return const KeyedSubtree(
        key: ValueKey('loading'),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (state.errorIsNotFound) {
      return CustomErrorWidget(
        message: state.error ?? 'Not found',
        onPressed: () async {
          onRetry.call();
        },
      );
    }

    // Handle price and total_power separately so types are known to the analyzer
    if (state.selectedMetric == 'price') {
      final pResp = state.priceResponse;
      if (pResp == null) {
        return const KeyedSubtree(
          key: ValueKey('empty'),
          child: Center(
            child: Text('No data. Pick a range and press Update Chart.'),
          ),
        );
      }

      final unixSeconds = pResp.unixSeconds;
      final seriesList = <ChartSeries>[];
      final points = <ChartPoint>[];
      for (var j = 0; j < pResp.price.length && j < unixSeconds.length; j++) {
        final seconds = unixSeconds[j];
        final ts = DateTime.fromMillisecondsSinceEpoch(seconds * 1000);
        points.add(ChartPoint(ts, pResp.price[j]));
      }

      seriesList.add(
        ChartSeries(
          points: points,
          color: Colors.primaries[0],
          name: 'Price (${pResp.unit})',
        ),
      );

      final visibleSeries = seriesList
          .where(
            (s) =>
                state.selectedSeriesNames.contains(s.name) ||
                state.selectedMetric == 'price',
          )
          .toList();

      if (visibleSeries.isEmpty) {
        return const KeyedSubtree(
          key: ValueKey('no-series'),
          child: Center(child: Text('No series selected.')),
        );
      }

      return Row(
        children: [
          Expanded(
            child: KeyedSubtree(
              key: ValueKey(
                '${unixSeconds.join(',')}-${state.selectedSeriesNames.join(',')}-${state.selectedMetric}',
              ),
              child: AreaChart(
                series: visibleSeries,
                padding: allPadding36,
              ),
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 150,
            child: Legend(
              allSeries: seriesList,
              selectedNames: state.selectedSeriesNames,
              onToggle: onToggleSeries,
            ),
          ),
        ],
      );
    }

    // total_power branch
    final respTp = state.totalPowerResponse;
    if (respTp == null) {
      return const KeyedSubtree(
        key: ValueKey('empty'),
        child: Center(
          child: Text('No data. Pick a range and press Update Chart.'),
        ),
      );
    }

    final unixSeconds = respTp.unixSeconds;
    final seriesList = <ChartSeries>[];

    for (var i = 0; i < respTp.productionTypes.length; i++) {
      final p = respTp.productionTypes[i];
      final points = <ChartPoint>[];
      for (var j = 0; j < p.data.length && j < unixSeconds.length; j++) {
        final seconds = unixSeconds[j];
        final ts = DateTime.fromMillisecondsSinceEpoch(seconds * 1000);

        /// Assume null data points are zero
        points.add(ChartPoint(ts, p.data[j] ?? 0));
      }

      final color = Colors.primaries[i % Colors.primaries.length];

      seriesList.add(ChartSeries(points: points, color: color, name: p.name));
    }

    final visibleSeries = seriesList
        .where(
          (s) =>
              state.selectedSeriesNames.contains(s.name) ||
              state.selectedMetric == 'price',
        )
        .toList();

    if (visibleSeries.isEmpty) {
      return const KeyedSubtree(
        key: ValueKey('no-series'),
        child: Center(child: Text('No series selected.')),
      );
    }

    return Row(
      children: [
        Expanded(
          child: KeyedSubtree(
            key: ValueKey(
              '${unixSeconds.join(',')}-${state.selectedSeriesNames.join(',')}-${state.selectedMetric}',
            ),
            child: AreaChart(
              series: visibleSeries,
              padding: allPadding36,
            ),
          ),
        ),
        const SizedBox(width: 12),
        SizedBox(
          width: 150,
          child: Legend(
            allSeries: seriesList,
            selectedNames: state.selectedSeriesNames,
            onToggle: onToggleSeries,
          ),
        ),
      ],
    );
  }
}
