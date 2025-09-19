import 'package:hymate_tech_task/api/models/models.dart';
import 'package:hymate_tech_task/api/services/task_two_api_service.dart';
import 'package:hymate_tech_task/logging/logging_service.dart';
import 'package:logger/logger.dart';

// Lightweight test logger that records messages instead of relying on a mocking library
class TestLoggingService extends LoggingService {
  TestLoggingService() : super(logger: Logger());

  final List<String> infoLogs = [];
  final List<String> warnLogs = [];
  final List<String> errorLogs = [];

  @override
  void i(dynamic message, {dynamic error, StackTrace? stackTrace}) {
    infoLogs.add(message?.toString() ?? '');
  }

  @override
  Future<void> w(
    dynamic message, {
    dynamic error,
    StackTrace? stackTrace,
  }) async {
    warnLogs.add(message?.toString() ?? '');
  }

  @override
  Future<void> e(
    dynamic message, {
    dynamic error,
    StackTrace? stackTrace,
  }) async {
    errorLogs.add(message?.toString() ?? '');
  }
}

// Fake service to avoid delays and external dependencies – allows precise control over returned data
class FakeTaskTwoApiService implements TaskTwoApiServiceInterface {
  FakeTaskTwoApiService({required this.nodes, required this.loggingService});

  final List<DatapointHierarchyNode> nodes;
  final LoggingService loggingService;
  PlotRequest? lastRequest;

  @override
  Future<List<DatapointHierarchyNode>> getAvailableDataToPlot() async => nodes;

  @override
  Future<String> sendPlotRequest(PlotRequest request) async {
    lastRequest = request;
    loggingService.i('Sending plot request: ${request.toJson()}');
    return request.toJson().toString();
  }
}
