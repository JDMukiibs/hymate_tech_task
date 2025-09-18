import 'package:custom_charts/custom_charts.dart';
import 'package:flutter/material.dart';

class ChartCoordinates {
  final double minY, maxY;
  final DateTime minTime, maxTime;
  final Size canvasSize;
  final EdgeInsets padding;

  ChartCoordinates({
    required this.minY,
    required this.maxY,
    required this.minTime,
    required this.maxTime,
    required this.canvasSize,
    required this.padding,
  });

  Offset dataToPixel(ChartPoint point) {
    final plotWidth = canvasSize.width - padding.horizontal;
    final plotHeight = canvasSize.height - padding.vertical;

    final timeProgress =
        point.timestamp.difference(minTime).inMilliseconds /
        maxTime.difference(minTime).inMilliseconds;
    final x = padding.left + (timeProgress * plotWidth);

    final valueProgress = (point.value - minY) / (maxY - minY);
    final y = padding.top + plotHeight - (valueProgress * plotHeight);

    return Offset(x, y);
  }

  double timeToPixel(DateTime time) {
    final plotWidth = canvasSize.width - padding.horizontal;
    final timeProgress =
        time.difference(minTime).inMilliseconds /
        maxTime.difference(minTime).inMilliseconds;
    return padding.left + (timeProgress * plotWidth);
  }
}
