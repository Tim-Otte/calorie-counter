import "package:flutter/material.dart";

class CustomTheme {
  static ThemeData getLightTheme() {
    return ThemeData.from(
      colorScheme: const ColorScheme.light(
        primary: Color(0xff3b6939),
        onPrimary: Color(0xffffffff),
        primaryContainer: Color(0xffbcf0b4),
        onPrimaryContainer: Color(0xff002204),
        secondary: Color(0xff52634f),
        onSecondary: Color(0xffffffff),
        secondaryContainer: Color(0xffd5e8cf),
        onSecondaryContainer: Color(0xff111f0f),
        tertiary: Color(0xff38656a),
        onTertiary: Color(0xffffffff),
        tertiaryContainer: Color(0xffbcebf0),
        onTertiaryContainer: Color(0xff002023),
        surface: Color(0xfff7fbf1),
        onSurface: Color(0xff191d17),
        surfaceContainerHighest: Color(0xffe0e4db),
        onSurfaceVariant: Color(0xff424940),
        outline: Color(0xff72796f),
        shadow: Color(0xff000000),
      ),
    );
  }

  static ThemeData getDarkTheme() {
    return ThemeData.from(
      colorScheme: const ColorScheme.dark(
        primary: Color(0xffa1d39a),
        onPrimary: Color(0xff0a390f),
        primaryContainer: Color(0xff235024),
        onPrimaryContainer: Color(0xffbcf0b4),
        secondary: Color(0xff296b2a),
        onSecondary: Color(0xffffffff),
        secondaryContainer: Color(0xff76bb6f),
        onSecondaryContainer: Color(0xff002203),
        tertiary: Color(0xff38656a),
        onTertiary: Color(0xffffffff),
        tertiaryContainer: Color(0xffbcebf0),
        onTertiaryContainer: Color(0xff002023),
        surface: Color(0xFF141414),
        onSurface: Color(0xffe0e4db),
        surfaceContainerHighest: Color(0xff323630),
        onSurfaceVariant: Color(0xffc2c9bd),
        outline: Color(0xff8c9388),
        shadow: Color(0xff0a0a0a),
      ),
    );
  }
}
