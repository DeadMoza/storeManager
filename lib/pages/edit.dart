import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:elshamistore/misc/theme.dart';
import 'package:elshamistore/misc/utlis.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'info.dart';

class EditPage extends StatefulWidget {
  final String price;
  final String code;
  final List<String> size;
  final String color;
  final String brand;
  final String type;

  final String imageName;
  final String id;

  const EditPage(
      {super.key,
      required this.price,
      required this.code,
      required this.size,
      required this.color,
      required this.brand,
      required this.type,
      required this.imageName,
      required this.id});

  @override
  State<EditPage> createState() => _EditPageState();
}

PlatformFile? selectedImage;

class _EditPageState extends State<EditPage> {
  Future updateProduct(
    int updatedPrice,
    String updatedCode,
    List updatedSize,
    String? updatedColor,
    String? updatedBrand,
    String? updatedType,
    String updatedImageName,
  ) async {
    final docProduct = db.collection('products').doc(widget.id);
    final json = {
      'price': updatedPrice,
      'code': updatedCode,
      'size': updatedSize,
      'color': updatedColor,
      'brand': updatedBrand,
      'type': updatedType,
      'image_name': updatedImageName
    };
    await docProduct.update(json);
  }

  final TextEditingController priceController = TextEditingController();
  final TextEditingController codeController = TextEditingController();

  String? brandsDropDownValue;
  String? typesDropDownValue;

  List<bool> selectedSize = <bool>[];
  List<bool> selectedColor = <bool>[];

  Widget pic() {
    if (selectedImage != null) {
      return Image.file(
        File(selectedImage!.path!),
        width: double.infinity,
        fit: BoxFit.cover,
      );
    } else {
      return Image.network(
        'https://firebasestorage.googleapis.com/v0/b/elshamistore-c6810.appspot.com/o/productImages%2F${widget.imageName}?alt=media',
        width: double.infinity,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
              child: CircularProgressIndicator(
            color: miscColor,
            semanticsLabel: 'Loading',
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ));
        },
        errorBuilder: (context, error, stackTrace) {
          // ignore: avoid_print
          print('Error Loading Image In Home Page $error');
          return const Center(child: Text('Error Loading Image'));
        },
      );
    }
  }

  Future editImage() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        selectedImage = result.files.first;
      });
    }
  }

  Future uploadEditedImage(String pathy) async {
    final String oldPath = 'productImages/${widget.imageName}';
    final String newPath = 'productImages/$pathy';

    final File file = File(selectedImage!.path!);

    final Reference ref = storage.child(oldPath);
    final Reference newRef = storage.child(newPath);

    await ref.delete();
    await newRef.putFile(file);
  }

  @override
  void initState() {
    super.initState();
    List<int> intPreSelectedSize = <int>[];

    if (widget.size[0] != '') {
      intPreSelectedSize = widget.size.map((str) => int.parse(str)).toList();
    }

    selectedColor = List.generate(availableColors.length,
        (index) => widget.color == availableColors[index]);
    selectedSize = List.generate(availableSizes.length,
        (index) => intPreSelectedSize.contains(availableSizes[index]));

    for (int i = 0; i < availableSizes.length; i++) {
      if (selectedSize[i]) {
        updatedSize.add(availableSizes[i]);
      } else {
        updatedSize.remove(availableSizes[i]);
      }
    }
  }

  List<int> updatedSize = <int>[];
  String? updatedColor;
  String? updatedBrand;
  String? updatedType;

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
                String updatedPrice = priceController.text;
                String? updatedCode = codeController.text;

                String updatedImageName = widget.imageName;

                if (priceController.text.isEmpty) {
                  updatedPrice = widget.price;
                }
                if (codeController.text.isEmpty) {
                  updatedCode = widget.code;
                }

                updatedColor ??= widget.color;
                updatedBrand ??= widget.brand;
                updatedType ??= widget.type;

                updatedSize.sort();
                Set<int> updatedSizeSet = Set<int>.from(updatedSize);
                List<int> sizes = updatedSizeSet.toList();

                if (selectedImage != null) {
                  updatedImageName = selectedImage!.name;
                  uploadEditedImage(updatedImageName);
                }

                updateProduct(
                  int.parse(updatedPrice),
                  updatedCode,
                  sizes,
                  updatedColor,
                  updatedBrand,
                  updatedType,
                  updatedImageName,
                );
                selectedImage = null;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailsPage(
                              productStatPrice: updatedPrice,
                              productStatCode: updatedCode!,
                              productStatSize: sizes.join(', '),
                              productStatColor: updatedColor!,
                              productStatBrand: updatedBrand!,
                              productStatType: updatedType!,
                              productStatImageName: updatedImageName,
                              productStatId: widget.id,
                            )));
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: ListView(
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          height: 350,
                          width: 400,
                          color: Colors.grey[400],
                          child: pic(),
                        ),
                      ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: IconButton(
                              icon: const Icon(Icons.edit_rounded, size: 40),
                              onPressed: editImage)),
                    ],
                  ),
                  verticalSpace(),
                  Row(
                    children: [
                      stat('Price: '),
                      Expanded(
                        child: TextField(
                            keyboardType: TextInputType.number,
                            controller: priceController,
                            decoration: InputDecoration(
                                prefixIcon:
                                    const Icon(Icons.attach_money_rounded),
                                prefixIconColor: miscColor,
                                hintText: widget.price,
                                contentPadding: const EdgeInsets.all(5),
                                filled: true,
                                focusedBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: primaryColor)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                constraints: const BoxConstraints(
                                    minHeight: 40, maxHeight: 40))),
                      )
                    ],
                  ),
                  verticalSpace(),
                  Row(
                    children: [
                      stat('Code: '),
                      Expanded(
                        child: TextField(
                            controller: codeController,
                            decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.code_rounded),
                                prefixIconColor: miscColor,
                                hintText: widget.code,
                                contentPadding: const EdgeInsets.all(5),
                                filled: true,
                                focusedBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: primaryColor)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                constraints: const BoxConstraints(
                                    minHeight: 35, maxHeight: 40))),
                      )
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
                                    selectedSize[index] = !selectedSize[index];

                                    for (int i = 0;
                                        i < availableSizes.length;
                                        i++) {
                                      if (index == i && selectedSize[index]) {
                                        updatedSize.add(availableSizes[i]);
                                      } else if (index == i &&
                                          !selectedSize[index]) {
                                        updatedSize.remove(availableSizes[i]);
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
                                    .toList(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(),
                  Row(children: [
                    stat(
                      'Color: ',
                    ),
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
                                          updatedColor = availableColors[index];
                                        } else if (index == i &&
                                            !selectedColor[index]) {
                                          updatedColor = null;
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
                      ),
                    )
                  ]),
                  verticalSpace(),
                  Row(
                    children: [
                      stat('Brand:   '),
                      DropdownButton(
                        iconEnabledColor: primaryColor,
                        hint: Text(widget.brand),
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
                            updatedBrand = value;
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
                        iconEnabledColor: primaryColor,
                        hint: Text(widget.type),
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
                            updatedType = value;
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
                      '2 = S = 34-36 \n3 = M = 38-40 \n4 = L = 42-44 \n5 = XL = 46-48 \n6 = XXL = 50-52 \n7 = 3XL = 52-54 \n8 = 4XL = 54-56',
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
