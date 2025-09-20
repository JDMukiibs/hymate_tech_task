import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:hymate_tech_task/l10n/l10n.dart';
import 'package:hymate_tech_task/shared/shared.dart';
import 'package:hymate_tech_task/tasks/providers/providers.dart';
import 'package:hymate_tech_task/tasks/widgets/widgets.dart';

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
            context.l10n.datapointsLabel,
            style: context.theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const Gap(16),

          Expanded(
            child: hierarchyAsync.when(
              data: (state) => ListView.builder(
                itemCount: state.availableDatapointsToPlot.length,
                itemBuilder: (context, index) => HierarchyNode(
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
                    Text(context.l10n.errorLoadingDataMessage(error.toString())),
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
