import 'package:flutter/material.dart';

const primaryColor = Color.fromRGBO(245, 222, 179, 1);
const secondaryColor = Color.fromRGBO(210, 180, 140, 1);
const miscColor = Color.fromRGBO(63, 50, 2, 100);

ThemeData appTheme() {
  return ThemeData(
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        onPrimary: miscColor,
        secondary: secondaryColor,
      ),
      fontFamily: 'Roboto');
}
