import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hymate_tech_task/api/exceptions/exceptions.dart';
import 'package:hymate_tech_task/l10n/l10n.dart';
import 'package:hymate_tech_task/shared/layout/layout.dart';
import 'package:hymate_tech_task/tasks/tasks.dart';

class TaskOneView extends ConsumerWidget {
  const TaskOneView({super.key});

  String _getFriendlyErrorMessage(BuildContext context, Object? error) {
    if (error is HymateTechTaskNotFoundException) {
      return context.l10n.requestedDataNotFoundMessage;
    } else if (error is HymateTechTaskValidationErrorException) {
      return context.l10n.validationErrorMessage;
    } else if (error is HymateTechTaskException) {
      return context.l10n.serverErrorMessage;
    } else if (error is Exception) {
      return context.l10n.unexpectedErrorMessage;
    }
    return context.l10n.unknownErrorMessage;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(taskOneControllerProvider);
    final controller = ref.read(taskOneControllerProvider.notifier);

    // Listen for errors and show SnackBar
    ref.listen<AsyncValue<TaskOneChartState>>(
      taskOneControllerProvider,
      (previous, next) {
        next.whenOrNull(
          error: (error, stackTrace) {
            final messenger = ScaffoldMessenger.of(context);
            messenger.clearSnackBars();
            messenger.showSnackBar(
              SnackBar(content: Text(_getFriendlyErrorMessage(context, error))),
            );
          },
        );
      },
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Controls(),
        Expanded(
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Padding(
              padding: allPadding8,
              child: state.when(
                data: (chartState) => ChartWithLegend(
                  state: chartState,
                  selectedMetric: controller.selectedMetric,
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stackTrace) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error, size: 48, color: Colors.red),
                      const SizedBox(height: 16),
                      Text(_getFriendlyErrorMessage(context, error)),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: controller.fetchData,
                        child: Text(context.l10n.retryButtonText),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
