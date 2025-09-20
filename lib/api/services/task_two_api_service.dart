import 'dart:convert';

import 'package:hymate_tech_task/api/models/models.dart';
import 'package:hymate_tech_task/logging/logging.dart';

/// Public interface used by consumers (allows swapping in fakes for tests)
abstract class TaskTwoApiServiceInterface {
  Future<List<DatapointHierarchyNode>> getAvailableDataToPlot();

  Future<String> sendPlotRequest(PlotRequest request);
}

abstract class _TaskTwoApiService {
  Future<List<DatapointHierarchyNode>> getAvailableDataToPlot();

  Future<String> sendPlotRequest(PlotRequest request);
}

class TaskTwoApiService extends _TaskTwoApiService
    implements TaskTwoApiServiceInterface {
  TaskTwoApiService({
    required this.loggingService,
  });

  final LoggingService loggingService;

  // Mock JSON response
  static const String mockHierarchyResponse = '''
{
  "datapoints": [
    {
      "name": "Production",
      "children": [
        {
          "name": "Electrical production",
          "children": [
            {
              "name": "BHKWs (combined heat power plants)",
              "children": [
                {
                  "name": "BHKW 1 electrical power",
                  "id": "CNV_1_CHP_1_ELCPOWEROUT"
                },
                {
                  "name": "BHKW 2 electrical power",
                  "id": "CNV_2_CHP_1_ELCPOWEROUT"
                },
                {
                  "name": "BHKW 3 electrical power",
                  "id": "CNV_3_CHP_1_ELCPOWEROUT"
                }
              ]
            },
            {
              "name": "PVs (Photovoltaic systems)",
              "children": [
                {
                  "name": "PV 1",
                  "id": "PRD_1_PHV_1_ELCPOWEROUT"
                },
                {
                  "name": "PV 2",
                  "id": "PRD_2_PHV_1_ELCPOWEROUT"
                },
                {
                  "name": "PV 3",
                  "id": "PRD_3_PHV_1_ELCPOWEROUT"
                }
              ]
            }
          ]
        },
        {
          "name": "Thermal production",
          "children": [
            {
              "name": "BHKWs",
              "children": [
                {
                  "name": "BHKW 1 thermal power",
                  "id": "CNV_1_CHP_2_THRPOWEROUT"
                },
                {
                  "name": "BHKW 2 thermal power",
                  "id": "CNV_2_CHP_2_THRPOWEROUT"
                },
                {
                  "name": "BHKW 3 thermal power",
                  "id": "CNV_3_CHP_2_THRPOWEROUT"
                }
              ]
            }
          ]
        }
      ]
    },
    {
      "name": "Consumption",
      "children": [
        {
          "name": "Electrical consumption",
          "id": "CNS_1_BSL_1_ELCPOWEROUT"
        },
        {
          "name": "Thermal consumption",
          "id": "CNS_2_BSL_2_THRPOWEROUT"
        }
      ]
    }
  ]
}
''';

  // TODO(Joshua): Consider using compute() for large hierarchies (>1000 nodes) to prevent UI blocking during JSON parsing
  @override
  Future<List<DatapointHierarchyNode>> getAvailableDataToPlot() async {
    try {
      final mockResponseMap =
          jsonDecode(mockHierarchyResponse) as Map<String, dynamic>;
      final rootNodes = (mockResponseMap['datapoints'] as List<dynamic>).map((
        node,
      ) {
        return DatapointHierarchyNode.fromJson(node as Map<String, dynamic>);
      }).toList();
      loggingService.i('Parsed mock hierarchy response successfully.');

      return Future.delayed(const Duration(seconds: 3), () => rootNodes);
    } on Exception catch (e) {
      await loggingService.e(
        'Error parsing mock hierarchy response: $e',
      );
      return Future.error('Failed to parse hierarchy data');
    }
  }

  @override
  Future<String> sendPlotRequest(PlotRequest request) async {
    loggingService.i('Sending plot request: ${request.toJson()}');
    return Future.delayed(
      const Duration(seconds: 3),
      () => request.toJson().toString(),
    );
  }
}
