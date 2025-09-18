// packages/custom_charts/lib/src/charts/area_chart.dart
import 'dart:math' as math;

import 'package:custom_charts/src/helpers/chart_coordinate.dart';
import 'package:custom_charts/src/models/chart_data.dart';
import 'package:flutter/material.dart';

class AreaChart extends StatelessWidget {
  const AreaChart({
    required this.series,
    super.key,
    this.animationDuration = const Duration(milliseconds: 800),
    this.padding = const EdgeInsets.all(40),
  });

  final List<ChartSeries> series;
  final Duration animationDuration;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: AreaChartPainter(
        series: series,
        padding: padding,
      ),
      size: Size.infinite,
    );
  }
}

class AreaChartPainter extends CustomPainter {
  AreaChartPainter({
    required this.series,
    required this.padding,
  });

  final List<ChartSeries> series;
  final EdgeInsets padding;

  @override
  void paint(Canvas canvas, Size size) {
    if (series.isEmpty) return;

    final coords = _calculateCoordinates(size);

    // Draw axes first (behind the data)
    _drawDynamicAxes(canvas, size, coords);

    // Draw each series
    for (final seriesData in series) {
      _drawAreaSeries(canvas, size, seriesData, coords);
    }
  }

  ChartCoordinates _calculateCoordinates(Size size) {
    var minY = double.infinity;
    var maxY = double.negativeInfinity;
    DateTime? minTime;
    DateTime? maxTime;

    for (final s in series) {
      for (final point in s.points) {
        minY = math.min(minY, point.value);
        maxY = math.max(maxY, point.value);
        minTime ??= point.timestamp;
        maxTime ??= point.timestamp;
        if (point.timestamp.isBefore(minTime)) minTime = point.timestamp;
        if (point.timestamp.isAfter(maxTime)) maxTime = point.timestamp;
      }
    }

    // Add some padding to the Y range for better visualization
    final yRange = maxY - minY;
    final yPadding = yRange * 0.1;
    minY = math.max(0, minY - yPadding);
    maxY = maxY + yPadding;

    return ChartCoordinates(
      minY: minY,
      maxY: maxY,
      minTime: minTime!,
      maxTime: maxTime!,
      canvasSize: size,
      padding: padding,
    );
  }

  void _drawAreaSeries(
    Canvas canvas,
    Size size,
    ChartSeries seriesData,
    ChartCoordinates coords,
  ) {
    if (seriesData.points.isEmpty) return;

    final path = Path();
    final paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          seriesData.color.withValues(alpha: 0.8),
          seriesData.color.withValues(alpha: 0.1),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    // Start path at bottom-left of first point
    final firstPoint = coords.dataToPixel(seriesData.points.first);
    path..moveTo(firstPoint.dx, size.height - padding.bottom)
    ..lineTo(firstPoint.dx, firstPoint.dy);

    // Draw line through all data points
    for (final point in seriesData.points) {
      final pixel = coords.dataToPixel(point);
      path.lineTo(pixel.dx, pixel.dy);
    }

    // Close path at bottom-right
    final lastPoint = coords.dataToPixel(seriesData.points.last);
    path..lineTo(lastPoint.dx, size.height - padding.bottom)
    ..close();

    // Draw filled area
    canvas.drawPath(path, paint);

    // Draw the line stroke on top
    final linePaint = Paint()
      ..color = seriesData.color
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final linePath = Path();
    final firstPixel = coords.dataToPixel(seriesData.points.first);
    linePath.moveTo(firstPixel.dx, firstPixel.dy);

    for (var i = 1; i < seriesData.points.length; i++) {
      final pixel = coords.dataToPixel(seriesData.points[i]);
      linePath.lineTo(pixel.dx, pixel.dy);
    }

    canvas.drawPath(linePath, linePaint);
  }

  void _drawDynamicAxes(Canvas canvas, Size size, ChartCoordinates coords) {
    final axisPaint = Paint()
      ..color = Colors.grey.withValues(alpha: 0.3)
      ..strokeWidth = 1.0;

    final textStyle = TextStyle(
      color: Colors.grey.withValues(alpha: 0.8),
      fontSize: 11,
    );

    _drawDynamicYAxis(canvas, coords, axisPaint, textStyle);
    _drawDynamicXAxis(canvas, coords, axisPaint, textStyle);
  }

  void _drawDynamicYAxis(
    Canvas canvas,
    ChartCoordinates coords,
    Paint axisPaint,
    TextStyle textStyle,
  ) {
    final yRange = coords.maxY - coords.minY;
    final niceStep = _calculateNiceStep(yRange, 6);
    final firstTick = (coords.minY / niceStep).ceil() * niceStep;

    var currentValue = firstTick;
    while (currentValue <= coords.maxY) {
      final progress = (currentValue - coords.minY) / yRange;
      final y =
          coords.canvasSize.height -
          coords.padding.bottom -
          (progress * (coords.canvasSize.height - coords.padding.vertical));

      // Draw grid line
      canvas.drawLine(
        Offset(coords.padding.left, y),
        Offset(coords.canvasSize.width - coords.padding.right, y),
        axisPaint,
      );

      // Draw label
      final label = currentValue.toStringAsFixed(3);
      final textPainter = TextPainter(
        text: TextSpan(text: label, style: textStyle),
        textDirection: TextDirection.ltr,
      )
      ..layout();
      textPainter.paint(
        canvas,
        Offset(
          coords.padding.left - textPainter.width - 8,
          y - textPainter.height / 2,
        ),
      );

      currentValue += niceStep;
    }
  }

  void _drawDynamicXAxis(
    Canvas canvas,
    ChartCoordinates coords,
    Paint axisPaint,
    TextStyle textStyle,
  ) {
    final timeRange = coords.maxTime.difference(coords.minTime);
    final timeStepMinutes = math.max(60, (timeRange.inMinutes / 4).round());
    final timeStep = Duration(minutes: timeStepMinutes);

    var currentTime = DateTime(
      coords.minTime.year,
      coords.minTime.month,
      coords.minTime.day,
      coords.minTime.hour,
    );

    while (currentTime.isBefore(coords.maxTime)) {
      if (currentTime.isAfter(coords.minTime)) {
        final pixel = coords.timeToPixel(currentTime);

        // Draw grid line
        canvas.drawLine(
          Offset(pixel, coords.padding.top),
          Offset(pixel, coords.canvasSize.height - coords.padding.bottom),
          axisPaint,
        );

        // Draw label
        final label =
            '${currentTime.hour.toString().padLeft(2, '0')}:${currentTime.minute.toString().padLeft(2, '0')}';
        final textPainter = TextPainter(
          text: TextSpan(text: label, style: textStyle),
          textDirection: TextDirection.ltr,
        )
        ..layout();
        textPainter.paint(
          canvas,
          Offset(
            pixel - textPainter.width / 2,
            coords.canvasSize.height - coords.padding.bottom + 8,
          ),
        );
      }

      currentTime = currentTime.add(timeStep);
    }
  }

  double _calculateNiceStep(double range, int targetSteps) {
    final roughStep = range / targetSteps;
    final magnitude = math.pow(10, (math.log(roughStep) / math.ln10).floor());
    final normalizedStep = roughStep / magnitude;

    double niceStep;
    if (normalizedStep <= 1) {
      niceStep = 1;
    } else if (normalizedStep <= 2) {
      niceStep = 2;
    } else if (normalizedStep <= 5) {
      niceStep = 5;
    } else {
      niceStep = 10;
    }

    return niceStep * magnitude;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
