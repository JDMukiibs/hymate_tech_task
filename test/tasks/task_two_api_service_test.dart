import 'package:flutter_test/flutter_test.dart';
import 'package:hymate_tech_task/api/models/models.dart';

import '../mocks/mocks.dart';

void main() {
  late TestLoggingService loggingService;
  late FakeTaskTwoApiService service;

  setUp(() {
    loggingService = TestLoggingService();
  });

  test('getAvailableDataToPlot parses hierarchy into nodes correctly (fake service)', () async {
    // Build a representative hierarchy similar to the real mock used in the app
    final bhkwLeaf = DatapointHierarchyNode(
      name: 'BHKW 1 electrical power',
      id: 'CNV_1_CHP_1_ELCPOWEROUT',
    );

    final bhkwGroup = DatapointHierarchyNode(
      name: 'BHKWs (combined heat power plants)',
      children: [bhkwLeaf],
    );

    final electrical = DatapointHierarchyNode(
      name: 'Electrical production',
      children: [bhkwGroup],
    );

    final production = DatapointHierarchyNode(
      name: 'Production',
      children: [electrical],
    );

    final consumption = DatapointHierarchyNode(
      name: 'Consumption',
      children: [
        DatapointHierarchyNode(name: 'Electrical consumption', id: 'CNS_1_BSL_1_ELCPOWEROUT'),
      ],
    );

    final nodes = [production, consumption];

    service = FakeTaskTwoApiService(nodes: nodes, loggingService: loggingService);

    final result = await service.getAvailableDataToPlot();

    expect(result.length, 2);

    final prod = result.firstWhere((n) => n.name == 'Production');
    expect(prod.isCategory, isTrue);

    final elec = prod.children!.firstWhere((c) => c.name == 'Electrical production');
    expect(elec.isCategory, isTrue);

    final bhkw = elec.children!.firstWhere((c) => c.name.toLowerCase().contains('bhkw'));
    expect(bhkw.isCategory, isTrue);

    final leaf = bhkw.children!.firstWhere((c) => c.id == 'CNV_1_CHP_1_ELCPOWEROUT');
    expect(leaf.isDatapoint, isTrue);
    expect(leaf.id, 'CNV_1_CHP_1_ELCPOWEROUT');
  });

  test('sendPlotRequest returns request json string and logs the request (fake service)', () async {
    service = FakeTaskTwoApiService(nodes: [], loggingService: loggingService);

    final request = PlotRequest(
      id: 'plot_1',
      name: 'Test Plot',
      data: PlotRequestData(
        datapoints: ['CNV_1_CHP_1_ELCPOWEROUT'],
        extra: [
          PlotRequestExtraData(
            datapoints: ['CNV_1_CHP_1_ELCPOWEROUT'],
            label: 'BHKW 1 sum',
          ),
        ],
      ),
    );

    final result = await service.sendPlotRequest(request);

    expect(result, request.toJson().toString());
    expect(loggingService.infoLogs.any((m) => m.contains('Sending plot request')), isTrue);
    expect(service.lastRequest, isNotNull);
    expect(service.lastRequest!.id, 'plot_1');
  });

  // Edge case: empty datapoints list
  test('getAvailableDataToPlot returns empty list when there are no datapoints', () async {
    service = FakeTaskTwoApiService(nodes: [], loggingService: loggingService);

    final result = await service.getAvailableDataToPlot();
    expect(result, isEmpty);
  });

  // Edge case: node with empty children should NOT be considered a category
  test('nodes with empty children are not categories', () async {
    final nodeWithEmptyChildren = DatapointHierarchyNode(name: 'EmptyChildren', children: []);
    service = FakeTaskTwoApiService(nodes: [nodeWithEmptyChildren], loggingService: loggingService);

    final result = await service.getAvailableDataToPlot();
    expect(result.length, 1);
    final node = result.first;
    expect(node.children, isNotNull);
    expect(node.children, isEmpty);
    expect(node.isCategory, isFalse);
  });

  // Edge case: node that has both an id and non-empty children (both datapoint and category)
  test('node with id and children is both datapoint and category when children exist', () async {
    final childLeaf = DatapointHierarchyNode(name: 'child', id: 'child_1');
    final nodeBoth = DatapointHierarchyNode(name: 'Both', id: 'both_1', children: [childLeaf]);

    service = FakeTaskTwoApiService(nodes: [nodeBoth], loggingService: loggingService);

    final result = await service.getAvailableDataToPlot();
    final node = result.first;

    // Because id != null, isDatapoint should be true
    expect(node.isDatapoint, isTrue);

    // Because children is non-empty, isCategory should also be true
    expect(node.isCategory, isTrue);
  });
}
