import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hymate_tech_task/api/providers/api_client_provider.dart';
import 'package:hymate_tech_task/api/services/services.dart';
import 'package:hymate_tech_task/logging/logging.dart';

/// Provides a TaskOneApiServiceInterface using the shared ApiClient instance.
final taskOneApiServiceProvider = Provider<TaskOneApiServiceInterface>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return TaskOneApiService(apiClient: apiClient);
});

/// Provides a TaskTwoApiServiceInterface using the shared LoggingService instance.
final taskTwoApiServiceProvider = Provider<TaskTwoApiServiceInterface>((ref) {
  final loggingService = ref.watch(loggingServiceProvider);
  return TaskTwoApiService(loggingService: loggingService);
});
