import 'package:flutter/material.dart';

class ChartPoint {
  const ChartPoint(this.timestamp, this.value);

  final DateTime timestamp;
  final double value;
}

class ChartSeries {
  const ChartSeries({
    required this.points,
    required this.color,
    required this.name,
  });

  final List<ChartPoint> points;
  final Color color;
  final String name;
}
