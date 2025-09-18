import 'package:dio/dio.dart';

/// Lightweight ApiClient wrapping a configured [Dio] instance.
class ApiClient {
  ApiClient({
    required this.dio,
    this.baseUrl = 'https://api.energy-charts.info/',
  });

  final Dio dio;
  final String baseUrl;

  BaseOptions _getBaseOptions(Map<String, String>? headers) {
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
    dio.options = _getBaseOptions(headers);
    return dio.get(endpoint, queryParameters: queryParameters);
  }

  Future<Response> post(
    String endpoint, {
    Map<String, String>? headers,
    Object? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    dio.options = _getBaseOptions(headers);
    return dio.post(
      endpoint,
      data: body,
      queryParameters: queryParameters,
    );
  }
}
