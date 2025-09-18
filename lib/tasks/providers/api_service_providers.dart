import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hymate_tech_task/api/api.dart';

final taskOneApiServiceProvider = Provider<TaskOneApiService>((ref) {
  return TaskOneApiService();
});
