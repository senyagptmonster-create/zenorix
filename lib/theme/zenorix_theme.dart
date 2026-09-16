import 'package:flutter/material.dart';

class ZenorixTheme {
  static const bg = Color(0xFF090B10);
  static const surface = Color(0xFF121520);
  static const edge = Color(0xFF1E2335);
  static const accent = Color(0xFF6366F1);
  static const accentLight = Color(0xFF818CF8);
  static const ink = Color(0xFFEEF2FF);
  static const muted = Color(0xFF94A3B8);

  static ThemeData get themeData {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: bg,
      fontFamily: 'AppFont',
      primaryColor: accent,
      colorScheme: const ColorScheme.dark(
        primary: accent,
        surface: surface,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: bg,
        elevation: 0,
        foregroundColor: ink,
      ),
    );
  }
}
