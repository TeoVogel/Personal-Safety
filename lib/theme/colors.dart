import 'package:flutter/material.dart';

const themeColor = Color(0xFF202731);

const colorPrimary = Color.fromRGBO(29, 73, 167, 1);
Color colorPrimary20 = lighten(colorPrimary, 80);
Color colorPrimary40 = lighten(colorPrimary, 60);
Color colorPrimary80 = lighten(colorPrimary, 20);
const onColorPrimary = Colors.white;
const colorSecondary = Color(0xFFE6AE47);
const onColorSecondary = Colors.white;
const colorAccent = colorSecondary;
Color colorBackground = lighten(colorPrimary, 90);
const onColorBackground = Colors.black;
Color colorSurface = lighten(colorPrimary, 98);
const onColorSurface = onColorBackground;

/// Construct a color from a hex code string, of the format #RRGGBB.
Color hexToColor(String code) {
  return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}

Color lighten(Color c, [int percent = 10]) {
  assert(1 <= percent && percent <= 100);
  var p = percent / 100;
  return Color.fromARGB(
      c.alpha,
      c.red + ((255 - c.red) * p).round(),
      c.green + ((255 - c.green) * p).round(),
      c.blue + ((255 - c.blue) * p).round());
}
