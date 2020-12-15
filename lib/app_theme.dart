import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();
  static const darkPurple = Color.fromRGBO(102, 114, 228, 1);
  static const lightPurple = Color.fromRGBO(129, 158, 252, 1);
  static const offWhite = Color.fromRGBO(247, 249, 252, 1);
  static const pink = Color.fromRGBO(255, 185, 246, 1);
  static const lightBlue = Color.fromRGBO(196, 240, 255, 1);

  // static const Color darkText = Color(0xFF253840);
  // static const Color darkerText = Color(0xFF17262A);
  static const Color lightText = Color(0xFF757575);
  // static const Color deactivatedText = Color(0xFF767676);
  // static const Color dismissibleBackground = Color(0xFF364A54);
  // static const Color spacer = Color(0xFFF2F2F2);
  static const String fontName = 'Roboto';
  static const String headingFont = 'Rubik';

  static const double iconWidth = 26;
  static const double iconHeight = 26;

  static const Radius borderRadius = Radius.circular(20.0);

  static const LinearGradient linearGradient = LinearGradient(
    colors: [
      AppTheme.pink,
      AppTheme.lightPurple,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient linearGradientReversed = LinearGradient(
    colors: [
      AppTheme.lightPurple,
      AppTheme.pink,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const TextTheme textTheme = TextTheme(
    headline1: headline1,
    headline2: headline2,
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
    fontSize: 36,
    letterSpacing: 0.4,
    height: 0.9,
    color: pink,
  );

  static const TextStyle headline1 = TextStyle(
      color: pink,
      fontSize: 22,
      fontFamily: headingFont,
      fontWeight: FontWeight.normal);

  static const TextStyle headline2 = TextStyle(
    fontFamily: headingFont,
    fontWeight: FontWeight.bold,
    fontSize: 24,
    letterSpacing: 0.27,
    color: darkPurple,
  );

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
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: -0.05,
    color: darkPurple,
  );

  static const TextStyle label = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w500,
    fontSize: 18,
    letterSpacing: 0.2,
    color: lightText,
  );

  static const TextStyle input = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w600,
    fontSize: 18,
    letterSpacing: 0.2,
    color: darkPurple,
  );

  static const TextStyle inputError = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    letterSpacing: 0.2,
    color: pink,
  );
}
