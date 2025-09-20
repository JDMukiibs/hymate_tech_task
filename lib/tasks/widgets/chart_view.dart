import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:hymate_tech_task/l10n/l10n.dart';
import 'package:hymate_tech_task/shared/shared.dart';
import 'package:hymate_tech_task/tasks/providers/providers.dart';

class ChartView extends ConsumerWidget {
  const ChartView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskTwoState = ref.watch(asyncTaskTwoNotifierProvider);

    return Padding(
      padding: allPadding16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.generatedPlotRequestTitle,
            style: context.theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const Gap(16),
          Expanded(
            child: taskTwoState.when(
              data: (state) {
                if (state.generatedPlotRequest != null) {
                  return SingleChildScrollView(
                    child: SelectableText(
                      state.generatedPlotRequest.toString(),
                      style: context.theme.textTheme.bodyMedium?.copyWith(
                        fontFamily: 'monospace',
                        fontSize: 12,
                      ),
                    ),
                  );
                } else {
                  return Center(
                    child: Text(
                      context.l10n.noPlotGeneratedMessage,
                      style: const TextStyle(fontStyle: FontStyle.italic),
                      textAlign: TextAlign.center,
                    ),
                  );
                }
              },
              error: (err, _) => CustomErrorWidget(
                message: context.l10n.errorGeneratingPlotMessage(err.toString()),
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
            ),
          ),
        ],
      ),
    );
  }
}
