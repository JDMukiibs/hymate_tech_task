import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hymate_tech_task/api/api.dart';
import 'package:hymate_tech_task/tasks/helpers/helpers.dart';
import 'package:hymate_tech_task/tasks/models/models.dart';
import 'package:hymate_tech_task/tasks/providers/providers.dart';
import 'package:reactive_forms/reactive_forms.dart';

final asyncTaskTwoNotifierProvider =
    AsyncNotifierProvider<AsyncTaskTwoNotifier, TaskTwoTreeState>(
      AsyncTaskTwoNotifier.new,
    );

class AsyncTaskTwoNotifier extends AsyncNotifier<TaskTwoTreeState> {
  late final FormGroup formGroup;

  @override
  Future<TaskTwoTreeState> build() async {
    formGroup = FormGroup(
      {
        'selectedDatapoints': FormArray<DatapointHierarchyNode>([]),
        'selectedCategories': FormArray<DatapointHierarchyNode>([]),
      },
      validators: [const RequiredAtleastOneValidator()],
    );
    final availableDataPointsToPlot = await ref
        .watch(taskTwoApiServiceProvider)
        .getAvailableDataToPlot();
    return TaskTwoTreeState.initial(availableDataPointsToPlot);
  }

  void toggleDatapointSelection(DatapointHierarchyNode node) {
    final currentState = state.value!;
    final currentDatapoints = List<DatapointHierarchyNode>.from(
      currentState.selectedDatapoints,
    );

    final identifier = node.id!;
    final isAlreadySelected = currentDatapoints.any(
      (item) => item.id == node.id,
    );

    if (isAlreadySelected) {
      currentDatapoints.removeWhere((item) => item.id == node.id);
    } else {
      currentDatapoints.add(node);
    }

    _manageColorsOnSelection(identifier, !isAlreadySelected);

    final newState = currentState.copyWith(
      selectedDatapoints: currentDatapoints,
    );

    state = AsyncValue.data(newState);
    _syncFormWithState();
  }

  void toggleCategorySelection(DatapointHierarchyNode node) {
    final currentState = state.value!;
    final currentCategories = List<DatapointHierarchyNode>.from(
      currentState.selectedCategories,
    );

    final identifier = node.name;
    final isAlreadySelected = currentCategories.any(
      (item) => item.name == node.name,
    );

    if (isAlreadySelected) {
      currentCategories.removeWhere((item) => item.name == node.name);
    } else {
      currentCategories.add(node);
    }

    _manageColorsOnSelection(identifier, !isAlreadySelected);

    final newState = currentState.copyWith(
      selectedCategories: currentCategories,
    );

    state = AsyncValue.data(newState);
    _syncFormWithState();
  }

  void _manageColorsOnSelection(String identifier, bool isSelected) {
    final currentAssignedColors = Map<String, Color>.from(
      state.value!.assignedColors,
    );

    if (isSelected) {
      if (!currentAssignedColors.containsKey(identifier)) {
        currentAssignedColors[identifier] =
            ColorHelper.assignColorBasedOnHashCode(identifier);
      }
    } else {
      currentAssignedColors.remove(identifier);
    }

    state = AsyncValue.data(
      state.value!.copyWith(assignedColors: currentAssignedColors),
    );
  }

  void _syncFormWithState() {
    final currentState = state.value!;

    final datapointsArray =
        formGroup.control('selectedDatapoints')
            as FormArray<DatapointHierarchyNode>;
    final categoriesArray =
        formGroup.control('selectedCategories')
            as FormArray<DatapointHierarchyNode>;

    datapointsArray.value = currentState.selectedDatapoints;
    categoriesArray.value = currentState.selectedCategories;

    formGroup.updateValueAndValidity();
  }

  bool isDatapointSelected(DatapointHierarchyNode node) {
    final currentState = state.value!;
    return currentState.selectedDatapoints.any((item) => item.id == node.id);
  }

  bool isCategorySelected(DatapointHierarchyNode node) {
    final currentState = state.value!;
    return currentState.selectedCategories.any(
      (item) => item.name == node.name,
    );
  }

  bool get canGeneratePlot => formGroup.valid;

  bool get hasPlotRequest => state.value!.generatedPlotRequest != null;

  void clearSelections() {
    state = AsyncValue.data(
      TaskTwoTreeState.initial(state.value!.availableDatapointsToPlot),
    );
    _syncFormWithState();
  }

  Future<void> generatePlotRequest() async {
    final currentState = state.value!;

    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final plot = _generatePlot();

      final plotRequest = PlotRequest.fromPlot(plot);

      /// We don't have a real backend to send the request to
      // final apiResponse = await ref
      //     .watch(taskTwoApiServiceProvider)
      //     .sendPlotRequest(plotRequest);

      return currentState.copyWith(generatedPlotRequest: plotRequest);
    });
  }

  Plot _generatePlot() {
    final currentState = state.value!;
    final graphs = <Graph>[];
    var graphId = 1;

    for (final datapoint in currentState.selectedDatapoints) {
      graphs.add(
        Graph(
          id: graphId++,
          name: datapoint.name,
          dataPoints: [_convertToDataPoint(datapoint)],
          color: currentState.assignedColors[datapoint.id!],
        ),
      );
    }

    for (final category in currentState.selectedCategories) {
      final categoryDataPoints = getAllDatapointsInCategoryIterative(
        category,
      ).map(_convertToDataPoint).toList();

      graphs.add(
        Graph(
          id: graphId++,
          name: category.name,
          dataPoints: categoryDataPoints,
          color: currentState.assignedColors[category.name],
        ),
      );
    }

    return Plot(
      id: DateTime.now().millisecondsSinceEpoch,
      name: 'Generated Plot - ${DateTime.now()}',
      primaryYAxisGraphs: graphs,
    );
  }

  /// Helper to convert DatapointHierarchyNode to DataPoint
  /// Assumes node.id is non-null and also continues assumption that
  /// perhaps BE response will populate timeSeries and unit later
  DataPoint _convertToDataPoint(DatapointHierarchyNode node) {
    return DataPoint(
      id: node.id!,
      label: node.name,
    );
  }
}
