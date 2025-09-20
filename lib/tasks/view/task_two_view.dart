import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:hymate_tech_task/l10n/l10n.dart';
import 'package:hymate_tech_task/shared/shared.dart';
import 'package:hymate_tech_task/tasks/providers/providers.dart';
import 'package:hymate_tech_task/tasks/widgets/widgets.dart';
import 'package:reactive_forms/reactive_forms.dart';

class TaskTwoView extends ConsumerWidget {
  const TaskTwoView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncTaskTwoNotifierState = ref.watch(asyncTaskTwoNotifierProvider);

    return ReactiveForm(
      formGroup: ref.read(asyncTaskTwoNotifierProvider.notifier).formGroup,
      child: Column(
        children: [
          const Expanded(
            child: Row(
              children: [
                Expanded(child: ChartView()),
                VerticalDivider(width: 1),
                Expanded(child: DatapointHierarchyTree()),
              ],
            ),
          ),
          const Divider(height: 1),
          Container(
            padding: allPadding16,
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ReactiveFormConsumer(
                  builder: (context, formGroup, consumerChild) {
                    final canGenerate = ref
                        .read(asyncTaskTwoNotifierProvider.notifier)
                        .canGeneratePlot;
                    final isLoading = asyncTaskTwoNotifierState.isLoading;

                    return Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: canGenerate && !isLoading
                                ? () async {
                                    await ref
                                        .read(
                                          asyncTaskTwoNotifierProvider.notifier,
                                        )
                                        .generatePlotRequest();
                                  }
                                : null,
                            child: isLoading
                                ? const SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text(context.l10n.generatePlotButtonLabel),
                          ),
                        ),
                        const Gap(8),
                        OutlinedButton(
                          onPressed: isLoading
                              ? null
                              : () => ref
                                    .read(asyncTaskTwoNotifierProvider.notifier)
                                    .clearSelections(),
                          child: Text(context.l10n.clearSelectionsButtonText),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
