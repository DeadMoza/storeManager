import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'theme.dart';

final db = FirebaseFirestore.instance;
final storage = FirebaseStorage.instance.ref();

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

List<String> types = <String>[
  'Long',
  'Short',
  'Jacket/\nBlouse',
  'Skirt/\nTrousers'
];

List<String> brands = <String>[];

final List<int> availableSizes = <int>[
  36,
  38,
  40,
  42,
  44,
  46,
  48,
  50,
  52,
  54,
  56,
  58,
  4,
  5,
  6,
  7,
];

final List<String> stringSizes =
    availableSizes.map((size) => size.toString()).toList();

List<String> availableColors = <String>[
  'Black',
  'Blue',
  'Dark\nBlue',
  'Green',
  'Dark\nGreen',
  'Red',
  'Purple',
  'Beige'
];
Container statContainer(
  Icon statIcon,
  String statTitle,
  String statValue,
  double textSize,
  double space,
) {
  return Container(
    alignment: Alignment.center,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: primaryColor,
    ),
    child: Column(children: [
      Row(
        children: [
          statIcon,
          Text(
            statTitle,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
      SizedBox(
        height: space,
      ),
      Text(
        statValue,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: textSize,
        ),
      )
    ]),
  );
}

Container colorStatContainer(String color) {
  IconData icon = Icons.rectangle_rounded;
  return Container(
    alignment: Alignment.center,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: primaryColor,
    ),
    child: Column(children: [
      const Row(
        children: [
          Icon(Icons.color_lens),
          Text(
            'Color',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
      const SizedBox(
        height: 10,
      ),
      Column(
        children: [
          Text(
            color,
            style: (color == 'Dark\nBlue' || color == 'Dark\nGreen')
                ? const TextStyle(fontSize: 15)
                : const TextStyle(fontSize: 20),
          ),
          switch (color) {
            'Black' => Icon(icon, color: black),
            'Blue' => Icon(icon, color: blue),
            'Dark\nBlue' => Icon(icon, color: darkBlue),
            'Green' => Icon(icon, color: green),
            'Dark\nGreen' => Icon(icon, color: darkGreen),
            'Red' => Icon(icon, color: red),
            'Purple' => Icon(icon, color: purple),
            _ => Icon(icon, color: beige)
          }
        ],
      )
    ]),
  );
}
