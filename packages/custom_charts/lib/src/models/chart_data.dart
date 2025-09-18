import 'package:flutter/material.dart';

class ChartPoint {
  final DateTime timestamp;
  final double value;

  const ChartPoint(this.timestamp, this.value);
}

class ChartSeries {
  final List<ChartPoint> points;
  final Color color;
  final String name;

  const ChartSeries({
    required this.points,
    required this.color,
    required this.name,
  });
}
