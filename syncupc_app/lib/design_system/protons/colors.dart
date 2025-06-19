import 'package:flutter/material.dart';

class AppColors {
  // Colores primarios (basados en tu app)\

  static const Color primary50 = Color(0xFFC8FF70);
  static const Color primary100 = Color(0xFFDCFCE7);
  static const Color primary200 = Color(0xFF81C618);
  static const Color primary300 = Color(0xFF86EFAC);
  static const Color primary400 = Color(0xFF4ADE80);
  static const Color primary500 = Color(0xFFB9FF50); // Verde principal
  static const Color primary600 = Color(0xFF16A34A);
  static const Color primary700 = Color(0xFF15803D);
  static const Color primary800 = Color(0xFF166534);
  static const Color primary900 = Color(0xFF14532D);

  //Colores para fuente
  static const Color nunitoBoldTime = Color(0xFF61605F);

  // Colores neutros
  static const Color white = Color(0xFFFFFFFF);
  static const Color neutral50 = Color(0xFFEEEEEE);
  static const Color neutral100 = Color(0xFFF5F5F5);
  static const Color neutral200 = Color(0xFFE5E5E5);
  static const Color neutral300 = Color(0xFFD4D4D4);
  static const Color neutral400 = Color(0xFFA3A3A3);
  static const Color neutral500 = Color(0xFF737373);
  static const Color neutral600 = Color(0xFF525252);
  static const Color neutral700 = Color(0xFF404040);
  static const Color neutral800 = Color(0xFF262626);
  static const Color neutral900 = Color(0xFF171717);

  // Colores semánticos
  static const Color success = Color(0xFF22C55E);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Fondos
  static final backgroundPrimary = _mixColors(
    baseColor: const Color(0xFFFFFFFF), // Blanco 100%
    overlayColor: const Color(0xFFC8FF70), // Verde 100%
    overlayOpacity: 0.1, // 10% de verde (ya que el blanco es 90%)
  );

  static Color _mixColors({
    required Color baseColor,
    required Color overlayColor,
    required double overlayOpacity,
  }) {
    final int baseRed = baseColor.red;
    final int baseGreen = baseColor.green;
    final int baseBlue = baseColor.blue;

    final int overlayRed = overlayColor.red;
    final int overlayGreen = overlayColor.green;
    final int overlayBlue = overlayColor.blue;

    final int mixedRed =
        (baseRed * (1 - overlayOpacity) + overlayRed * overlayOpacity).round();
    final int mixedGreen =
        (baseGreen * (1 - overlayOpacity) + overlayGreen * overlayOpacity)
            .round();
    final int mixedBlue =
        (baseBlue * (1 - overlayOpacity) + overlayBlue * overlayOpacity)
            .round();

    return Color.fromARGB(255, mixedRed, mixedGreen, mixedBlue);
  }

  static const Color backgroundSecondary = Color(0xFFF8FCF9);
  static const Color backgroundAccent = Color(0xFFF0FDF4);
}
