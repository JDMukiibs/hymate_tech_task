import 'package:custom_charts/custom_charts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hymate_tech_task/shared/shared.dart';
import 'package:hymate_tech_task/tasks/tasks.dart';

class LegendModal extends ConsumerWidget {
  const LegendModal({
    required this.allSeries,
    super.key,
  });

  final List<ChartSeries> allSeries;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(taskOneControllerProvider).value!;

    return Padding(
      padding: allPadding16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: allSeries.length,
              itemBuilder: (context, index) {
                final series = allSeries[index];
                return LegendItem(
                  series: series,
                  isSelected: state.selectedSeriesNames.contains(series.name),
                  onToggle: () {
                    ref
                        .read(taskOneControllerProvider.notifier)
                        .toggleSeriesSelection(series.name);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
