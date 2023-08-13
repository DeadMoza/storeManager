import 'package:flutter/material.dart';

const primaryColor = Color.fromRGBO(245, 222, 179, 1);
const secondaryColor = Color.fromRGBO(210, 180, 140, 1);
const miscColor = Color.fromRGBO(63, 50, 2, 100);

const black = Colors.black;
const blue = Colors.blue;
const darkBlue = Color.fromARGB(255, 0, 49, 112);
const lightBlue = Color.fromARGB(255, 0, 238, 255);
const green = Colors.green;
const darkGreen = Color.fromARGB(255, 0, 83, 3);
const lightGreen = Color.fromARGB(255, 177, 237, 109);
const red = Colors.red;
const purple = Colors.purple;
const beige = Color.fromRGBO(253, 227, 179, 1);

ThemeData appTheme() {
  return ThemeData(
    colorScheme: const ColorScheme.light(
      primary: primaryColor,
      onPrimary: miscColor,
      secondary: secondaryColor,
    ),
    fontFamily: 'Rubik',
  );
}
