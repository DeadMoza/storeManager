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

List<String> brands = <String>['none', 'VALLS', 'BALERINA', 'ROZEŞA'];
List<String> types = <String>[
  'Long',
  'Short',
  'Skirt/\nTrousers',
  'Jacket/\nBlouse'
];
Container statContainer(
  Icon statIcon,
  String statLabel,
  String statValue,
) {
  return Container(
    padding: const EdgeInsets.all(6),
    alignment: Alignment.center,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: secondaryColor,
    ),
    child: Column(children: [
      Row(
        children: [
          statIcon,
          Text(
            statLabel,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
      const SizedBox(
        height: 10,
      ),
      FittedBox(
        child: Text(
          statValue,
        ),
      )
    ]),
  );
}

Container sizesStatContainer(
  Icon statIcon,
  String statLabel,
  String statValue,
) {
  return Container(
    padding: const EdgeInsets.all(6),
    alignment: Alignment.center,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: secondaryColor,
    ),
    child: Column(children: [
      Row(
        children: [
          statIcon,
          Text(
            statLabel,
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
      color: secondaryColor,
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
          else if (color == 'Dark Blue')
            Icon(
              icon,
              color: darkBlue,
            )
          else if (color == 'Green')
            Icon(
              icon,
              color: green,
            )
          else if (color == 'Dark Green')
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
