import 'package:custom_charts/custom_charts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hymate_tech_task/tasks/widgets/legend.dart';

void main() {
  testWidgets('Legend renders series and toggles checkbox', (
    WidgetTester tester,
  ) async {
    final toggled = <String>[];

    final series = [
      ChartSeries(
        points: [ChartPoint(DateTime.now(), 1)],
        color: Colors.red,
        name: 'solar',
      ),
      ChartSeries(
        points: [ChartPoint(DateTime.now(), 2)],
        color: Colors.blue,
        name: 'wind',
      ),
    ];

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Legend(
            allSeries: series,
            selectedNames: const ['solar'],
            onToggle: toggled.add,
          ),
        ),
      ),
    );

    expect(find.text('solar'), findsOneWidget);
    expect(find.text('wind'), findsOneWidget);

    // Tap the checkbox for 'wind' (there are two checkboxes; tapping the second should toggle 'wind')
    final checkboxes = find.byType(Checkbox);
    expect(checkboxes, findsNWidgets(2));

    await tester.tap(checkboxes.at(1));
    await tester.pumpAndSettle();

    expect(toggled, contains('wind'));
  });
}
