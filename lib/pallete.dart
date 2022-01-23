import 'package:flutter/material.dart';

class Pallete {
  static const MaterialColor starwarspallete =
      MaterialColor(_starwarspalletePrimaryValue, <int, Color>{
    50: Color(0xFFE0E0E0),
    100: Color(0xFFB3B3B3),
    200: Color(0xFF808080),
    300: Color(0xFF4D4D4D),
    400: Color(0xFF262626),
    500: Color(_starwarspalletePrimaryValue),
    600: Color(0xFF000000),
    700: Color(0xFF000000),
    800: Color(0xFF000000),
    900: Color(0xFF000000),
  });
  static const int _starwarspalletePrimaryValue = 0xFF000000;

  static const MaterialColor starwarspalleteAccent =
      MaterialColor(_starwarspalleteAccentValue, <int, Color>{
    100: Color(0xFFA6A6A6),
    200: Color(_starwarspalleteAccentValue),
    400: Color(0xFF737373),
    700: Color(0xFF666666),
  });
  static const int _starwarspalleteAccentValue = 0xFF8C8C8C;
}
