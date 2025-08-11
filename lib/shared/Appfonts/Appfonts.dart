import 'package:flutter/material.dart';

class AppFonts {
  static const String headlineFont = 'Tajawal';
  static const String bodyFont = 'Cairo';
  static const String iconFont = 'ReemKufi';

  static TextStyle headlineStyle = const TextStyle(
    fontFamily: headlineFont,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static TextStyle bodyStyle = const TextStyle(
    fontFamily: bodyFont,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static TextStyle iconStyle = const TextStyle(
    fontFamily: iconFont,
    fontSize: 20,
    fontWeight: FontWeight.w500,
  );
}
