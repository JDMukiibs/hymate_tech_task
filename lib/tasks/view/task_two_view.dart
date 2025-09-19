import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:hymate_tech_task/shared/shared.dart';
import 'package:hymate_tech_task/tasks/providers/providers.dart';
import 'package:hymate_tech_task/tasks/widgets/widgets.dart';

class TaskTwoView extends ConsumerWidget {
  const TaskTwoView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncTaskTwoNotifierState = ref.watch(asyncTaskTwoNotifierProvider);
    return Row(
      children: [
        const Expanded(child: ChartView()),
        const VerticalDivider(width: 1),
        const Expanded(child: DatapointHierarchyTree()),
        const Divider(height: 1),
        Container(
          padding: allPadding8,
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const PlotGenerationButton(),
              const Gap(8),
              asyncTaskTwoNotifierState.when(
                loading: () => const LinearProgressIndicator(),
                error: (err, _) => Text(
                  'Error: $err',
                  style: context.theme.textTheme.bodySmall?.copyWith(
                    color: Colors.red,
                  ),
                ),
                data: (state) {
                  if (ref
                      .read(asyncTaskTwoNotifierProvider.notifier)
                      .hasPlotRequest) {
                    return Text(
                      'Generated Plot Request JSON:\n${state.generatedPlotRequest}',
                      style: context.theme.textTheme.bodySmall,
                    );
                  } else {
                    return const Text(
                      'No plot generated yet.',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
