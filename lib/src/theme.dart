import "package:flutter/material.dart";

class CustomTheme {
  static ThemeData getLightTheme() {
    return ThemeData.from(
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF0D2E0F),
        brightness: Brightness.light,
        surface: const Color(0xffF5F5F5),
        onSurface: const Color(0xff141414),
        tertiary: const Color(0xffEEEEEE),
        onTertiary: const Color(0xff616161),
      ),
    );
  }

  static ThemeData getDarkTheme() {
    return ThemeData.from(
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xff388E3C),
        brightness: Brightness.dark,
        surface: const Color(0xff141414),
        onSurface: const Color(0xffF5F5F5),
        tertiary: const Color(0xff616161),
        onTertiary: const Color(0xffEEEEEE),
      ),
    );
  }
}
