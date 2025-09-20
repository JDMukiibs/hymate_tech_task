import 'package:custom_charts/custom_charts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hymate_tech_task/l10n/l10n.dart';
import 'package:hymate_tech_task/shared/shared.dart';
import 'package:hymate_tech_task/tasks/tasks.dart';

class ChartDisplay extends ConsumerWidget {
  const ChartDisplay({
    required this.series,
    required this.allSeries,
    required this.selectedNames,
    required this.dataKey,
    super.key,
  });

  final List<ChartSeries> series;
  final List<ChartSeries> allSeries;
  final List<String> selectedNames;
  final String dataKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Expanded(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: AreaChart(
              key: ValueKey('$dataKey-${selectedNames.join(',')}'),
              series: series,
              padding: allPadding36,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton.icon(
              onPressed: () {
                showGenericDialog<bool>(
                  context: context,
                  title: context.l10n.chartLegendTitle,
                  content: '',
                  contentWidgetOverride: SizedBox(
                    width: context.mediaQuery.size.width * 0.8,
                    height: context.mediaQuery.size.height * 0.8,
                    child: LegendModal(allSeries: allSeries),
                  ),
                  optionsBuilder: () => {
                    context.l10n.closeButtonText: true,
                  },
                );
              },
              icon: const Icon(Icons.legend_toggle),
              label: Text(context.l10n.showLegendLabel),
            ),
          ),
        ),
      ],
    );
  }
}
