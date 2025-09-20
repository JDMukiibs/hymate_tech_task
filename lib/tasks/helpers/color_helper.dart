import 'package:flutter/material.dart';

class ColorHelper {
  ColorHelper._();

  static Color assignColorBasedOnHashCode(String input) {
    final hash = input.hashCode;
    return Colors.primaries[hash.abs() % Colors.primaries.length];
  }
}
