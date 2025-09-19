import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hymate_tech_task/api/models/models.dart';
import 'package:hymate_tech_task/tasks/models/models.dart';

class TaskTwoTreeState extends Equatable {
  const TaskTwoTreeState(
    this.availableDatapointsToPlot,
    this.selectedDatapoints,
    this.selectedCategories,
    this.generatedPlotRequest,
    this.generatedPlot,
    this.assignedColors,
  );

  factory TaskTwoTreeState.initial(
    List<DatapointHierarchyNode> availableDatapointsToPlot,
  ) {
    return TaskTwoTreeState(
      availableDatapointsToPlot,
      const [],
      const [],
      '',
      null,
      const {},
    );
  }

  final List<DatapointHierarchyNode> availableDatapointsToPlot;
  final List<DatapointHierarchyNode> selectedDatapoints;
  final List<DatapointHierarchyNode> selectedCategories;
  final String generatedPlotRequest;
  final Plot? generatedPlot;

  /// A map of assigned colors for each selected datapoint ID.
  /// This is used to ensure consistent coloring in the UI.
  final Map<String, Color> assignedColors;

  TaskTwoTreeState copyWith({
    List<DatapointHierarchyNode>? availableDatapointsToPlot,
    List<DatapointHierarchyNode>? selectedDatapoints,
    List<DatapointHierarchyNode>? selectedCategories,
    String? generatedPlotRequest,
    Plot? generatedPlot,
    Map<String, Color>? assignedColors,
  }) {
    return TaskTwoTreeState(
      availableDatapointsToPlot ?? this.availableDatapointsToPlot,
      selectedDatapoints ?? this.selectedDatapoints,
      selectedCategories ?? this.selectedCategories,
      generatedPlotRequest ?? this.generatedPlotRequest,
      generatedPlot ?? this.generatedPlot,
      assignedColors ?? this.assignedColors,
    );
  }

  @override
  List<Object?> get props => [
    availableDatapointsToPlot,
    selectedDatapoints,
    selectedCategories,
    generatedPlotRequest,
    generatedPlot,
    assignedColors,
  ];
}
