import 'package:flutter/material.dart';

class ColorHelper {
  ColorHelper._();

  static const List<Color> predefinedColors = [
    Color(0xFFE57373), // Red
    Color(0xFF81C784), // Green
    Color(0xFF64B5F6), // Blue
    Color(0xFFFFB74D), // Orange
    Color(0xFFBA68C8), // Purple
    Color(0xFFFF8A65), // Deep Orange
    Color(0xFF4DB6AC), // Teal
    Color(0xFFDCE775), // Lime
  ];

  static Color assignColorBasedOnHashCode(String input) {
    final hash = input.hashCode;
    return predefinedColors[hash.abs() % predefinedColors.length];
  }
}
