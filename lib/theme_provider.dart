import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Verschiedene App-Themen
enum AppTheme {
  light,
  dark,
  colorful,
}

// Verschiedene Text-Themen
enum AppTextTheme {
  openSans,
  margarine,
  permanentMarker,
}

class ThemeProvider extends ChangeNotifier {
  ThemeData _currentTheme = ThemeData.light();
  TextTheme _currentTextTheme = GoogleFonts.openSansTextTheme();
  FontWeight _fontWeight = FontWeight.normal;

  ThemeData get lightTheme {
    return ThemeData.light().copyWith(
      textTheme: _currentTextTheme.copyWith(
        bodyLarge:
            _currentTextTheme.bodyLarge?.copyWith(fontWeight: _fontWeight),
        bodyMedium:
            _currentTextTheme.bodyMedium?.copyWith(fontWeight: _fontWeight),
      ),
      appBarTheme: AppBarTheme(
        color: Colors.black26,
        titleTextStyle: _currentTextTheme.titleLarge?.copyWith(
          color: Colors.white,
          fontSize: 20, // Hier die gewünschte Schriftgröße einstellen
        ),
      ),
    );
  }

  ThemeData get darkTheme {
    return ThemeData.dark().copyWith(
      textTheme: _currentTextTheme.copyWith(
        bodyLarge:
            _currentTextTheme.bodyLarge?.copyWith(fontWeight: _fontWeight),
        bodyMedium:
            _currentTextTheme.bodyMedium?.copyWith(fontWeight: _fontWeight),
      ),
      appBarTheme: AppBarTheme(
        color: Colors.black,
        titleTextStyle: _currentTextTheme.titleLarge?.copyWith(
          color: Colors.white,
          fontSize: 20, // Hier die gewünschte Schriftgröße einstellen
        ),
      ),
    );
  }

  ThemeData get colorfulTheme {
    return ThemeData(
      primarySwatch: Colors.orange,
      textTheme: _currentTextTheme.copyWith(
        bodyLarge:
            _currentTextTheme.bodyLarge?.copyWith(fontWeight: _fontWeight),
        bodyMedium:
            _currentTextTheme.bodyMedium?.copyWith(fontWeight: _fontWeight),
      ),
      appBarTheme: AppBarTheme(
        color: Colors.orange,
        titleTextStyle: _currentTextTheme.titleLarge?.copyWith(
          color: Colors.white,
          fontSize: 20, // Hier die gewünschte Schriftgröße einstellen
        ),
      ),
    );
  }

  ThemeData get currentTheme {
    if (_currentTheme == ThemeData.light()) {
      return lightTheme;
    } else if (_currentTheme == ThemeData.dark()) {
      return darkTheme;
    } else {
      return colorfulTheme;
    }
  }

  TextStyle get titleTextStyle =>
      _currentTheme.appBarTheme.titleTextStyle ??
      TextStyle(
        color: _currentTheme.colorScheme.onPrimary,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      );

  void setTheme(AppTheme theme) {
    switch (theme) {
      case AppTheme.light:
        _currentTheme = ThemeData.light();
        break;
      case AppTheme.dark:
        _currentTheme = ThemeData.dark();
        break;
      case AppTheme.colorful:
        _currentTheme = ThemeData(primarySwatch: Colors.orange);
        break;
    }
    notifyListeners();
  }

  void setFontTheme(AppTextTheme fontTheme) {
    switch (fontTheme) {
      case AppTextTheme.openSans:
        _currentTextTheme = GoogleFonts.openSansTextTheme();
        break;
      case AppTextTheme.margarine:
        _currentTextTheme = GoogleFonts.margarineTextTheme();
        break;
      case AppTextTheme.permanentMarker:
        _currentTextTheme = GoogleFonts.permanentMarkerTextTheme();
        break;
    }
    notifyListeners();
  }
}
