import 'package:flutter/material.dart';
import 'package:personal_safety/theme/colors.dart';

abstract class ThemeUtils {
  static final ThemeData myTheme = ThemeData.from(
    colorScheme: ColorScheme.light(
      primary: colorPrimary,
      onPrimary: onColorPrimary,
      secondary: colorSecondary,
      onSecondary: onColorSecondary,
      background: colorBackground,
      onBackground: onColorBackground,
      surface: colorSurface,
      onSurface: onColorSurface,
    ),
  ).copyWith(
    scaffoldBackgroundColor: colorBackground,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: smallShape,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
          shape: smallShape,
          side: BorderSide(width: borderSideWidth, color: colorPrimary),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          backgroundColor: Colors.white),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        shape: smallShape,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      ),
    ),
    cardTheme: CardTheme(
        shape: mediumShape.copyWith(
            side: BorderSide(
          width: borderSideWidth,
          color: colorPrimary80,
        )),
        elevation: 1),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: smallShapeBorderRadius),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(),
    chipTheme: ChipThemeData.fromDefaults(
      primaryColor: colorPrimary,
      secondaryColor: colorSecondary,
      labelStyle: const TextStyle(),
    ),
  );

  static final alertDialogTextButtonStyle = TextButton.styleFrom(
    shape: smallShape,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
  );

  static const double smallShapeBorderRadiusAmount = 12;
  static const double mediumShapeBorderRadiusAmount = 16;
  static const double largeShapeBorderRadiusAmount = 20;

  static final smallShapeBorderRadius =
      BorderRadius.circular(smallShapeBorderRadiusAmount);
  static final mediumShapeBorderRadius =
      BorderRadius.circular(mediumShapeBorderRadiusAmount);
  static final largeShapeBorderRadius =
      BorderRadius.circular(largeShapeBorderRadiusAmount);

  static final smallShape =
      RoundedRectangleBorder(borderRadius: smallShapeBorderRadius);
  static final mediumShape =
      RoundedRectangleBorder(borderRadius: mediumShapeBorderRadius);
  static final largeShape =
      RoundedRectangleBorder(borderRadius: largeShapeBorderRadius);

  static final double borderSideWidth = 1;

  static ButtonStyle getGoBackButtonStyle() {
    return ElevatedButton.styleFrom(
      primary: Colors.white,
      onPrimary: Colors.black,
      shape: smallShape,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
    );
  }

  static ButtonStyle getDeleteButtonStyle() {
    return OutlinedButton.styleFrom(
      primary: Colors.red,
      side: BorderSide(width: borderSideWidth, color: Colors.red),
      shape: smallShape,
    );
  }
}
