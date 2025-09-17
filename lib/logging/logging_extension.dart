import 'package:logger/logger.dart';

extension LogX on Object {
  void log() => Logger()..d(toString());
}
