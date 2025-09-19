import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:hymate_tech_task/api/models/models.dart';
import 'package:hymate_tech_task/shared/shared.dart';
import 'package:hymate_tech_task/tasks/providers/providers.dart';

class DatapointHierarchyTree extends ConsumerWidget {
  const DatapointHierarchyTree({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hierarchyAsync = ref.watch(asyncTaskTwoNotifierProvider);

    return Padding(
      padding: allPadding16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Datenpunkte',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const Gap(16),

          Expanded(
            child: hierarchyAsync.when(
              data: (state) => ListView.builder(
                itemCount: state.availableDatapointsToPlot.length,
                itemBuilder: (context, index) => _HierarchyNodeWidget(
                  node: state.availableDatapointsToPlot[index],
                  level: 0,
                ),
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error, color: Colors.red, size: 48),
                    const Gap(16),
                    Text('Error loading data: $error'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// TODO(Joshua): Refactor _HierarchyNodeWidget into smaller widgets for DatapointTile and CategoryTile
class _HierarchyNodeWidget extends ConsumerWidget {
  const _HierarchyNodeWidget({
    required this.node,
    required this.level,
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

    if (node.isDatapoint) {
      return _buildDatapointTile(
        context,
        isSelected,
        color,
        () => _toggleSelection(
          ref.read(
            asyncTaskTwoNotifierProvider.notifier,
          ),
        ),
      );
    } else {
      return _buildCategoryTile(
        context,
        isSelected,
        color,
        () => _toggleSelection(
          ref.read(
            asyncTaskTwoNotifierProvider.notifier,
          ),
        ),
      );
    }
  }

  Widget _buildDatapointTile(
    BuildContext context,
    bool isSelected,
    Color color,
    VoidCallback onToggle,
  ) {
    return Padding(
      padding: EdgeInsets.only(left: level * 16.0),
      child: ListTile(
        dense: true,
        leading: CircleAvatar(
          radius: 6,
          backgroundColor: color,
        ),
        title: Text(
          node.name,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        trailing: Checkbox(
          value: isSelected,
          onChanged: (_) => onToggle(),
        ),
        onTap: onToggle,
      ),
    );
  }

  Widget _buildCategoryTile(
    BuildContext context,
    bool isSelected,
    Color color,
    VoidCallback onToggle,
  ) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: Padding(
        padding: EdgeInsets.only(left: level * 16.0),
        child: ExpansionTile(
          leading: Icon(
            Icons.folder,
            color: color,
          ),
          title: Text(
            node.name,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Checkbox(
                value: isSelected,
                onChanged: (_) => onToggle(),
              ),
              if (isSelected) const Icon(Icons.expand_less) else const Icon(Icons.expand_more),
            ],
          ),
          children:
              node.children
                  ?.map(
                    (child) => _HierarchyNodeWidget(
                      node: child,
                      level: level + 1,
                    ),
                  )
                  .toList() ??
              [],
        ),
      ),
    );
  }

  void _toggleSelection(AsyncTaskTwoNotifier notifier) {
    if (node.isDatapoint) {
      notifier.toggleDatapointSelection(node);
    } else {
      notifier.toggleCategorySelection(node);
    }
  }
}
