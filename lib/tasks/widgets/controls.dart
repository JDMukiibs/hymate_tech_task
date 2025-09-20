import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:hymate_tech_task/l10n/l10n.dart';
import 'package:hymate_tech_task/shared/shared.dart';
import 'package:hymate_tech_task/tasks/tasks.dart';
import 'package:reactive_date_time_picker/reactive_date_time_picker.dart';
import 'package:reactive_forms/reactive_forms.dart';

class Controls extends ConsumerWidget {
  const Controls({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(taskOneControllerProvider);

    /// Watching to rebuild when selectedMetric changes as some metrics don't need some inputs
    final selectedMetric = ref.watch(
      taskOneControllerProvider.notifier.select(
        (notifier) => notifier.selectedMetric,
      ),
    );

    final showDatePickers =
        selectedMetric != 'solar_share' &&
        selectedMetric != 'wind_onshore_share';

    return Card(
      margin: allPadding12,
      child: Padding(
        padding: allPadding12,
        child: ReactiveFormBuilder(
          form: () => ref.read(taskOneControllerProvider.notifier).formGroup,
          builder: (context, form, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (showDatePickers) ...[
                  Row(
                    children: [
                      Expanded(
                        child: ReactiveDateTimePicker(
                          type: ReactiveDatePickerFieldType.dateTime,
                          formControlName: 'startDate',
                          decoration: InputDecoration(
                            labelText: context.l10n.startDateLabel,
                            border: const OutlineInputBorder(),
                            suffixIcon: const Icon(Icons.calendar_today),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ReactiveDateTimePicker(
                          type: ReactiveDatePickerFieldType.dateTime,
                          formControlName: 'endDate',
                          decoration: InputDecoration(
                            labelText: context.l10n.endDateLabel,
                            border: const OutlineInputBorder(),
                            suffixIcon: const Icon(Icons.calendar_today),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Gap(16),
                ],
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 60,
                              child: Text(
                                context.l10n.selectMetricsLabel,
                                style: const TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: ReactiveDropdownField<String>(
                                formControlName: 'metric',
                                items: TaskConstants.task1Metrics.entries
                                    .map(
                                      (entry) => DropdownMenuItem<String>(
                                        value: entry.key,
                                        child: Text(entry.value),
                                      ),
                                    )
                                    .toList(),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      horizontalMargin24,
                      Expanded(
                        flex: 3,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 70,
                              child: Text(
                                ref
                                            .read(
                                              taskOneControllerProvider
                                                  .notifier,
                                            )
                                            .selectedMetric ==
                                        'price'
                                    ? context.l10n.biddingZonesLabel
                                    : context.l10n.countriesLabel,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            verticalMargin8,
                            Expanded(
                              child:
                                  ref
                                          .read(
                                            taskOneControllerProvider.notifier,
                                          )
                                          .selectedMetric ==
                                      'price'
                                  ? ReactiveDropdownField<String>(
                                      formControlName: 'bzn',
                                      items: TaskConstants
                                          .availableBiddingZones
                                          .entries
                                          .map(
                                            (entry) => DropdownMenuItem<String>(
                                              value: entry.key,
                                              child: Text(entry.value),
                                            ),
                                          )
                                          .toList(),
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 8,
                                        ),
                                      ),
                                    )
                                  : ReactiveDropdownField<String>(
                                      formControlName: 'country',
                                      items: TaskConstants
                                          .availableCountries
                                          .entries
                                          .map(
                                            (entry) => DropdownMenuItem<String>(
                                              value: entry.key,
                                              child: Text(entry.value),
                                            ),
                                          )
                                          .toList(),
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 8,
                                        ),
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
                      horizontalMargin24,
                      ReactiveFormConsumer(
                        builder: (context, formGroup, consumerChild) {
                          final isFormValid = formGroup.valid;
                          final hasValidDateRange = _hasValidDateRange(
                            formGroup,
                          );
                          final isDateRangeValidForMetric = showDatePickers
                              ? hasValidDateRange
                              : true;
                          final canFetch =
                              isFormValid &&
                              isDateRangeValidForMetric &&
                              !state.isLoading;

                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: canFetch
                                    ? ref
                                          .read(
                                            taskOneControllerProvider.notifier,
                                          )
                                          .fetchData
                                    : null,
                                child: state.isLoading
                                    ? const SizedBox(
                                        width: 16,
                                        height: 16,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : Text(context.l10n.fetchDataButtonLabel),
                              ),
                              if (!isFormValid && formGroup.touched)
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Text(
                                    context.l10n.invalidFormMessage,
                                    style: TextStyle(
                                      color: context.theme.colorScheme.error,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              if (showDatePickers && !hasValidDateRange)
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Text(
                                    context.l10n.invalidDateRangeMessage,
                                    style: TextStyle(
                                      color: context.theme.colorScheme.error,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const Gap(16),
                if (state.hasValue &&
                    state.value!.availableSeriesNames.isNotEmpty) ...[
                  Text(
                    context.l10n.dataSeriesLabel,
                    style: context.theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 120,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: state.value!.availableSeriesNames.map<Widget>((
                        name,
                      ) {
                        final selected = ref
                            .read(taskOneControllerProvider.notifier)
                            .isSeriesSelected(name);
                        return Padding(
                          padding: rightPadding8,
                          child: FilterChip(
                            label: Text(
                              name,
                              style: TextStyle(
                                color: selected
                                    ? context.theme.colorScheme.onSecondary
                                    : context.theme.colorScheme.onSurface,
                              ),
                            ),
                            selected: selected,
                            onSelected: (_) => ref
                                .read(taskOneControllerProvider.notifier)
                                .toggleSeriesSelection(name),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }

  bool _hasValidDateRange(FormGroup formGroup) {
    final start = formGroup.control('startDate').value as DateTime?;
    final end = formGroup.control('endDate').value as DateTime?;
    return start == null || end == null || start.isBefore(end);
  }
}
