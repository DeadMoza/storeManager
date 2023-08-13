import 'package:elshamistore/misc/theme.dart';
import 'package:elshamistore/misc/utlis.dart';
import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final List<bool> selectedSize = <bool>[
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  final List<bool> selectedColor = <bool>[
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  String brandsDropDownValue = brands.first;

  String typesDropDownValue = types.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: primaryColor,
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: const ButtonStyle(
                  fixedSize: MaterialStatePropertyAll(Size(150, 50)),
                  backgroundColor: MaterialStatePropertyAll(secondaryColor)),
              child: const Text('CANCEL',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            ),
            const SizedBox(width: 20),
            ElevatedButton(
                onPressed: () {},
                style: const ButtonStyle(
                    fixedSize: MaterialStatePropertyAll(Size(150, 50)),
                    backgroundColor: MaterialStatePropertyAll(secondaryColor)),
                child: const Text('SAVE',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18))),
          ],
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[400],
                    ),
                    height: 350,
                    width: 400,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.mode_edit_outline_rounded),
                      alignment: Alignment.bottomRight,
                      iconSize: 40,
                    ),
                  ),
                  const SizedBox(height: 25),
                  Row(
                    children: [
                      stat('Code: '),
                      Expanded(
                          child: TextField(
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            filled: true,
                            focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: secondaryColor)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            constraints: const BoxConstraints(
                              maxHeight: 35,
                            )),
                      )),
                    ],
                  ),
                  verticalSpace(),
                  Row(
                    children: [
                      stat('Size: '),
                      Expanded(
                        child: SizedBox(
                          height: 45,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            children: [
                              ToggleButtons(
                                  isSelected: selectedSize,
                                  onPressed: (index) {
                                    setState(() {
                                      for (int i = 0;
                                          i < selectedSize.length;
                                          i++) {
                                        if (i == index) {
                                          selectedSize[i] = !selectedSize[i];
                                        }
                                      }
                                    });
                                  },
                                  borderColor: Colors.black,
                                  borderRadius: BorderRadius.circular(8),
                                  selectedColor: miscColor,
                                  selectedBorderColor: miscColor,
                                  fillColor: secondaryColor,
                                  children: const [
                                    Text('36'),
                                    Text('38'),
                                    Text('40'),
                                    Text('42'),
                                    Text('44'),
                                    Text('46'),
                                    Text('48'),
                                    Text('50'),
                                    Text('52'),
                                    Text('54'),
                                    Text('56')
                                  ]),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  verticalSpace(),
                  Row(
                    children: [
                      stat('Color: '),
                      Expanded(
                          child: SizedBox(
                        height: 40,
                        child: ListView(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            children: [
                              ToggleButtons(
                                  isSelected: selectedColor,
                                  onPressed: (index) {
                                    setState(() {
                                      for (int i = 0;
                                          i < selectedColor.length;
                                          i++) {
                                        if (i == index) {
                                          selectedColor[i] = !selectedColor[i];
                                        } else {
                                          selectedColor[i] = false;
                                        }
                                      }
                                    });
                                  },
                                  renderBorder: false,
                                  fillColor: secondaryColor,
                                  children: [
                                    colorPick(black),
                                    colorPick(blue),
                                    colorPick(lightBlue),
                                    colorPick(darkBlue),
                                    colorPick(green),
                                    colorPick(lightGreen),
                                    colorPick(darkGreen),
                                    colorPick(red),
                                    colorPick(purple),
                                    colorPick(beige),
                                  ])
                            ]),
                      ))
                    ],
                  ),
                  verticalSpace(),
                  Row(
                    children: [
                      stat('Brand: '),
                      DropdownButton(
                        borderRadius: BorderRadius.circular(5),
                        icon: const Icon(Icons.keyboard_arrow_down_rounded),
                        iconSize: 30,
                        dropdownColor: secondaryColor,
                        value: brandsDropDownValue,
                        items: brands
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            brandsDropDownValue = value!;
                          });
                        },
                      ),
                    ],
                  ),
                  verticalSpace(),
                  Row(
                    children: [
                      stat('Type: '),
                      DropdownButton(
                        borderRadius: BorderRadius.circular(5),
                        icon: const Icon(Icons.keyboard_arrow_down_rounded),
                        iconSize: 30,
                        dropdownColor: secondaryColor,
                        value: typesDropDownValue,
                        items:
                            types.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            typesDropDownValue = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
