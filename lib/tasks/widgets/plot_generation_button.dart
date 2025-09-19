import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hymate_tech_task/tasks/providers/providers.dart';

// TODO(Joshua): REwrite as part of datapoint hierarchy tree so that the button uses ReactiveFormConsumer
class PlotGenerationButton extends ConsumerWidget {
  const PlotGenerationButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed:
                ref.read(asyncTaskTwoNotifierProvider.notifier).canGeneratePlot
                ? () async {
                    await ref
                        .read(asyncTaskTwoNotifierProvider.notifier)
                        .generatePlotRequest();
                  }
                : null,
            child: const Text('Plot speichern'),
          ),
        ),
        const SizedBox(width: 8),
        OutlinedButton(
          onPressed: () =>
              ref.read(asyncTaskTwoNotifierProvider.notifier).clearSelections(),
          child: const Text('Clear Selections'),
        ),
      ],
    );
  }
}
