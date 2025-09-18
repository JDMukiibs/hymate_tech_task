import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hymate_tech_task/api/providers/api_client_provider.dart';
import 'package:hymate_tech_task/api/services/task_one_api_service.dart';

/// Provides a TaskOneApiServiceInterface using the shared ApiClient instance.
final taskOneApiServiceProvider = Provider<TaskOneApiServiceInterface>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return TaskOneApiService(apiClient: apiClient);
});
