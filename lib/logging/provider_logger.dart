import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

base class ProviderLogger extends ProviderObserver {
  ProviderLogger(this.logger);

  final Logger logger;

  @override
  void didAddProvider(
      ProviderObserverContext context,
    Object? value,
  ) {
    logger.d('''
      Added Provider
      {
        "provider": ${context.provider.name ?? context.provider.runtimeType},
        "value": $value 
      }
    ''');
  }

  @override
  void didDisposeProvider(
      ProviderObserverContext context,
  ) {
    logger.w('''
      Disposed Provider
      {
        "provider": ${context.provider.name ?? context.provider.runtimeType},
        "containers": ${context.container} 
      }
    ''');
  }

  @override
  void didUpdateProvider(
      ProviderObserverContext context,
    Object? previousValue,
    Object? newValue,
  ) {
    logger.d('''
      Updated Provider
      {
        "provider": ${context.provider.name ?? context.provider.runtimeType},
        "previousValue": $previousValue,
         "newValue": $newValue
      }
    ''');
  }

  @override
  void providerDidFail(
      ProviderObserverContext context,
    Object error,
    StackTrace stackTrace,
  ) {
    logger.e('''
      Provider Failed!
      {
        "provider": ${context.provider.name ?? context.provider.runtimeType},
        "error": $error,
        "stackTrace": $stackTrace 
      }
    ''');
  }
}
