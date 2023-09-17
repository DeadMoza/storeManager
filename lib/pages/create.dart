import 'dart:io';
import 'package:elshamistore/misc/theme.dart';
import 'package:elshamistore/misc/utlis.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

Widget pic() {
  if (selectedImage != null) {
    return Image.file(
      File(selectedImage!.path!),
      width: double.infinity,
      fit: BoxFit.cover,
    );
  } else {
    return const Center(child: Text('Upload Image'));
  }
}

Future createProduct(
  int price,
  String code,
  List sizes,
  String color,
  String brand,
  String type,
) async {
  final docProduct = db.collection('products').doc();
  final json = {
    'price': price,
    'code': code,
    'size': sizes,
    'color': color,
    'brand': brand,
    'type': type,
    'image_name': selectedImage!.name,
    'id': docProduct.id
  };
  await docProduct.set(json);
}

PlatformFile? selectedImage;

class _CreatePageState extends State<CreatePage> {
  Future selectImage() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        selectedImage = result.files.first;
      });
    }
  }

  Future uploadFile() async {
    final path = 'productImages/${selectedImage!.name}';
    final file = File(selectedImage!.path!);

    final ref = storage.child(path);

    await ref.putFile(file);
  }

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

  String? brandsDropDownValue;
  String? typesDropDownValue;

  List<int> sizes = [];

  String? choosenColor;
  String? choosenBrand;
  String? choosenType;

  final TextEditingController priceController = TextEditingController();
  final TextEditingController codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: beige,
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: const ButtonStyle(
                  fixedSize: MaterialStatePropertyAll(Size(150, 50)),
                  backgroundColor: MaterialStatePropertyAll(primaryColor)),
              child: const Text('CANCEL',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              onPressed: () {
                selectedImage = null;
                Navigator.pop(context);
              },
            ),
            const SizedBox(width: 20),
            ElevatedButton(
              style: const ButtonStyle(
                  fixedSize: MaterialStatePropertyAll(Size(150, 50)),
                  backgroundColor: MaterialStatePropertyAll(primaryColor)),
              child: const Text('SAVE',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              onPressed: () {
                final productPrice = int.parse(priceController.text);
                final productCode = codeController.text;

                sizes.sort();
                createProduct(productPrice, productCode, sizes, choosenColor!,
                    choosenBrand!, choosenType!);
                uploadFile();
                selectedImage = null;
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Product Added!'),
                  duration: Duration(seconds: 1),
                  backgroundColor: green,
                ));
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
                  Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey[400],
                        ),
                        height: 350,
                        width: 400,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: pic()),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: IconButton(
                          icon: const Icon(Icons.mode_edit_outline_rounded),
                          iconSize: 40,
                          onPressed: selectImage,
                        ),
                      ),
                    ],
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
                                        BorderSide(color: primaryColor)),
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
                                        BorderSide(color: primaryColor)),
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
                                      selectedSize[index] =
                                          !selectedSize[index];

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
                                  fillColor: primaryColor,
                                  children: stringSizes
                                      .map((size) => Text(size))
                                      .toList()),
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
                                  fillColor: primaryColor,
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
                      stat('Brand:   '),
                      DropdownButton(
                        hint: const Text('Choose Brand'),
                        iconEnabledColor: primaryColor,
                        borderRadius: BorderRadius.circular(5),
                        icon: const Icon(Icons.keyboard_arrow_down_rounded),
                        iconSize: 30,
                        dropdownColor: primaryColor,
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
                      stat('Type:     '),
                      DropdownButton(
                        hint: const Text('Choose Type'),
                        iconEnabledColor: primaryColor,
                        borderRadius: BorderRadius.circular(5),
                        icon: const Icon(Icons.keyboard_arrow_down_rounded),
                        iconSize: 30,
                        dropdownColor: primaryColor,
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
                  verticalSpace(),
                  const Divider(
                    indent: 20,
                    endIndent: 20,
                    color: primaryColor,
                  ),
                  verticalSpace(),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '4 =   L    = 44-46\n5 =  XL   = 46-48\n6 = XXL = 48-50\n7 = 3XL =  52-54',
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
