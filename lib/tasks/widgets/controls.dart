import 'package:flutter/material.dart';
import 'package:hymate_tech_task/shared/layout/layout.dart';
import 'package:hymate_tech_task/tasks/providers/task_one_chart_state.dart';

/// Controls section for Task One charting. This is a pure widget that takes
/// the current [state] and a set of callbacks used by the original controller.
class Controls extends StatelessWidget {
  const Controls({
    required this.state,
    required this.onPickRange,
    required this.onSetMetric,
    required this.onSetBzn,
    required this.onUpdateChart,
    required this.onToggleSeries,
    super.key,
  });

  final TaskOneChartState state;
  final Future<void> Function(DateTime? start, DateTime? end) onPickRange;
  final Future<void> Function(String metric) onSetMetric;
  final Future<void> Function(String bzn) onSetBzn;
  final Future<void> Function() onUpdateChart;
  final void Function(String name) onToggleSeries;

  static const _bznOptions = <String>[
    'AT',
    'BE',
    'CH',
    'CZ',
    'DE-LU',
    'DE-AT-LU',
    'DK1',
    'DK2',
    'FR',
    'HU',
    'IT-North',
    'NL',
    'NO2',
    'PL',
    'SE4',
    'SI',
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: allPadding12,
      child: Padding(
        padding: allPadding12,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Time window: ${state.start != null ? _fmtDate(state.start!) : '—'} → ${state.end != null ? _fmtDate(state.end!) : '—'}',
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    // delegate to caller
                    await onPickRange(state.start, state.end);
                  },
                  child: const Text('Pick range'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: state.isLoading
                      ? null
                      : () async => onUpdateChart(),
                  child: const Text('Update Chart'),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                const Text('Metric: '),
                const SizedBox(width: 8),
                DropdownButton<String>(
                  value: state.selectedMetric,
                  items: const [
                    DropdownMenuItem(
                      value: 'total_power',
                      child: Text('Total power'),
                    ),
                    DropdownMenuItem(value: 'price', child: Text('Price')),
                  ],
                  onChanged: (v) async {
                    if (v == null) return;
                    await onSetMetric(v);
                  },
                ),
                const SizedBox(width: 16),
                if (state.selectedMetric == 'price') ...[
                  const Text('BZN: '),
                  const SizedBox(width: 8),
                  DropdownButton<String>(
                    value: state.selectedBzn,
                    items: _bznOptions
                        .map((b) => DropdownMenuItem(value: b, child: Text(b)))
                        .toList(),
                    onChanged: (v) async {
                      if (v == null) return;
                      await onSetBzn(v);
                    },
                  ),
                ],
              ],
            ),

            const SizedBox(height: 12),

            Text('Data series', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            if (state.availableSeriesNames.isNotEmpty)
              SizedBox(
                height: 120,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: state.availableSeriesNames.map<Widget>((
                    String name,
                  ) {
                    final selected = state.selectedSeriesNames.contains(name);
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FilterChip(
                        label: Text(name),
                        selected: selected,
                        onSelected: (_) => onToggleSeries(name),
                      ),
                    );
                  }).toList(),
                ),
              ),

            if (state.error != null) ...[
              const SizedBox(height: 8),
              Text(state.error!, style: const TextStyle(color: Colors.red)),
            ],
          ],
        ),
      ),
    );
  }

  String _fmtDate(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
}
