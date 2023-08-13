import 'package:elshamistore/misc/theme.dart';
import 'package:flutter/material.dart';
import '../misc/utlis.dart';
import 'edit.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  var favoriteFill = Icons.favorite_outline;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_rounded),
            iconSize: 35,
            padding: const EdgeInsets.only(left: 5),
            splashColor: secondaryColor,
            highlightColor: secondaryColor,
            splashRadius: 25,
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const EditPage()));
              },
              icon: const Icon(Icons.edit),
              iconSize: 32,
              splashColor: secondaryColor,
              highlightColor: secondaryColor,
              splashRadius: 25,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: IconButton(
                icon: Icon(favoriteFill),
                splashColor: secondaryColor,
                highlightColor: secondaryColor,
                splashRadius: 25,
                iconSize: 35,
                onPressed: () {
                  setState(() {
                    if (favoriteFill == Icons.favorite_outline) {
                      favoriteFill = Icons.favorite;
                    } else {
                      favoriteFill = Icons.favorite_outline;
                    }
                  });
                },
              ),
            ),
          ]),
      body: ListView(children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                width: 400,
                height: 350,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[400],
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  children: [
                    verticalSpace(),
                    stat('Code: '),
                    verticalSpace(),
                    stat('Size: '),
                    verticalSpace(),
                    stat('Color: '),
                    verticalSpace(),
                    stat('Brand: '),
                    verticalSpace(),
                    stat('Type: '),
                  ],
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
