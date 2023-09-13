import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../misc/theme.dart';
import '../misc/utlis.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final TextEditingController brandController = TextEditingController();

  void addBrand(String newBrand) async {
    DocumentReference docRef = db.collection('settings').doc('brands');
    await docRef.update({
      'brand list': FieldValue.arrayUnion([newBrand])
    });

    setState(() {
      brands.add(newBrand);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Settings',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            )),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_rounded),
          color: miscColor,
          iconSize: 35,
          highlightColor: miscColor,
          splashRadius: 25,
          splashColor: miscColor,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(5),
        children: [
          Column(children: [
            const Text(
              'Brand List',
              style: TextStyle(
                  fontSize: 25, fontWeight: FontWeight.bold, color: miscColor),
            ),
            const Divider(
              indent: 100,
              endIndent: 100,
              color: primaryColor,
            ),
            verticalSpace(),
            for (var brand in brands)
              Text(
                brand,
                style: const TextStyle(fontSize: 25),
              ),
            verticalSpace(),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width / 3,
                height: 40,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.add_rounded),
                  label: const Text('Add'),
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return SizedBox(
                            height: MediaQuery.sizeOf(context).height / 2,
                            child: Center(
                              child: Column(
                                children: [
                                  verticalSpace(),
                                  const Text('Add a new brand'),
                                  verticalSpace(),
                                  TextField(
                                      textAlign: TextAlign.center,
                                      controller: brandController,
                                      decoration: InputDecoration(
                                          prefixIconColor: miscColor,
                                          contentPadding:
                                              const EdgeInsets.all(5),
                                          filled: true,
                                          focusedBorder:
                                              const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: primaryColor)),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          constraints: const BoxConstraints(
                                              maxHeight: 70, maxWidth: 250))),
                                  verticalSpace(),
                                  TextButton(
                                    child: const Text(
                                      'Done',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        if (brandController.text.isNotEmpty) {
                                          addBrand(brandController.text.trim());
                                        }
                                      });
                                      brandController.clear();
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  },
                ),
              ),
            ),
            const Divider(
              color: primaryColor,
              indent: 25,
              endIndent: 25,
            ),
            const Text(
              'Releases',
              style: TextStyle(
                  fontSize: 25, fontWeight: FontWeight.bold, color: miscColor),
            ),
            const Divider(
              indent: 100,
              endIndent: 100,
              color: primaryColor,
            ),
            verticalSpace(),
            const Text(
              'Version 1.0.0',
              style: TextStyle(fontSize: 20),
            )
          ])
        ],
      ),
    );
  }
}
