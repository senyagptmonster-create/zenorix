import 'package:flutter/material.dart';

class ZenorixPalette {
  static const Color darkCosmos = Color(0xFF0F111A);
  static const Color cardBg = Color(0xFF1B1E2E);
  static const Color sphereElectricBlue = Color(0xFF4361EE);
  static const Color sphereNeonPurple = Color(0xFF7209B7);
  static const Color textBright = Color(0xFFF1F5F9);
  static const Color textDim = Color(0xFF94A3B8);

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'AppFont',
      brightness: Brightness.dark,
      scaffoldBackgroundColor: darkCosmos,
      colorScheme: const ColorScheme.dark(
        primary: sphereElectricBlue,
        secondary: sphereNeonPurple,
        surface: cardBg,
        onSurface: textBright,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: darkCosmos,
        foregroundColor: textBright,
        elevation: 0,
      ),
    );
  }
}
