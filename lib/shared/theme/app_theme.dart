import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  static ThemeMode get defaultMode => ThemeMode.system;

  static const _markaziTextThemeLight = TextTheme(
    displayLarge: TextStyle(color: Colors.black87),
    headlineLarge: TextStyle(color: Colors.black87),
    titleLarge: TextStyle(color: Colors.black87),
  );

  static const _markaziTextThemeDark = TextTheme(
    displayLarge: TextStyle(color: Colors.white),
    headlineLarge: TextStyle(color: Colors.white),
    titleLarge: TextStyle(color: Colors.white),
  );

  static ThemeData get lightTheme {
    return FlexThemeData.light(
      colors: const FlexSchemeColor(
        primary: Color(0xFF7209B7), // Darker purple for light mode
        primaryContainer: Color(0xFFE1BEE7), // Light purple
        secondary: Color(0xFFD81B60), // Darker pink for light mode
        secondaryContainer: Color(0xFFFCE4EC), // Light pink
        tertiary: Color(0xFF0288D1), // Darker blue for light mode
        tertiaryContainer: Color(0xFFE1F5FE), // Light blue
        appBarColor: Color(0xFF7209B7),
        error: Color(0xFFE65100), // Darker orange for light mode
      ),
      surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      blendLevel: 7,
      appBarStyle: FlexAppBarStyle.primary,
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 10,
        useM2StyleDividerInM3: true,
        thinBorderWidth: 1.5,
        filledButtonRadius: 12,
        elevatedButtonRadius: 12,
        elevatedButtonSchemeColor: SchemeColor.onPrimary,
        elevatedButtonSecondarySchemeColor: SchemeColor.primary,
        chipSelectedSchemeColor: SchemeColor.secondary,
        chipRadius: 12,
        thickBorderWidth: 2,
        outlinedButtonRadius: 12,
        cardRadius: 16,
        popupMenuRadius: 12,
        dialogRadius: 20,
        tooltipRadius: 8,
        bottomSheetRadius: 24,
        inputDecoratorRadius: 12,
        inputDecoratorFocusedBorderWidth: 2,
      ),
      keyColors: const FlexKeyColors(
        useSecondary: true,
        useTertiary: true,
      ),
      useMaterial3ErrorColors: true,
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      swapLegacyOnMaterial3: true,
      textTheme: GoogleFonts.outfitTextTheme(),
      primaryTextTheme:
          GoogleFonts.markaziTextTextTheme(_markaziTextThemeLight),
      fontFamily: GoogleFonts.outfit().fontFamily,
    );
  }

  static ThemeData get darkTheme {
    return FlexThemeData.dark(
      colors: const FlexSchemeColor(
        primary: Color(0xFF9D4EDD), // Purple from logo
        primaryContainer: Color(0xFF7209B7), // Darker purple
        secondary: Color(0xFFFF1B8D), // Pink/Magenta from logo
        secondaryContainer: Color(0xFFE91E63), // Darker pink
        tertiary: Color(0xFF4CC9F0), // Blue from logo
        tertiaryContainer: Color(0xFF0288D1), // Darker blue
        appBarColor: Color(0xFF000000), // Pure black
        error: Color(0xFFFF073A), // Neon red for errors
      ),
      surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
      blendLevel: 2, // Lower blend for more contrast
      appBarStyle: FlexAppBarStyle.surface, // Black app bar
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 5,
        useM2StyleDividerInM3: true,
        thinBorderWidth: 1.5,
        thickBorderWidth: 2,
        filledButtonRadius: 12,
        elevatedButtonRadius: 12,
        elevatedButtonSchemeColor: SchemeColor.onPrimaryContainer,
        elevatedButtonSecondarySchemeColor: SchemeColor.primaryContainer,
        outlinedButtonRadius: 12,
        chipSelectedSchemeColor: SchemeColor.secondary,
        chipRadius: 12,
        cardRadius: 16,
        popupMenuRadius: 12,
        dialogRadius: 20,
        tooltipRadius: 8,
        bottomSheetRadius: 24,
        inputDecoratorRadius: 12,
        inputDecoratorFocusedBorderWidth: 2,
      ),
      keyColors: const FlexKeyColors(
        useSecondary: true,
        useTertiary: true,
      ),
      useMaterial3ErrorColors: true,
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      swapLegacyOnMaterial3: true,
      textTheme: GoogleFonts.outfitTextTheme(),
      primaryTextTheme: GoogleFonts.markaziTextTextTheme(_markaziTextThemeDark),
      fontFamily: GoogleFonts.outfit().fontFamily,
    );
  }
}
