import 'dart:convert';

import 'package:hymate_tech_task/tasks/models/models.dart' show Plot;
import 'package:json_annotation/json_annotation.dart';

part 'plot_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PlotRequest {
  PlotRequest({required this.id, required this.name, required this.data});

  factory PlotRequest.fromJson(Map<String, dynamic> json) =>
      _$PlotRequestFromJson(json);

  factory PlotRequest.fromPlot(Plot plot) {
    final directDatapoints = <String>[];
    final extraOperations = <PlotRequestExtraData>[];

    for (final graph in plot.primaryYAxisGraphs) {
      if (graph.dataPoints.length == 1) {
        // Single datapoint graph
        directDatapoints.add(graph.dataPoints.first.id);
      } else {
        // Category graph (multiple datapoints)
        extraOperations.add(
          PlotRequestExtraData(
            datapoints: graph.dataPoints.map((dp) => dp.id).toList(),
            label: graph.name,
          ),
        );
      }
    }

    return PlotRequest(
      id: plot.id.toString(),
      name: plot.name,
      data: PlotRequestData(
        datapoints: directDatapoints,
        extra: extraOperations.isEmpty ? null : extraOperations,
      ),
    );
  }

  final String id;
  final String name;
  final PlotRequestData data;

  Map<String, dynamic> toJson() => _$PlotRequestToJson(this);

  @override
  String toString() {
    final jsonMap = toJson();

    // Create a JsonEncoder with an indent for pretty printing
    const encoder = JsonEncoder.withIndent('  '); // 2 spaces indent

    // Encode the map to a formatted JSON string
    return encoder.convert(jsonMap);
  }
}

@JsonSerializable(fieldRename: FieldRename.snake)
class PlotRequestData {
  PlotRequestData({required this.datapoints, required this.extra});

  factory PlotRequestData.fromJson(Map<String, dynamic> json) =>
      _$PlotRequestDataFromJson(json);

  final List<String> datapoints;
  final List<PlotRequestExtraData>? extra;

  Map<String, dynamic> toJson() => _$PlotRequestDataToJson(this);

  @override
  String toString() => json.encode(toJson());
}

@JsonSerializable(fieldRename: FieldRename.snake)
class PlotRequestExtraData {
  PlotRequestExtraData({
    required this.datapoints,
    required this.label,
    this.operation = 'sum',
  });

  factory PlotRequestExtraData.fromJson(Map<String, dynamic> json) =>
      _$PlotRequestExtraDataFromJson(json);

  final String operation;
  final List<String> datapoints;
  final String label;

  Map<String, dynamic> toJson() => _$PlotRequestExtraDataToJson(this);

  @override
  String toString() => json.encode(toJson());
}
