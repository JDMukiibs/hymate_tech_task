import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hymate_tech_task/api/api_client/api_client.dart';
import 'package:hymate_tech_task/cache/cache.dart';

/// Provides a single ApiClient configured with Dio and cache interceptor.
final apiClientProvider = Provider<ApiClient>((ref) {
  final cacheOptions = ref.watch(cacheOptionsProvider);

  final dio = Dio();
  dio.interceptors.add(DioCacheInterceptor(options: cacheOptions));
  dio.interceptors.add(LogInterceptor());

  return ApiClient(dio: dio);
});
