import 'package:flutter/material.dart';

abstract class _ColorScheme {
  final Color bg1;
  final Color bg2;
  final Color font;
  final Color button;

  _ColorScheme(
      {required this.bg1,
      required this.bg2,
      required this.font,
      required this.button});
}

class ColorSchemeDark extends _ColorScheme {
  ColorSchemeDark()
      : super(
          bg1: Colors.black,
          bg2: const Color.fromARGB(255, 31, 31, 31),
          font: Colors.white,
          button: const Color.fromARGB(255, 31, 31, 31),
        );
}

class ColorSchemeLight extends _ColorScheme {
  ColorSchemeLight()
      : super(
          bg1: Colors.white,
          bg2: Colors.white,
          font: Colors.black,
          button: const Color.fromARGB(255, 31, 31, 31),
        );
}
