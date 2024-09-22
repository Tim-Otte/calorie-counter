import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff3c6a00),
      surfaceTint: Color(0xff3c6a00),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff78c518),
      onPrimaryContainer: Color(0xff152b00),
      secondary: Color(0xff3c3d3b),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff5f605e),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xffab3500),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffff713e),
      onTertiaryContainer: Color(0xff220500),
      error: Color(0xffa10c11),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffd63831),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffcf8f8),
      onSurface: Color(0xff1c1b1b),
      onSurfaceVariant: Color(0xff48464b),
      outline: Color(0xff79767b),
      outlineVariant: Color(0xffcac5cb),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff313030),
      inversePrimary: Color(0xff8cdb33),
      primaryFixed: Color(0xffa7f94f),
      onPrimaryFixed: Color(0xff0e2000),
      primaryFixedDim: Color(0xff8cdb33),
      onPrimaryFixedVariant: Color(0xff2c5000),
      secondaryFixed: Color(0xffe3e2df),
      onSecondaryFixed: Color(0xff1a1c1a),
      secondaryFixedDim: Color(0xffc7c6c4),
      onSecondaryFixedVariant: Color(0xff464745),
      tertiaryFixed: Color(0xffffdbd0),
      onTertiaryFixed: Color(0xff390c00),
      tertiaryFixedDim: Color(0xffffb59d),
      onTertiaryFixedVariant: Color(0xff832600),
      surfaceDim: Color(0xffdcd9d8),
      surfaceBright: Color(0xfffcf8f8),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff6f3f2),
      surfaceContainer: Color(0xfff1edec),
      surfaceContainerHigh: Color(0xffebe7e6),
      surfaceContainerHighest: Color(0xffe5e2e1),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff294b00),
      surfaceTint: Color(0xff3c6a00),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff4b8200),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff3c3d3b),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff5f605e),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff7c2400),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffcc4915),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff8c0009),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffd63831),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffcf8f8),
      onSurface: Color(0xff1c1b1b),
      onSurfaceVariant: Color(0xff444247),
      outline: Color(0xff615e63),
      outlineVariant: Color(0xff7d797f),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff313030),
      inversePrimary: Color(0xff8cdb33),
      primaryFixed: Color(0xff4b8200),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff3b6700),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff747572),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff5b5c5a),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xffcc4915),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xffa73300),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffdcd9d8),
      surfaceBright: Color(0xfffcf8f8),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff6f3f2),
      surfaceContainer: Color(0xfff1edec),
      surfaceContainerHigh: Color(0xffebe7e6),
      surfaceContainerHighest: Color(0xffe5e2e1),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff132700),
      surfaceTint: Color(0xff3c6a00),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff294b00),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff212321),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff424341),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff441000),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff7c2400),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff4e0003),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff8c0009),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffcf8f8),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff252328),
      outline: Color(0xff444247),
      outlineVariant: Color(0xff444247),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff313030),
      inversePrimary: Color(0xffbeff79),
      primaryFixed: Color(0xff294b00),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff1a3300),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff424341),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff2c2d2b),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff7c2400),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff561600),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffdcd9d8),
      surfaceBright: Color(0xfffcf8f8),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff6f3f2),
      surfaceContainer: Color(0xfff1edec),
      surfaceContainerHigh: Color(0xffebe7e6),
      surfaceContainerHighest: Color(0xffe5e2e1),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff8cdb33),
      surfaceTint: Color(0xff8cdb33),
      onPrimary: Color(0xff1d3700),
      primaryContainer: Color(0xff67b000),
      onPrimaryContainer: Color(0xff071300),
      secondary: Color(0xffc7c6c4),
      onSecondary: Color(0xff2f312f),
      secondaryContainer: Color(0xff464745),
      onSecondaryContainer: Color(0xffe1e1de),
      tertiary: Color(0xffffb59d),
      onTertiary: Color(0xff5d1900),
      tertiaryContainer: Color(0xffcc4915),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xffb51f1d),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xff131313),
      onSurface: Color(0xffe5e2e1),
      onSurfaceVariant: Color(0xffcac5cb),
      outline: Color(0xff938f95),
      outlineVariant: Color(0xff48464b),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe5e2e1),
      inversePrimary: Color(0xff3c6a00),
      primaryFixed: Color(0xffa7f94f),
      onPrimaryFixed: Color(0xff0e2000),
      primaryFixedDim: Color(0xff8cdb33),
      onPrimaryFixedVariant: Color(0xff2c5000),
      secondaryFixed: Color(0xffe3e2df),
      onSecondaryFixed: Color(0xff1a1c1a),
      secondaryFixedDim: Color(0xffc7c6c4),
      onSecondaryFixedVariant: Color(0xff464745),
      tertiaryFixed: Color(0xffffdbd0),
      onTertiaryFixed: Color(0xff390c00),
      tertiaryFixedDim: Color(0xffffb59d),
      onTertiaryFixedVariant: Color(0xff832600),
      surfaceDim: Color(0xff131313),
      surfaceBright: Color(0xff3a3939),
      surfaceContainerLowest: Color(0xff0e0e0e),
      surfaceContainerLow: Color(0xff1c1b1b),
      surfaceContainer: Color(0xff201f1f),
      surfaceContainerHigh: Color(0xff2a2a2a),
      surfaceContainerHighest: Color(0xff353534),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff90e037),
      surfaceTint: Color(0xff8cdb33),
      onPrimary: Color(0xff0b1a00),
      primaryContainer: Color(0xff67b000),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffcbcbc8),
      onSecondary: Color(0xff151715),
      secondaryContainer: Color(0xff90918e),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffffbba5),
      onTertiary: Color(0xff300900),
      tertiaryContainer: Color(0xfff26430),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffbab2),
      onError: Color(0xff370001),
      errorContainer: Color(0xfffe554a),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff131313),
      onSurface: Color(0xfffefaf9),
      onSurfaceVariant: Color(0xffcec9cf),
      outline: Color(0xffa6a1a7),
      outlineVariant: Color(0xff868287),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe5e2e1),
      inversePrimary: Color(0xff2d5100),
      primaryFixed: Color(0xffa7f94f),
      onPrimaryFixed: Color(0xff081400),
      primaryFixedDim: Color(0xff8cdb33),
      onPrimaryFixedVariant: Color(0xff213d00),
      secondaryFixed: Color(0xffe3e2df),
      onSecondaryFixed: Color(0xff101110),
      secondaryFixedDim: Color(0xffc7c6c4),
      onSecondaryFixedVariant: Color(0xff353635),
      tertiaryFixed: Color(0xffffdbd0),
      onTertiaryFixed: Color(0xff270600),
      tertiaryFixedDim: Color(0xffffb59d),
      onTertiaryFixedVariant: Color(0xff671c00),
      surfaceDim: Color(0xff131313),
      surfaceBright: Color(0xff3a3939),
      surfaceContainerLowest: Color(0xff0e0e0e),
      surfaceContainerLow: Color(0xff1c1b1b),
      surfaceContainer: Color(0xff201f1f),
      surfaceContainerHigh: Color(0xff2a2a2a),
      surfaceContainerHighest: Color(0xff353534),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xfff4ffe1),
      surfaceTint: Color(0xff8cdb33),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xff90e037),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xfffcfbf8),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffcbcbc8),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xfffff9f8),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffffbba5),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xfffff9f9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffbab2),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff131313),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xfffff9ff),
      outline: Color(0xffcec9cf),
      outlineVariant: Color(0xffcec9cf),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe5e2e1),
      inversePrimary: Color(0xff183000),
      primaryFixed: Color(0xffabfd53),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xff90e037),
      onPrimaryFixedVariant: Color(0xff0b1a00),
      secondaryFixed: Color(0xffe7e7e4),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffcbcbc8),
      onSecondaryFixedVariant: Color(0xff151715),
      tertiaryFixed: Color(0xffffe0d7),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffffbba5),
      onTertiaryFixedVariant: Color(0xff300900),
      surfaceDim: Color(0xff131313),
      surfaceBright: Color(0xff3a3939),
      surfaceContainerLowest: Color(0xff0e0e0e),
      surfaceContainerLow: Color(0xff1c1b1b),
      surfaceContainer: Color(0xff201f1f),
      surfaceContainerHigh: Color(0xff2a2a2a),
      surfaceContainerHighest: Color(0xff353534),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        textTheme: textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
        scaffoldBackgroundColor: colorScheme.surface,
        canvasColor: colorScheme.surface,
      );

  List<ExtendedColor> get extendedColors => [];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
