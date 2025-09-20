import 'package:custom_charts/custom_charts.dart';
import 'package:flutter/material.dart';
import 'package:hymate_tech_task/shared/extensions/extensions.dart';

/// Vertical legend used alongside the chart
class Legend extends StatelessWidget {
  const Legend({
    required this.allSeries,
    required this.selectedNames,
    required this.onToggle,
    super.key,
  });

  final List<ChartSeries> allSeries;
  final List<String> selectedNames;
  final void Function(String name) onToggle;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: allSeries.map((s) {
        final selected = selectedNames.contains(s.name);
        return ListTile(
          dense: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 4,
            vertical: 2,
          ),
          leading: Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: s.color,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          title: Text(
            s.name,
            style: TextStyle(
              fontSize: 12,
              color: context.theme.textTheme.bodyLarge?.color,
            ),
          ),
          trailing: Checkbox(
            value: selected,
            onChanged: (_) => onToggle(s.name),
          ),
        );
      }).toList(),
    );
  }
}
