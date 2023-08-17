import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'theme.dart';

final db = FirebaseFirestore.instance;

Text stat(String title) {
  return Text(
    title,
    style: const TextStyle(
      fontSize: 25,
    ),
  );
}

Container statContainer(Icon statIcon, Widget statValue) {
  return Container(
    padding: const EdgeInsets.all(10),
    alignment: Alignment.center,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: secondaryColor,
    ),
    child: Column(children: [statIcon, verticalSpace(), statValue]),
  );
}

SizedBox verticalSpace() {
  return const SizedBox(
    height: 18,
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
