import 'package:flutter/material.dart';
import 'package:hymate_tech_task/api/api.dart';

/// Represents a single series of data to be plotted on a graph.
///
/// A [Graph] can correspond to either a single selected datapoint (e.g.,
/// a specific sensor's output) or a selected category
class Graph {
  Graph({
    required this.id,
    required this.name,
    required this.dataPoints,
    this.availableXData,
    this.color,
    this.values,
  });

  /// A unique identifier for this graph.
  final int id;

  /// The user-friendly name of the graph,
  final String name;

  /// The list of [DataPoint]s
  final List<DataPoint> dataPoints;

  /// The color assigned to this graph series for visualization.
  final Color? color;

  /// The numerical values (Y-axis data)
  final List<double?>? values;

  /// The corresponding X-axis data points
  final List<dynamic>? availableXData;
}
