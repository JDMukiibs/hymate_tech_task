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
      scheme: FlexScheme.green,
      surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      blendLevel: 7,
      appBarStyle: FlexAppBarStyle.primary,
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 10,
        blendOnColors: false,
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
      scheme: FlexScheme.green,
      surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      blendLevel: 13,
      // appBarStyle: FlexAppBarStyle.surface, // Black app bar
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 20,
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
