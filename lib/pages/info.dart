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
                icon: const Icon(Icons.delete),
                splashColor: secondaryColor,
                highlightColor: secondaryColor,
                splashRadius: 25,
                iconSize: 35,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: ((context) => AlertDialog(
                            content:
                                const Text('Are you sure you want to delete?'),
                            contentTextStyle: const TextStyle(
                                color: Colors.black, fontSize: 20),
                            actions: <Widget>[
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  style: const ButtonStyle(
                                      foregroundColor:
                                          MaterialStatePropertyAll(miscColor)),
                                  child: const Text('Cancel')),
                              TextButton(
                                  onPressed: () {
                                    Navigator.popUntil(
                                        context, ModalRoute.withName('/'));
                                  },
                                  style: const ButtonStyle(
                                      foregroundColor:
                                          MaterialStatePropertyAll(miscColor)),
                                  child: const Text('Delete')),
                            ],
                          )));
                },
              ),
            ),
          ]),
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              Container(
                width: 400,
                height: 350,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[400],
                ),
              ),
              verticalSpace(),
              Row(
                children: [
                  stat('Code: '),
                ],
              ),
              verticalSpace(),
              Row(
                children: [
                  stat('Size: '),
                ],
              ),
              verticalSpace(),
              Row(
                children: [
                  stat('Color: '),
                ],
              ),
              verticalSpace(),
              Row(
                children: [
                  stat('Brand: '),
                ],
              ),
              verticalSpace(),
              Row(
                children: [
                  stat('Type: '),
                ],
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
