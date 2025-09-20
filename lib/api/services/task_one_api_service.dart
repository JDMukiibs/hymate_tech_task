import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hymate_tech_task/api/api_client/api_client.dart';
import 'package:hymate_tech_task/api/exceptions/hymate_tech_task_exception.dart';
import 'package:hymate_tech_task/api/models/models.dart';

/// Public interface used by consumers (allows swapping in fakes for tests)
abstract class TaskOneApiServiceInterface {
  Future<TotalPowerResponse> getTotalPower({
    required TotalPowerRequest request,
  });

  Future<PriceResponse> getPrice({required PriceRequest request});

  Future<RenewableShareResponse> getSolarShare({required String country});

  Future<RenewableShareResponse> getWindOnshoreShare({required String country});
}

abstract class _TaskOneApiService {
  Future<TotalPowerResponse> getTotalPower({
    required TotalPowerRequest request,
  });

  Future<PriceResponse> getPrice({required PriceRequest request});

  Future<RenewableShareResponse> getSolarShare({required String country});

  Future<RenewableShareResponse> getWindOnshoreShare({required String country});
}

class TaskOneApiService extends _TaskOneApiService
    implements TaskOneApiServiceInterface {
  TaskOneApiService({
    required ApiClient apiClient,
  }) : _apiClient = apiClient;

  final ApiClient _apiClient;
  static const String _totalPowerEndpoint = 'total_power';
  static const String _priceEndpoint = 'price';
  static const String _solarShareEndpoint = 'solar_share';
  static const String _windOnshoreShareEndpoint = 'wind_onshore_share';

  // TODO(Joshua): getTotalPower keeps failing with 422 from the API, need to investigate further.
  // TODO(Joshua): Also I think I should be able to put total power and price in the same  chart  I think
  @override
  Future<TotalPowerResponse> getTotalPower({
    required TotalPowerRequest request,
  }) async {
    late final Response<dynamic> response;

    final queryParameters = <String, dynamic>{
      'country': request.country,
    };

    if (request.start != null) {
      queryParameters['start'] = request.start;
    }

    if (request.end != null) {
      queryParameters['end'] = request.end;
    }

    try {
      response = await _apiClient.get(
        _totalPowerEndpoint,
        queryParameters: queryParameters,
      );

      if (response.statusCode == 200) {
        return TotalPowerResponse.fromJson(
          jsonDecode(response.data as String) as Map<String, dynamic>,
        );
      }
    } catch (error) {
      if (error is DioException && error.response?.statusCode == 404) {
        throw HymateTechTaskNotFoundException(error.response?.statusMessage);
      } else if (error is DioException && error.response?.statusCode == 422) {
        throw HymateTechTaskValidationErrorException(
          error.response?.statusMessage,
        );
      } else if (error is DioException && error.response?.statusCode == 500) {
        throw HymateTechTaskException(error.response?.statusMessage);
      }

      rethrow;
    }

    throw const HymateTechTaskException(
      'Something went wrong when fetching total power data.',
    );
  }

  @override
  Future<PriceResponse> getPrice({required PriceRequest request}) async {
    late final Response<dynamic> response;

    final queryParameters = <String, dynamic>{
      'bzn': request.bzn,
    };

    if (request.start != null) {
      queryParameters['start'] = request.start;
    }

    if (request.end != null) {
      queryParameters['end'] = request.end;
    }

    try {
      response = await _apiClient.get(
        _priceEndpoint,
        queryParameters: queryParameters,
      );

      if (response.statusCode == 200) {
        return PriceResponse.fromJson(
          jsonDecode(response.data as String) as Map<String, dynamic>,
        );
      }
    } catch (error) {
      if (error is DioException && error.response?.statusCode == 404) {
        throw const HymateTechTaskNotFoundException();
      } else if (error is DioException && error.response?.statusCode == 422) {
        throw HymateTechTaskValidationErrorException(
          error.response?.statusMessage,
        );
      } else if (error is DioException && error.response?.statusCode == 500) {
        throw HymateTechTaskException(error.response?.statusMessage);
      }

      rethrow;
    }

    throw const HymateTechTaskException(
      'Something went wrong when fetching price data.',
    );
  }

  @override
  Future<RenewableShareResponse> getSolarShare({
    required String country,
  }) async {
    late final Response<dynamic> response;

    final queryParameters = <String, dynamic>{
      'country': country,
    };

    try {
      response = await _apiClient.get(
        _solarShareEndpoint,
        queryParameters: queryParameters,
      );

      if (response.statusCode == 200) {
        return RenewableShareResponse.fromJson(
          jsonDecode(response.data as String) as Map<String, dynamic>,
        );
      }
    } catch (error) {
      if (error is DioException && error.response?.statusCode == 404) {
        throw const HymateTechTaskNotFoundException();
      } else if (error is DioException && error.response?.statusCode == 422) {
        throw HymateTechTaskValidationErrorException(
          error.response?.statusMessage,
        );
      } else if (error is DioException && error.response?.statusCode == 500) {
        throw HymateTechTaskException(error.response?.statusMessage);
      }

      rethrow;
    }

    throw const HymateTechTaskException(
      'Something went wrong when fetching solar share data.',
    );
  }

  @override
  Future<RenewableShareResponse> getWindOnshoreShare({
    required String country,
  }) async {
    late final Response<dynamic> response;

    final queryParameters = <String, dynamic>{
      'country': country,
    };

    try {
      response = await _apiClient.get(
        _windOnshoreShareEndpoint,
        queryParameters: queryParameters,
      );

      if (response.statusCode == 200) {
        return RenewableShareResponse.fromJson(
          jsonDecode(response.data as String) as Map<String, dynamic>,
        );
      }
    } catch (error) {
      if (error is DioException && error.response?.statusCode == 404) {
        throw const HymateTechTaskNotFoundException();
      } else if (error is DioException && error.response?.statusCode == 422) {
        throw HymateTechTaskValidationErrorException(
          error.response?.statusMessage,
        );
      } else if (error is DioException && error.response?.statusCode == 500) {
        throw HymateTechTaskException(error.response?.statusMessage);
      }

      rethrow;
    }

    throw const HymateTechTaskException(
      'Something went wrong when fetching wind onshore share data.',
    );
  }
}
