import 'package:flutter/material.dart';

abstract class _ColorScheme {
  final Color bg1;
  final Color bg2;
  final Color font;

  _ColorScheme({required this.bg1, required this.bg2, required this.font});
}

class ColorSchemeDark extends _ColorScheme{
  ColorSchemeDark() : super(bg1: Colors.black, bg2: Colors.white12, font: Colors.white);
}

class ColorSchemeLight extends _ColorScheme{
  ColorSchemeLight() : super(bg1: Colors.white, bg2: Colors.white, font: Colors.black);
}