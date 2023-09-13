import 'package:flutter/material.dart';

const primaryColor = Color.fromRGBO(221, 184, 136, 1);
const miscColor = Color.fromRGBO(69, 57, 1, 0.688);

const black = Colors.black;
const blue = Color.fromARGB(255, 24, 184, 248);
const darkBlue = Color.fromARGB(255, 0, 49, 112);
const green = Color.fromARGB(255, 96, 213, 100);
const darkGreen = Color.fromARGB(255, 0, 83, 3);
const red = Colors.red;
const purple = Colors.purple;
const beige = Color.fromRGBO(253, 227, 179, 1);

ThemeData appTheme() {
  return ThemeData(
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        onPrimary: miscColor,
        secondary: primaryColor,
      ),
      fontFamily: 'Rubik',
      buttonTheme: const ButtonThemeData(minWidth: 20, height: 25));
}
