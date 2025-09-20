import 'package:custom_charts/custom_charts.dart';
import 'package:flutter/material.dart';
import 'package:hymate_tech_task/shared/extensions/extensions.dart';

class LegendItem extends StatelessWidget {
  const LegendItem({
    required this.series,
    required this.isSelected,
    required this.onToggle,
    super.key,
  });

  final ChartSeries series;
  final bool isSelected;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 4,
      ),
      leading: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 16,
        height: 16,
        decoration: BoxDecoration(
          color: isSelected
              ? series.color
              : series.color.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: series.color,
            width: isSelected ? 2 : 1,
          ),
        ),
      ),
      title: Text(
        series.name,
        style: TextStyle(
          fontSize: 12,
          color: isSelected
              ? context.theme.textTheme.bodyLarge?.color
              : Theme.of(
                  context,
                ).textTheme.bodyLarge?.color?.withValues(alpha: 0.6),
          fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Checkbox(
        value: isSelected,
        onChanged: (_) => onToggle(),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      onTap: onToggle,
    );
  }
}
