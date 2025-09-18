import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hymate_tech_task/shared/layout/layout.dart';
import 'package:hymate_tech_task/tasks/tasks.dart';

// TODO(Joshua): Refactor this widget to separate the controller logic from the UI and use ReactiveForms for the controls.
/// A reusable Task One view that shows controls and a line/area chart in the
/// hymate style. It accepts a default [country] used when fetching data.
class TaskOneView extends ConsumerWidget {
  const TaskOneView({
    super.key,
    this.country = 'de',
  });

  final String country;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(taskOneControllerProvider);
    final controller = ref.read(
      taskOneControllerProvider.notifier,
    );

    // Listen for errors and show a SnackBar when they occur
    ref.listen<TaskOneChartState>(taskOneControllerProvider, (previous, next) {
      if (next.error != null && next.error != previous?.error) {
        final messenger = ScaffoldMessenger.of(context);
        messenger.clearSnackBars();
        messenger.showSnackBar(SnackBar(content: Text(next.error!)));
      }
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Controls(
          state: state,
          onPickRange: (start, end) async {
            final picked = await showDateRangePicker(
              context: context,
              firstDate: DateTime(2000),
              lastDate: DateTime.now().add(const Duration(days: 1)),
            );

            if (picked != null) {
              await controller.setTimeWindow(picked.start, picked.end);
            }
          },
          onSetMetric: (metric) async => controller.setMetric(metric),
          onSetBzn: (bzn) async => controller.setBzn(bzn),
          onUpdateChart: () async {
            if (state.selectedMetric == 'price') {
              await controller.fetchPrice(bzn: state.selectedBzn);
            } else {
              await controller.fetchData(country: country);
            }
          },
          onToggleSeries: controller.toggleSeriesSelection,
        ),

        // Chart area with animated transitions
        Expanded(
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Padding(
              padding: allPadding8,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 600),
                switchInCurve: Curves.easeOutCubic,
                switchOutCurve: Curves.easeInCubic,
                transitionBuilder: (child, animation) =>
                    FadeTransition(opacity: animation, child: child),
                child: ChartWithLegend(
                  state: state,
                  onToggleSeries: controller.toggleSeriesSelection,
                  onRetry: () async {
                    if (state.selectedMetric == 'price') {
                      await controller.fetchPrice(bzn: state.selectedBzn);
                    } else {
                      await controller.fetchData(
                        country: state.selectedCountry,
                      );
                    }
                  },
                ),
                layoutBuilder: (currentChild, previousChildren) {
                  return Stack(
                    children: [
                      ...previousChildren,
                      if (currentChild != null) currentChild,
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
