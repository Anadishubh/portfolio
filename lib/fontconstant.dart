import 'package:flutter/material.dart';

class FontConstant {
  FontConstant._();

  static const String fontFamily = 'Roboto';
  static const String fontLeauge = 'Leauge';
  static const String fontTitanium = 'Titanium';

  static TextStyle styleMedium({
    required double fontSize,
    required Color color,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w500,
      fontSize: fontSize,
      color: color,
    );
  }

  static TextStyle styleBold({
    required double fontSize,
    required Color color,
  }) {
    return TextStyle(
      fontFamily: fontLeauge,
      fontWeight: FontWeight.w800,
      fontSize: fontSize,
      color: color,
    );
  }

  static TextStyle styleBlack({
    required double fontSize,
    required Color color,
  }) {
    return TextStyle(
      fontFamily: fontLeauge,
      fontWeight: FontWeight.w900,
      fontSize: fontSize,
      color: color,
    );
  }
  static TextStyle styleTitanium({
    required double fontSize,
    required Color color,
  }) {
    return TextStyle(
      fontFamily: fontTitanium,
      fontWeight: FontWeight.w800,
      fontSize: fontSize,
      color: color,
    );
  }
}
