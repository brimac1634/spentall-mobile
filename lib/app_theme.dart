import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();
  static const darkPurple = Color.fromRGBO(102, 114, 228, 1);
  static const darkerPurple = Color.fromRGBO(76, 85, 168, 1);
  static const lightPurple = Color.fromRGBO(129, 158, 252, 1);
  static const offWhite = Color.fromRGBO(247, 249, 252, 1);
  static const fadedOffWhite = Color.fromRGBO(247, 249, 252, 0.5);
  static const pink = Color.fromRGBO(255, 185, 246, 1);
  static const lightBlue = Color.fromRGBO(196, 240, 255, 1);

  static const Color lightText = Color(0xFF757575);
  static const String fontName = 'Roboto';
  static const String headingFont = 'Karla';

  static const double iconWidth = 26;
  static const double iconHeight = 26;

  static const Radius borderRadius = Radius.circular(20.0);

  static const LinearGradient linearGradient = LinearGradient(
    colors: [
      pink,
      lightPurple,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient linearGradientReversed = LinearGradient(
    colors: [
      lightPurple,
      pink,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient linearGradient2 = LinearGradient(
    colors: [
      offWhite,
      pink,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const TextTheme textTheme = TextTheme(
    headline1: headline1,
    headline2: headline2,
    headline3: headline3,
    headline4: display1,
    headline6: title,
    subtitle2: subtitle,
    bodyText2: body2,
    bodyText1: body1,
    caption: label,
  );

  static const TextStyle display1 = TextStyle(
    fontFamily: headingFont,
    fontWeight: FontWeight.normal,
    fontSize: 32,
    letterSpacing: 0.4,
    height: 0.9,
    color: offWhite,
  );

  static const TextStyle headline1 = TextStyle(
      color: pink,
      fontSize: 20,
      fontFamily: headingFont,
      fontWeight: FontWeight.normal);

  static const TextStyle headline2 = TextStyle(
    fontFamily: headingFont,
    fontWeight: FontWeight.bold,
    fontSize: 22,
    letterSpacing: 0.27,
    color: darkPurple,
  );

  static const TextStyle headline3 = TextStyle(
      color: AppTheme.offWhite,
      fontSize: 22,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.4);

  static const TextStyle headline4 = TextStyle(
      fontFamily: headingFont,
      color: darkPurple,
      fontSize: 20,
      letterSpacing: 0.27,
      fontWeight: FontWeight.bold);

  static const TextStyle headline5 = TextStyle(
      color: AppTheme.offWhite, fontSize: 24, fontWeight: FontWeight.bold);

  static const TextStyle title = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 16,
    letterSpacing: 0.18,
    color: darkPurple,
  );

  static const TextStyle subtitle = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: -0.04,
    color: lightPurple,
  );

  static const TextStyle body2 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.normal,
    fontSize: 16,
    letterSpacing: 0.2,
    color: darkPurple,
  );

  static const TextStyle body1 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 18,
    letterSpacing: -0.05,
    color: darkPurple,
  );

  static const TextStyle flatButton = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 18,
    letterSpacing: 0.2,
    color: darkPurple,
  );

  static const TextStyle cancel = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w500,
    fontSize: 18,
    letterSpacing: 0.2,
    color: lightText,
  );

  static const TextStyle label = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    letterSpacing: 0.2,
    color: lightText,
  );

  static const TextStyle label2 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    letterSpacing: 0.2,
    color: offWhite,
  );

  static const TextStyle label3 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    letterSpacing: 0.2,
    color: fadedOffWhite,
  );

  static const TextStyle input = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    letterSpacing: 0.2,
    color: darkPurple,
  );

  static const TextStyle inputError = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: 0.2,
    color: pink,
  );
}
