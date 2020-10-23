import 'package:flutter/material.dart';

class MPSPAppTheme {
  MPSPAppTheme._();
  static const Color red = Color.fromRGBO(197, 23, 24, 1);
  static const Color yellow = Color.fromRGBO(254, 253, 20, 1);
  static const Color grey = Color.fromRGBO(135, 135, 135, 1);
  static const int big = 20;
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
