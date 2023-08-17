import 'package:elshamistore/misc/theme.dart';
import 'package:elshamistore/misc/utlis.dart';
import 'package:flutter/material.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

Future createProduct(int price, String code, List sizes, String color,
    String brand, String type) async {
  final docProduct = db.collection('products').doc();
  final json = {
    'price': price,
    'code': code,
    'size': sizes,
    'color': color,
    'brand': brand,
    'type': type,
  };
  await docProduct.set(json);
}

class _CreatePageState extends State<CreatePage> {
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
  ];

  String brandsDropDownValue = brands.first;

  String typesDropDownValue = types.first;

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
    58
  ];
  List<int> sizes = [];

  List<String> availableColors = <String>[
    'Black',
    'Blue',
    'Dark Blue',
    'Green',
    'Dark Green',
    'Red',
    'Purple',
    'Beige'
  ];
  String? choosenColor;
  String? choosenBrand;
  String? choosenType;

  final priceController = TextEditingController();
  final codeController = TextEditingController();

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
              style: const ButtonStyle(
                  fixedSize: MaterialStatePropertyAll(Size(150, 50)),
                  backgroundColor: MaterialStatePropertyAll(secondaryColor)),
              child: const Text('CANCEL',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(width: 20),
            ElevatedButton(
              style: const ButtonStyle(
                  fixedSize: MaterialStatePropertyAll(Size(150, 50)),
                  backgroundColor: MaterialStatePropertyAll(secondaryColor)),
              child: const Text('SAVE',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              onPressed: () {
                final productPrice = int.parse(priceController.text);
                final productCode = codeController.text;
                sizes.sort();
                createProduct(productPrice, productCode, sizes, choosenColor!,
                    choosenBrand!, choosenType!);
                Navigator.pop(context);
              },
            ),
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
                  verticalSpace(),
                  Row(
                    children: [
                      stat('Price: '),
                      Expanded(
                        child: TextField(
                            controller: priceController,
                            style: const TextStyle(fontSize: 18),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(1),
                                prefixIcon:
                                    const Icon(Icons.attach_money_rounded),
                                prefixIconColor: miscColor,
                                filled: true,
                                focusedBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: secondaryColor)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                constraints: const BoxConstraints(
                                    minHeight: 40, maxHeight: 40))),
                      ),
                    ],
                  ),
                  verticalSpace(),
                  Row(
                    children: [
                      stat('Code: '),
                      Expanded(
                        child: TextField(
                            controller: codeController,
                            style: const TextStyle(fontSize: 18),
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(1),
                                prefixIcon: const Icon(Icons.code_rounded),
                                prefixIconColor: miscColor,
                                filled: true,
                                focusedBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: secondaryColor)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                constraints: const BoxConstraints(
                                    minHeight: 40, maxHeight: 40))),
                      ),
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
                                      for (int i = 0;
                                          i < availableSizes.length;
                                          i++) {
                                        if (index == i && selectedSize[index]) {
                                          sizes.add(availableSizes[i]);
                                        } else if (index == i &&
                                            !selectedSize[index]) {
                                          sizes.remove(availableSizes[i]);
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
                                    Text('56'),
                                    Text('58'),
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
                                      for (int i = 0;
                                          i < availableColors.length;
                                          i++) {
                                        if (index == i &&
                                            selectedColor[index]) {
                                          choosenColor = availableColors[index];
                                        } else if (index == i &&
                                            !selectedColor[index]) {
                                          choosenColor = null;
                                        }
                                      }
                                    });
                                  },
                                  renderBorder: false,
                                  fillColor: secondaryColor,
                                  children: [
                                    colorPick(black),
                                    colorPick(blue),
                                    colorPick(darkBlue),
                                    colorPick(green),
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
                            choosenBrand = value;
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
                            choosenType = value;
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
