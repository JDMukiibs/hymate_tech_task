import 'package:dio/dio.dart';

/// Lightweight ApiClient wrapping a configured [Dio] instance.
class ApiClient {
  ApiClient({
    required this.dio,
    this.baseUrl = 'https://api.energy-charts.info/',
  }) {
    dio.options
      ..baseUrl = baseUrl
      ..responseType = ResponseType.plain;
  }

  final Dio dio;
  final String baseUrl;

  Future<Response> get(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) {
    return dio.get(endpoint, queryParameters: queryParameters);
  }

  Future<Response> post(
    String endpoint, {
    Map<String, String>? headers,
    Object? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    return dio.post(
      endpoint,
      data: body,
      queryParameters: queryParameters,
    );
  }
}
