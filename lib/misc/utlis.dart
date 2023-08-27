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

List<String> brands = <String>[
  'NONE',
  'VALLS',
  'BALERINA',
  'ROZEŞA',
  'PLACEHOLDER',
  'PLACEHOLDER2',
  'PLACEHOLDER3',
  'PLACEHOLDER4',
];
List<String> types = <String>[
  'Long',
  'Short',
  'Skirt/\nTrousers',
  'Jacket/\nBlouse'
];

List<int> availableSizes = <int>[
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
  6,
  7,
  8,
  9,
];

Container statContainer(
  Icon statIcon,
  String statTitle,
  String statValue,
  double textSize,
) {
  return Container(
    padding: const EdgeInsets.all(6),
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
      const SizedBox(
        height: 10,
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
    padding: const EdgeInsets.all(6),
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
          FittedBox(
            child: Text(
              color,
              style: const TextStyle(fontSize: 20),
            ),
          ),
          if (color == 'Black')
            Icon(
              icon,
              color: black,
            )
          else if (color == 'Blue')
            Icon(
              icon,
              color: blue,
            )
          else if (color == 'Dark\nBlue')
            Icon(
              icon,
              color: darkBlue,
            )
          else if (color == 'Green')
            Icon(
              icon,
              color: green,
            )
          else if (color == 'Dark\nGreen')
            Icon(
              icon,
              color: darkGreen,
            )
          else if (color == 'Red')
            Icon(
              icon,
              color: red,
            )
          else if (color == 'Purple')
            Icon(
              icon,
              color: purple,
            )
          else
            Icon(
              icon,
              color: beige,
            )
        ],
      )
    ]),
  );
}
