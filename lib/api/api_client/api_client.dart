import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

class ApiClient {
  factory ApiClient({
    required CacheOptions cacheOptions,
    Dio? dioOverride,
    bool enableInterceptors = true,
  }) {
    _instance._dio = _instance._dio ?? dioOverride!;

    if (enableInterceptors) {
      _instance._dio!.interceptors.add(
        DioCacheInterceptor(options: cacheOptions),
      );
      _instance._dio!.interceptors.add(LogInterceptor());
    }

    return _instance;
  }

  ApiClient._(this.cacheOptions);

  Dio? _dio;
  final CacheOptions cacheOptions;

  static const String baseUrl = 'https://api.energy-charts.info/';

  static final ApiClient _instance = ApiClient._();
  late String languageCode;

  BaseOptions _getBaseOptions(
    String baseUrl,
    Map<String, String>? headers,
  ) {
    return BaseOptions(
      baseUrl: baseUrl,
      headers: headers,
      responseType: ResponseType.plain,
    );
  }

  Future<Response> get(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) {
    _dio!.options = _getBaseOptions(baseUrl, headers);

    return _dio!.get(
      endpoint,
      queryParameters: queryParameters,
    );
  }

  Future<Response> post(
    String endpoint, {
    Map<String, String>? headers,
    Object? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    _dio!.options = _getBaseOptions(baseUrl, headers);

    final response = await _dio!.post(
      endpoint,
      data: body,
      queryParameters: queryParameters,
    );

    return response;
  }
}
