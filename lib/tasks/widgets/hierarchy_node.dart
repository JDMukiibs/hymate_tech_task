import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hymate_tech_task/api/models/models.dart';
import 'package:hymate_tech_task/tasks/providers/providers.dart';
import 'package:hymate_tech_task/tasks/widgets/widgets.dart';

class HierarchyNode extends ConsumerWidget {
  const HierarchyNode({
    required this.node,
    required this.level,
    super.key,
  });

  final DatapointHierarchyNode node;
  final int level;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSelected = node.isDatapoint
        ? ref.watch(
            asyncTaskTwoNotifierProvider.select(
              (s) =>
                  s.value?.selectedDatapoints.any(
                    (item) => item.id == node.id,
                  ) ??
                  false,
            ),
          )
        : ref.watch(
            asyncTaskTwoNotifierProvider.select(
              (s) =>
                  s.value?.selectedCategories.any(
                    (item) => item.name == node.name,
                  ) ??
                  false,
            ),
          );

    final assignedColors =
        ref.watch(
          asyncTaskTwoNotifierProvider.select((s) => s.value?.assignedColors),
        ) ??
        {};

    final identifier = node.isDatapoint ? node.id : node.name;
    final color = assignedColors[identifier] ?? Colors.grey;

    void onToggle() {
      if (node.isDatapoint) {
        ref.read(asyncTaskTwoNotifierProvider.notifier).toggleDatapointSelection(node);
      } else {
        ref.read(asyncTaskTwoNotifierProvider.notifier).toggleCategorySelection(node);
      }
    }

    if (node.isDatapoint) {
      return DatapointTile(
        node: node,
        level: level,
        isSelected: isSelected,
        color: color,
        onToggle: onToggle,
      );
    } else {
      return CategoryTile(
        node: node,
        level: level,
        isSelected: isSelected,
        color: color,
        onToggle: onToggle,
      );
    }
  }
}
