import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hymate_tech_task/api/api.dart';

/// State for the Task One controller (holds selections and loaded data)
class TaskOneChartState extends Equatable {
  const TaskOneChartState({
    required this.selectedSeriesNames,
    required this.availableSeriesNames,
    required this.totalPowerResponse,
    required this.priceResponse,
    required this.solarShareResponse,
    required this.windOnshoreShareResponse,
    required this.assignedColors,
    required this.generatedChartData,
  });

  factory TaskOneChartState.initial() {
    return const TaskOneChartState(
      selectedSeriesNames: [],
      availableSeriesNames: [],
      totalPowerResponse: null,
      priceResponse: null,
      solarShareResponse: null,
      windOnshoreShareResponse: null,
      assignedColors: {},
      generatedChartData: [],
    );
  }

  final List<String> selectedSeriesNames;
  final List<String> availableSeriesNames;
  final TotalPowerResponse? totalPowerResponse;
  final PriceResponse? priceResponse;
  final RenewableShareResponse? solarShareResponse;
  final RenewableShareResponse? windOnshoreShareResponse;
  final Map<String, Color> assignedColors;
  final List<dynamic> generatedChartData;

  TaskOneChartState copyWith({
    List<String>? selectedSeriesNames,
    List<String>? availableSeriesNames,
    TotalPowerResponse? totalPowerResponse,
    PriceResponse? priceResponse,
    RenewableShareResponse? solarShareResponse,
    RenewableShareResponse? windOnshoreShareResponse,
    Map<String, Color>? assignedColors,
    List<dynamic>? generatedChartData,
  }) {
    return TaskOneChartState(
      selectedSeriesNames: selectedSeriesNames ?? this.selectedSeriesNames,
      availableSeriesNames: availableSeriesNames ?? this.availableSeriesNames,
      totalPowerResponse: totalPowerResponse ?? this.totalPowerResponse,
      priceResponse: priceResponse ?? this.priceResponse,
      solarShareResponse: solarShareResponse ?? this.solarShareResponse,
      windOnshoreShareResponse:
          windOnshoreShareResponse ?? this.windOnshoreShareResponse,
      assignedColors: assignedColors ?? this.assignedColors,
      generatedChartData: generatedChartData ?? this.generatedChartData,
    );
  }

  @override
  List<Object?> get props => [
    selectedSeriesNames,
    availableSeriesNames,
    totalPowerResponse,
    priceResponse,
    solarShareResponse,
    windOnshoreShareResponse,
    assignedColors,
    generatedChartData,
  ];
}
