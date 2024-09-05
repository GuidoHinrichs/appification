import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static MaterialScheme lightScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff00687a),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffadecff),
      onPrimaryContainer: Color(0xff001f26),
      secondary: Color(0xff4b6269),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffcee7ef),
      onSecondaryContainer: Color(0xff061f25),
      tertiary: Color(0xff575c7e),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffdee1ff),
      onTertiaryContainer: Color(0xff131937),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      background: Color(0xfff5fafc),
      onBackground: Color(0xff171c1e),
      surface: Color(0xfff5fafc),
      onSurface: Color(0xff171c1e),
      surfaceVariant: Color(0xffdbe4e7),
      onSurfaceVariant: Color(0xff3f484b),
      outline: Color(0xff70797c),
      outlineVariant: Color(0xffbfc8cb),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2c3133),
      inverseOnSurface: Color(0xffecf2f4),
      inversePrimary: Color(0xff85d2e7),
      primaryFixed: Color(0xffadecff),
      onPrimaryFixed: Color(0xff001f26),
      primaryFixedDim: Color(0xff85d2e7),
      onPrimaryFixedVariant: Color(0xff004e5d),
      secondaryFixed: Color(0xffcee7ef),
      onSecondaryFixed: Color(0xff061f25),
      secondaryFixedDim: Color(0xffb2cbd3),
      onSecondaryFixedVariant: Color(0xff334a51),
      tertiaryFixed: Color(0xffdee1ff),
      onTertiaryFixed: Color(0xff131937),
      tertiaryFixedDim: Color(0xffbfc4eb),
      onTertiaryFixedVariant: Color(0xff3f4565),
      surfaceDim: Color(0xffd5dbdd),
      surfaceBright: Color(0xfff5fafc),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff4f7),
      surfaceContainer: Color(0xffe9eff1),
      surfaceContainerHigh: Color(0xffe4e9eb),
      surfaceContainerHighest: Color(0xffdee3e5),
    );
  }

  ThemeData light() {
    return theme(
      lightScheme().toColorScheme(),
      textTheme: textTheme,
    );
  }

  static MaterialScheme colorfulScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xffFFA726), // Orange
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffffe0b2),
      onPrimaryContainer: Color(0xff3e2723),
      secondary: Color(0xffE57373), // Red
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffffcccb),
      onSecondaryContainer: Color(0xff4a1c1c),
      tertiary: Color(0xff81C784), // Green
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffe8f5e9),
      onTertiaryContainer: Color(0xff1b5e20),
      error: Color(0xffd32f2f),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffe0e0),
      onErrorContainer: Color(0xffc62828),
      background: Color(0xffBBDEFB), // Light Blue
      onBackground: Color(0xff1a237e),
      surface: Color(0xffBBDEFB),
      onSurface: Color(0xff1a237e),
      surfaceVariant: Color(0xffe3f2fd),
      onSurfaceVariant: Color(0xff1976d2),
      outline: Color(0xff4CAF50), // Green Outline
      outlineVariant: Color(0xffC8E6C9),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff212121),
      inverseOnSurface: Color(0xffE0E0E0),
      inversePrimary: Color(0xffFF7043),
      primaryFixed: Color(0xffffcc80),
      onPrimaryFixed: Color(0xff3e2723),
      primaryFixedDim: Color(0xffffb74d),
      onPrimaryFixedVariant: Color(0xffbf360c),
      secondaryFixed: Color(0xffffcdd2),
      onSecondaryFixed: Color(0xff4a1c1c),
      secondaryFixedDim: Color(0xffef9a9a),
      onSecondaryFixedVariant: Color(0xffb71c1c),
      tertiaryFixed: Color(0xffc8e6c9),
      onTertiaryFixed: Color(0xff1b5e20),
      tertiaryFixedDim: Color(0xffa5d6a7),
      onTertiaryFixedVariant: Color(0xff2e7d32),
      surfaceDim: Color(0xffbbdefb),
      surfaceBright: Color(0xffbbdefb),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffe3f2fd),
      surfaceContainer: Color(0xffe3f2fd),
      surfaceContainerHigh: Color(0xffbbdefb),
      surfaceContainerHighest: Color(0xffbbdefb),
    );
  }

  ThemeData colorful() {
    return theme(
      colorfulScheme().toColorScheme(),
      textTheme: textTheme,
    );
  }

  static MaterialScheme darkScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xff85d2e7),
      onPrimary: Color(0xff00363f),
      primaryContainer: Color(0xff004e5d),
      onPrimaryContainer: Color(0xffadecff),
      secondary: Color(0xffb2cbd3),
      onSecondary: Color(0xff1d343a),
      secondaryContainer: Color(0xff334a51),
      onSecondaryContainer: Color(0xffcee7ef),
      tertiary: Color(0xffbfc4eb),
      onTertiary: Color(0xff282e4d),
      tertiaryContainer: Color(0xff3f4565),
      onTertiaryContainer: Color(0xffdee1ff),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      background: Color(0xff171c1e),
      onBackground: Color(0xffe0e3e4),
      surface: Color(0xff171c1e),
      onSurface: Color(0xffe0e3e4),
      surfaceVariant: Color(0xff3f484b),
      onSurfaceVariant: Color(0xffbfc8cb),
      outline: Color(0xff899295),
      outlineVariant: Color(0xff3f484b),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe0e3e4),
      inverseOnSurface: Color(0xff2c3133),
      inversePrimary: Color(0xff00687a),
      primaryFixed: Color(0xffadecff),
      onPrimaryFixed: Color(0xff001f26),
      primaryFixedDim: Color(0xff85d2e7),
      onPrimaryFixedVariant: Color(0xff004e5d),
      secondaryFixed: Color(0xffcee7ef),
      onSecondaryFixed: Color(0xff061f25),
      secondaryFixedDim: Color(0xffb2cbd3),
      onSecondaryFixedVariant: Color(0xff334a51),
      tertiaryFixed: Color(0xffdee1ff),
      onTertiaryFixed: Color(0xff131937),
      tertiaryFixedDim: Color(0xffbfc4eb),
      onTertiaryFixedVariant: Color(0xff3f4565),
      surfaceDim: Color(0xff171c1e),
      surfaceBright: Color(0xff303638),
      surfaceContainerLowest: Color(0xff0d1112),
      surfaceContainerLow: Color(0xff171c1e),
      surfaceContainer: Color(0xff1c2224),
      surfaceContainerHigh: Color(0xff22282a),
      surfaceContainerHighest: Color(0xff2c3133),
    );
  }

  ThemeData dark() {
    final MaterialScheme scheme =
        darkScheme(); // Ruft die Methode auf und speichert das Ergebnis in scheme

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme.toColorScheme(), // Verwende das Schema
      textTheme: GoogleFonts.openSansTextTheme().apply(
        bodyColor: scheme.onSurface, // Zugreifen auf scheme.onSurface
        displayColor: scheme.onSurface,
      ),
      appBarTheme: AppBarTheme(
        foregroundColor: scheme.onPrimary, // Zugreifen auf scheme.onPrimary
        backgroundColor: scheme.primary,
      ),
    );
  }

  ThemeData theme(
    ColorScheme colorScheme, {
    required TextTheme textTheme,
  }) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: textTheme.apply(
        bodyColor: colorScheme.onSurface, // Körpertextfarbe
        displayColor: colorScheme.onSurface, // Anzeige-Textfarbe
      ),
      appBarTheme: AppBarTheme(
        foregroundColor: colorScheme.onPrimary, // AppBar Textfarbe
        backgroundColor: colorScheme.primary, // AppBar Hintergrundfarbe
      ),
    );
  }
}

class MaterialScheme {
  final Brightness brightness;
  final Color primary;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;
  final Color tertiary;
  final Color onTertiary;
  final Color tertiaryContainer;
  final Color onTertiaryContainer;
  final Color error;
  final Color onError;
  final Color errorContainer;
  final Color onErrorContainer;
  final Color background;
  final Color onBackground;
  final Color surface;
  final Color onSurface;
  final Color surfaceVariant;
  final Color onSurfaceVariant;
  final Color outline;
  final Color outlineVariant;
  final Color shadow;
  final Color scrim;
  final Color inverseSurface;
  final Color inverseOnSurface;
  final Color inversePrimary;
  final Color primaryFixed;
  final Color onPrimaryFixed;
  final Color primaryFixedDim;
  final Color onPrimaryFixedVariant;
  final Color secondaryFixed;
  final Color onSecondaryFixed;
  final Color secondaryFixedDim;
  final Color onSecondaryFixedVariant;
  final Color tertiaryFixed;
  final Color onTertiaryFixed;
  final Color tertiaryFixedDim;
  final Color onTertiaryFixedVariant;
  final Color surfaceDim;
  final Color surfaceBright;
  final Color surfaceContainerLowest;
  final Color surfaceContainerLow;
  final Color surfaceContainer;
  final Color surfaceContainerHigh;
  final Color surfaceContainerHighest;

  const MaterialScheme({
    required this.brightness,
    required this.primary,
    required this.onPrimary,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.secondary,
    required this.onSecondary,
    required this.secondaryContainer,
    required this.onSecondaryContainer,
    required this.tertiary,
    required this.onTertiary,
    required this.tertiaryContainer,
    required this.onTertiaryContainer,
    required this.error,
    required this.onError,
    required this.errorContainer,
    required this.onErrorContainer,
    required this.background,
    required this.onBackground,
    required this.surface,
    required this.onSurface,
    required this.surfaceVariant,
    required this.onSurfaceVariant,
    required this.outline,
    required this.outlineVariant,
    required this.shadow,
    required this.scrim,
    required this.inverseSurface,
    required this.inverseOnSurface,
    required this.inversePrimary,
    required this.primaryFixed,
    required this.onPrimaryFixed,
    required this.primaryFixedDim,
    required this.onPrimaryFixedVariant,
    required this.secondaryFixed,
    required this.onSecondaryFixed,
    required this.secondaryFixedDim,
    required this.onSecondaryFixedVariant,
    required this.tertiaryFixed,
    required this.onTertiaryFixed,
    required this.tertiaryFixedDim,
    required this.onTertiaryFixedVariant,
    required this.surfaceDim,
    required this.surfaceBright,
    required this.surfaceContainerLowest,
    required this.surfaceContainerLow,
    required this.surfaceContainer,
    required this.surfaceContainerHigh,
    required this.surfaceContainerHighest,
  });

  ColorScheme toColorScheme() {
    return ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSecondaryContainer,
      tertiary: tertiary,
      onTertiary: onTertiary,
      tertiaryContainer: tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer,
      error: error,
      onError: onError,
      errorContainer: errorContainer,
      onErrorContainer: onErrorContainer,
      surface: surface,
      onSurface: onSurface,
      surfaceContainerHighest: surfaceVariant,
      onSurfaceVariant: onSurfaceVariant,
      outline: outline,
      shadow: shadow,
      scrim: scrim,
      inverseSurface: inverseSurface,
      onInverseSurface: inverseOnSurface,
      inversePrimary: inversePrimary,
    );
  }
}
