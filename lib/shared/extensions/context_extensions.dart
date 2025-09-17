import 'package:flutter/material.dart';

extension BuildContextExtension<T> on BuildContext {
  ThemeData get theme => Theme.of(this);

  ScaffoldMessengerState get scaffold => ScaffoldMessenger.of(this);

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  Locale get locale => Localizations.localeOf(this);
}
