import 'package:flutter/material.dart';

Text stat(String title) {
  return Text(
    title,
    style: const TextStyle(
      fontSize: 25,
    ),
  );
}

SizedBox verticalSpace() {
  return const SizedBox(
    height: 15,
  );
}

Icon colorPick(Color color) {
  return Icon(
    size: 35,
    Icons.circle,
    color: color,
  );
}

List<String> brands = <String>['none', 'VALLS', 'BALERINA', 'ROZEŞA'];
List<String> types = <String>['LONG', 'SHORT', 'SKIRT', 'JACKET'];
