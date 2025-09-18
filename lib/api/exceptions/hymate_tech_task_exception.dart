class HymateTechTaskException implements Exception {
  const HymateTechTaskException([this.message]);

  final String? message;

  @override
  String toString() {
    return 'HymateTechTaskException: $message';
  }
}

class HymateTechTaskNotFoundException implements Exception {
  const HymateTechTaskNotFoundException([this.message]);

  final String? message;

  @override
  String toString() {
    return 'HymateTechTaskNotFoundException: $message';
  }
}

class HymateTechTaskValidationErrorException implements Exception {
  const HymateTechTaskValidationErrorException([this.message]);

  final String? message;

  @override
  String toString() {
    return 'HymateTechTaskValidationErrorException: $message';
  }
}
