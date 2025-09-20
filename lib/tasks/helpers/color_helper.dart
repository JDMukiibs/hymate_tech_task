import 'dart:math' show Random;

import 'package:flutter/material.dart';

class ColorHelper {
  ColorHelper._();

  // Cache of assigned colors to ensure consistency
  static final Map<String, Color> _colorCache = {};
  static final Random _random = Random();

  static Color assignColorBasedOnHashCode(String input) {
    if (_colorCache.containsKey(input)) {
      return _colorCache[input]!;
    }

    // Generate a color based on the hash code to maintain consistency
    final hash = input.hashCode.abs();

    // Generate a hue value from 0-360
    final hue = (hash % 360).toDouble();

    // Use saturation and value to ensure colors are vibrant and not too dark/light
    // Vary saturation and value slightly to get more distinct colors
    final saturation = 0.5 + (_random.nextDouble() * 0.4); // 0.5 to 0.9
    final value = 0.6 + (_random.nextDouble() * 0.3); // 0.6 to 0.9

    final newColor = HSVColor.fromAHSV(1, hue, saturation, value).toColor();

    _colorCache[input] = newColor; // Cache the color
    return newColor;
  }
}
