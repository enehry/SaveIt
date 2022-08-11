// light theme
import 'package:flutter/material.dart';
import 'package:save_it/src/theme/colors.dart';

const String kFont = 'Poppins';

final ThemeData lightTheme = ThemeData(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  scaffoldBackgroundColor: const Color.fromARGB(255, 255, 250, 250),
  colorScheme: const ColorScheme.light(
    background: Color.fromARGB(255, 209, 159, 159),
    primary: Color(0xFF694E4E),
    onPrimary: Color.fromARGB(255, 209, 159, 159),
    secondary: Color(0xFFC1A3A3),
    onSecondary: Color(0xFF662300),
    surface: Color(0xFFF5F5F5),
    onSurface: Color(0xFF000000),
    tertiary: Color(0xFFF3C5C5),
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
      color: Color(0xFF694E4E),
    ),
    headline2: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w500,
      fontFamily: kFont,
      color: Color(0xFF694E4E),
    ),
    headline3: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w200,
      fontFamily: kFont,
      // color: Color(0xFFB31209),
    ),
    headline4: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      fontFamily: kFont,
      // color: Color(0xFFB31209),
    ),
    headline5: TextStyle(
      fontSize: 16,
      fontFamily: kFont,
      fontWeight: FontWeight.normal,
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
      color: Colors.grey,
      fontWeight: FontWeight.w500,
      fontFamily: kFont,
    ),
    caption: TextStyle(
      fontSize: 14,
      color: Colors.grey,
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
    primary: Color(0xFF694E4E),
    onPrimary: Color.fromARGB(255, 209, 159, 159),
    secondary: Color(0xFFC1A3A3),
    onSecondary: Color(0xFF662300),
    surface: Color(0xFFF5F5F5),
    onSurface: Color(0xFF000000),
    tertiary: Color(0xFFF3C5C5),
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
      color: Color(0xFF694E4E),
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
      color: darkTextHeader,
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
      color: Colors.black87,
      fontFamily: kFont,
    ),
  ),
);
