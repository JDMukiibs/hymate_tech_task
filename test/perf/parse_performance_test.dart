import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:hymate_tech_task/api/models/models.dart';

void main() {
  // Utility to compute median and average
  int median(List<int> arr) {
    final sorted = List<int>.from(arr)..sort();
    return sorted[sorted.length ~/ 2];
  }

  double average(List<int> arr) => arr.reduce((a, b) => a + b) / arr.length;

  // Helper to format microsecond timings to human-friendly ms or s strings
  String formatMicros(int micros) {
    final ms = micros / 1000.0;
    if (ms >= 1000) {
      final s = ms / 1000.0;
      return '${s.toStringAsFixed(3)} s';
    }
    return '${ms.toStringAsFixed(1)} ms';
  }

  // Helper to build a deeply nested JSON (single chain) of given depth.
  // Use iterative wrapping to avoid Dart recursion stack overflow when constructing large depths.
  Map<String, dynamic> buildDepthJson(int depth) {
    var node = <String, dynamic>{'name': 'leaf', 'id': 'leaf_id'};
    for (var i = 1; i <= depth; i++) {
      node = {
        'name': 'node_$i',
        'children': [node],
      };
    }
    return {
      'datapoints': [node],
    };
  }

  // Helper to build a wide JSON with branching factor `width` and levels `levels`.
  // This creates a root with `width` children each of which has `levels-1` nested children
  Map<String, dynamic> buildWidthJson(int width, int levels) {
    Map<String, dynamic> deep(int lvl) {
      if (lvl <= 1) {
        return {'name': 'leaf', 'id': 'leaf_id'};
      }
      return {
        'name': 'node_$lvl',
        'children': [deep(lvl - 1)],
      };
    }

    final children = List.generate(width, (_) => deep(levels));
    return {
      'datapoints': [
        {'name': 'root', 'children': children},
      ],
    };
  }

  test('parse depth performance (warm-up + decode/fromJson timings)', () async {
    // Use safe depth values to avoid encoder/decoder stack issues on some platforms
    final depths = [100, 500, 1000];
    const warmupRuns = 3;
    const iterations =
        12; // moderate iterations to balance runtime and stability

    for (final d in depths) {
      final jsonStr = jsonEncode(buildDepthJson(d));

      // Warm-up
      for (var w = 0; w < warmupRuns; w++) {
        final decoded = jsonDecode(jsonStr) as Map<String, dynamic>;
        final topList = decoded['datapoints'] as List<dynamic>;
        DatapointHierarchyNode.fromJson(topList.first as Map<String, dynamic>);
      }

      final decodeTimes = <int>[];
      final fromJsonTimes = <int>[];

      for (var i = 0; i < iterations; i++) {
        final decodeWatch = Stopwatch()..start();
        final decoded = jsonDecode(jsonStr) as Map<String, dynamic>;
        decodeWatch.stop();
        decodeTimes.add(decodeWatch.elapsedMicroseconds);

        final topList = decoded['datapoints'] as List<dynamic>;
        final mapForFrom = topList.first as Map<String, dynamic>;

        final fromWatch = Stopwatch()..start();
        final root = DatapointHierarchyNode.fromJson(mapForFrom);
        fromWatch.stop();
        fromJsonTimes.add(fromWatch.elapsedMicroseconds);

        // verify depth
        int countDepth(DatapointHierarchyNode node) {
          if (node.children == null || node.children!.isEmpty) return 0;
          return 1 + countDepth(node.children!.first);
        }

        final parsedDepth = countDepth(root);
        expect(parsedDepth, d);
      }

      print(
        'Depth $d decode µs median=${median(decodeTimes)} avg=${average(decodeTimes).toStringAsFixed(1)}',
      );
      // Print both median/avg in human friendly units
      print(
        'Depth $d decode median=${formatMicros(median(decodeTimes))} avg=${formatMicros(average(decodeTimes).round())}',
      );
      print(
        'Depth $d fromJson median=${formatMicros(median(fromJsonTimes))} avg=${formatMicros(average(fromJsonTimes).round())}',
      );

      expect(decodeTimes, isNotEmpty);
      expect(fromJsonTimes, isNotEmpty);
    }
  });

  test('parse width performance (warm-up + decode/fromJson timings)', () async {
    // width = number of siblings at root level
    final widths = [50, 200, 800];
    const levels = 3; // small depth to emphasize width
    const warmupRuns = 3;
    const iterations = 12;

    for (final w in widths) {
      final jsonStr = jsonEncode(buildWidthJson(w, levels));

      // Warm-up
      for (var wk = 0; wk < warmupRuns; wk++) {
        final decoded = jsonDecode(jsonStr) as Map<String, dynamic>;
        final topList = decoded['datapoints'] as List<dynamic>;
        DatapointHierarchyNode.fromJson(topList.first as Map<String, dynamic>);
      }

      final decodeTimes = <int>[];
      final fromJsonTimes = <int>[];

      for (var i = 0; i < iterations; i++) {
        final decodeWatch = Stopwatch()..start();
        final decoded = jsonDecode(jsonStr) as Map<String, dynamic>;
        decodeWatch.stop();
        decodeTimes.add(decodeWatch.elapsedMicroseconds);

        final topList = decoded['datapoints'] as List<dynamic>;
        final mapForFrom = topList.first as Map<String, dynamic>;

        final fromWatch = Stopwatch()..start();
        final root = DatapointHierarchyNode.fromJson(mapForFrom);
        fromWatch.stop();
        fromJsonTimes.add(fromWatch.elapsedMicroseconds);

        // verify structure: number of children at root equals width
        expect(root.children?.length ?? 0, w);
      }

      print(
        'Width $w decode µs median=${median(decodeTimes)} avg=${average(decodeTimes).toStringAsFixed(1)}',
      );
      print(
        'Width $w decode median=${formatMicros(median(decodeTimes))} avg=${formatMicros(average(decodeTimes).round())}',
      );
      print(
        'Width $w fromJson median=${formatMicros(median(fromJsonTimes))} avg=${formatMicros(average(fromJsonTimes).round())}',
      );

      expect(decodeTimes, isNotEmpty);
      expect(fromJsonTimes, isNotEmpty);
    }
  });
}
