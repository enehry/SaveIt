// light theme
import 'package:flutter/material.dart';
import 'package:save_it/src/theme/colors.dart';

const String kFont = 'Poppins';

final ThemeData lightTheme = ThemeData(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  colorScheme: const ColorScheme.light(
    background: background,
    primary: primary,
    onPrimary: background,
    secondary: secondaryButton,
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: Color(0xFFD9D9D9),
    textTheme: ButtonTextTheme.accent,
  ),
  textTheme: const TextTheme(
    headline2: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w500,
      fontFamily: kFont,
      color: textHeader,
    ),
    headline3: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w200,
      fontFamily: kFont,
      color: textHeader,
    ),
    headline4: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      fontFamily: kFont,
      color: textHeader,
    ),
    headline5: TextStyle(
      fontSize: 16,
      fontFamily: kFont,
      fontWeight: FontWeight.normal,
      color: textImportant,
    ),
    headline6: TextStyle(
      fontSize: 16,
      fontFamily: kFont,
      fontWeight: FontWeight.w500,
      color: textImportant,
    ),
    bodyText1: TextStyle(
      fontSize: 16,
      color: textBody,
      fontFamily: kFont,
    ),
    bodyText2: TextStyle(
      fontSize: 14,
      color: textImportant,
      fontFamily: kFont,
    ),
    subtitle1: TextStyle(
      fontSize: 14,
      color: textSubtitle,
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
      color: Colors.white70,
      fontFamily: kFont,
    ),
  ),
);

// dark theme
final ThemeData darkTheme = ThemeData.dark().copyWith(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  colorScheme: const ColorScheme.dark(
    background: darkBackground,
    primary: darkPrimary,
    secondary: darkSecondaryButton,
    onPrimary: textHeader,
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: darkPrimary,
    textTheme: ButtonTextTheme.primary,
  ),
  textTheme: const TextTheme(
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
