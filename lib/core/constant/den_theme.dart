import 'package:flutter/material.dart';

class DenTheme {
  static Color mainColor = const Color(0xFF31353D);
  static Color primaryColor = const Color(0xFF4798ED);
  static Color secondaryColor = const Color(0xFF135396);
  static Color secondaryNavigationColor = const Color(0xff898989);
  static Color orangeColor = const Color(0xffE97306);
  static Color secondaryTextColor = const Color(0xff585858);
  static Color backgroundColor = const Color(0xFFFAFAFA);
  static Color textFieldColor = const Color(0xFFF3F3F3);
  static Color darkGrey = const Color(0xFF31353D);
  static Color white = Color.fromARGB(255, 255, 255, 255);
  static Color Menu_cardColor = Color(0xff6785CC);

  static BoxShadow defualtShadow = const BoxShadow(
    color: Color.fromARGB(255, 207, 207, 207),
    spreadRadius: 1,
    blurRadius: 2,
    offset: Offset(0, 3),
  );

  static TextStyle get largeheadingStyle => TextStyle(
        fontFamily: 'Poppins',
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: primaryColor,
      );
  static TextStyle get smallTextLabel => TextStyle(
        fontFamily: 'Poppins',
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: secondaryTextColor,
      );
  static TextStyle get textLabel => TextStyle(
        fontFamily: 'Poppins',
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: secondaryTextColor,
      );
}
