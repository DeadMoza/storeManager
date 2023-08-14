import 'info.dart';
import '../misc/theme.dart';
import 'package:flutter/material.dart';
import 'create.dart';

class PrimaryPage extends StatefulWidget {
  const PrimaryPage({super.key});

  @override
  State<PrimaryPage> createState() => _PrimaryPageState();
}

class _PrimaryPageState extends State<PrimaryPage> {
  final List<bool> selected = <bool>[false, false, false, false];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: secondaryColor,
        leadingWidth: 500,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: ToggleButtons(
            borderWidth: 2.5,
            isSelected: selected,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            fillColor: primaryColor,
            splashColor: primaryColor,
            selectedBorderColor: primaryColor,
            selectedColor: Colors.black,
            borderColor: primaryColor,
            constraints: const BoxConstraints(minHeight: 45, minWidth: 70),
            children: const [
              Text('LONG'),
              Text('SHORT'),
              Text('SKIRT'),
              Text('JACKET')
            ],
            onPressed: (int index) {
              setState(() {
                for (int i = 0; i < selected.length; i++) {
                  if (i == index) {
                    selected[i] = !selected[i];
                  } else {
                    selected[i] = false;
                  }
                }
              });
            },
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: IconButton(
              icon: const Icon(Icons.add_circle),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CreatePage()));
              },
              color: primaryColor,
              iconSize: 40,
              highlightColor: miscColor,
              splashRadius: 25,
              splashColor: miscColor,
            ),
          ),
        ],
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 4, right: 4, top: 12),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: secondaryColor),
              padding: const EdgeInsets.all(5),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DetailsPage()));
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
