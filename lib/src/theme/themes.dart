// light theme
import 'package:flutter/material.dart';
import 'package:save_it/src/theme/colors.dart';

const String kFont = 'Poppins';

final ThemeData lightTheme = ThemeData(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  scaffoldBackgroundColor: const Color(0xFFB3CDE0),
  colorScheme: const ColorScheme.light(
    background: Color(0xFFB3CDE0),
    primary: Color(0xFF03396C),
    onPrimary: Color(0xFF6497B1),
    secondary: Color(0xFF6497B1),
    onSecondary: Color(0xFF011F4B),
    surface: Color(0xFFF5F5F5),
    onSurface: Color(0xFF000000),
    tertiary: Color(0xFF6497B1),
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: Color(0xFFD9D9D9),
    textTheme: ButtonTextTheme.accent,
  ),
  textTheme: const TextTheme(
    headline1: TextStyle(
      fontFamily: kFont,
      fontSize: 38,
      fontWeight: FontWeight.w600,
      color: Color(0xFF011F4B),
    ),
    headline2: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w500,
      fontFamily: kFont,
      color: Color(0xFF011F4B),
    ),
    headline3: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w200,
      fontFamily: kFont,
      color: Color(0xFF03396C),
    ),
    headline4: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      fontFamily: kFont,
      color: Color(0xFF03396C),
      // color: Color(0xFFB31209),
    ),
    headline5: TextStyle(
      fontSize: 16,
      fontFamily: kFont,
      fontWeight: FontWeight.normal,
      color: Color(0xFF03396C),
      // color: Color(0xFFB31209),
    ),
    headline6: TextStyle(
      fontSize: 16,
      fontFamily: kFont,
      fontWeight: FontWeight.w500,
      color: textImportant,
    ),
    bodyText1: TextStyle(
      fontSize: 16,
      // color: Color(0xFFB33D00),
      fontFamily: kFont,
    ),
    bodyText2: TextStyle(
      fontSize: 14,
      // color: Color(0xFFB33D00),
      fontFamily: kFont,
    ),
    subtitle1: TextStyle(
      fontSize: 14,
      color: Color(0xFF03396C),
      fontWeight: FontWeight.w500,
      fontFamily: kFont,
    ),
    caption: TextStyle(
      fontSize: 14,
      color: Color(0xFF03396C),
      fontFamily: kFont,
    ),
    button: TextStyle(
      fontSize: 14,
      color: Colors.white,
      fontFamily: kFont,
    ),
  ),
);

// dark theme
final ThemeData darkTheme = ThemeData.dark().copyWith(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFF5F6368),
    onPrimary: Color(0xFF5F6368),
    secondary: Color(0xFF3C4043),
    onSecondary: Color(0xFF0E1013),
    surface: Color(0xFFF5F5F5),
    onSurface: Color(0xFF000000),
    tertiary: Color(0xFF2E3134),
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: darkPrimary,
    textTheme: ButtonTextTheme.primary,
  ),
  textTheme: const TextTheme(
    headline1: TextStyle(
      fontFamily: kFont,
      fontSize: 38,
      fontWeight: FontWeight.w600,
      // color: Color(0xFF694E4E),
    ),
    headline2: TextStyle(
      fontSize: 32,
      color: darkTextHeader,
      fontWeight: FontWeight.w200,
      fontFamily: kFont,
    ),
    headline3: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w200,
      fontFamily: kFont,
      // color: darkTextHeader,
    ),
    headline4: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      fontFamily: kFont,
      color: darkTextHeader,
    ),
    headline5: TextStyle(
      fontSize: 16,
      fontFamily: kFont,
      fontWeight: FontWeight.normal,
      color: darkTextImportant,
    ),
    headline6: TextStyle(
      fontSize: 16,
      fontFamily: kFont,
      fontWeight: FontWeight.w500,
      color: darkTextImportant,
    ),
    bodyText1: TextStyle(
      fontSize: 16,
      color: darkTextBody,
      fontFamily: kFont,
    ),
    bodyText2: TextStyle(
      fontSize: 14,
      color: darkTextImportant,
      fontFamily: kFont,
    ),
    caption: TextStyle(
      fontSize: 14,
      color: darkTextBody,
      fontFamily: kFont,
    ),
    subtitle1: TextStyle(
      fontSize: 14,
      color: darkTextSubtitle,
      fontWeight: FontWeight.w500,
      fontFamily: kFont,
    ),
    button: TextStyle(
      fontSize: 14,
      color: Colors.black38,
      fontFamily: kFont,
    ),
  ),
);
