import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hymate_tech_task/tasks/tasks.dart';

void main() {
  testWidgets('Controls renders and callbacks are invoked', (WidgetTester tester) async {
    final now = DateTime.now();
    var pickRangeCalled = false;
    var setMetricCalled = false;
    var updateCalled = false;
    final toggleCalledWith = <String>[];

    final state = TaskOneChartState.initial().copyWith(
      start: now.subtract(const Duration(days: 1)),
      end: now,
      availableSeriesNames: ['solar', 'wind'],
      selectedSeriesNames: ['solar'],
      selectedMetric: 'total_power',
      selectedBzn: 'NL',
    );

    await tester.pumpWidget(MaterialApp(
      home: Material(
        child: Controls(
          state: state,
          onPickRange: (s, e) async {
            pickRangeCalled = true;
          },
          onSetMetric: (m) async {
            setMetricCalled = true;
          },
          onSetBzn: (b) async {
            // noop in this test
          },
          onUpdateChart: () async {
            updateCalled = true;
          },
          onToggleSeries: toggleCalledWith.add,
        ),
      ),
    ));

    // Verify UI elements
    expect(find.textContaining('Time window:'), findsOneWidget);
    // use contains to avoid trailing-space mismatch
    expect(find.textContaining('Metric'), findsOneWidget);
    expect(find.text('Pick range'), findsOneWidget);
    expect(find.text('Update Chart'), findsOneWidget);
    expect(find.textContaining('Data series'), findsOneWidget);

    // Tap pick range
    await tester.tap(find.text('Pick range'));
    await tester.pumpAndSettle();
    expect(pickRangeCalled, isTrue);

    // Change metric by opening dropdown and selecting 'Price'
    await tester.tap(find.byType(DropdownButton<String>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Price').last);
    await tester.pumpAndSettle();
    // onSetMetric should have been called
    expect(setMetricCalled, isTrue);

    // Tap update
    await tester.tap(find.text('Update Chart'));
    await tester.pumpAndSettle();
    expect(updateCalled, isTrue);

    // Toggle a series chip
    final chip = find.text('wind');
    expect(chip, findsOneWidget);
    await tester.tap(chip);
    await tester.pumpAndSettle();
    expect(toggleCalledWith, isNotEmpty);
  });
}
