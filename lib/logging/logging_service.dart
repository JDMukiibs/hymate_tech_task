import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

final loggingServiceProvider = Provider<LoggingService>(
  (ref) => LoggingService(
    logger: Logger(),
  ),
);

class LoggingService {
  LoggingService({required this.logger});

  final Logger logger;

  void i(
    dynamic message, {
    dynamic error,
    StackTrace? stackTrace,
  }) {
    logger.i(message, error: error, stackTrace: stackTrace);
  }

  Future<void> e(
    dynamic message, {
    dynamic error,
    StackTrace? stackTrace,
  }) async {
    logger.e(message, error: error, stackTrace: stackTrace);
  }

  Future<void> w(
    dynamic message, {
    dynamic error,
    StackTrace? stackTrace,
  }) async {
    logger.w(message, error: error, stackTrace: stackTrace);
  }
}
