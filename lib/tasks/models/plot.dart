import 'package:hymate_tech_task/tasks/models/models.dart';

/// Represents a complete plot configuration to be sent to the backend API,
/// containing one or more [Graph]s to be visualized.
class Plot {
  Plot({
    required this.id,
    required this.name,
    required this.primaryYAxisGraphs,
    this.xAxisDataSeries,
  });

  /// A unique identifier for this plot.
  int id;

  /// The user-friendly name or label for the entire plot.
  String name;

  /// The data series for the X-axis
  List<dynamic>? xAxisDataSeries;

  /// A list of [Graph] objects that will be displayed on the primary Y-axis.
  List<Graph> primaryYAxisGraphs;
}
