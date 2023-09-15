import 'dart:io';

import 'package:elshamistore/misc/theme.dart';
import 'package:flutter/material.dart';
import '../misc/utlis.dart';
import 'edit.dart';

class DetailsPage extends StatelessWidget {
  final String productStatPrice;
  final String productStatCode;
  final String productStatSize;
  final String productStatColor;
  final String productStatBrand;
  final String productStatType;
  final String productStatImage;
  final String productStatImageName;
  final String productStatId;
  const DetailsPage(
      {super.key,
      required this.productStatPrice,
      required this.productStatCode,
      required this.productStatSize,
      required this.productStatColor,
      required this.productStatBrand,
      required this.productStatType,
      required this.productStatImage,
      required this.productStatImageName,
      required this.productStatId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: primaryColor,
          leading: IconButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, '/');
            },
            icon: const Icon(Icons.arrow_back_rounded),
            iconSize: 35,
            padding: const EdgeInsets.only(left: 5),
            splashColor: primaryColor,
            highlightColor: primaryColor,
            splashRadius: 25,
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditPage(
                            price: productStatPrice,
                            code: productStatCode,
                            size: productStatSize.split(','),
                            color: productStatColor,
                            brand: productStatBrand,
                            type: productStatType,
                            image: productStatImage,
                            imageName: productStatImageName,
                            id: productStatId)));
              },
              icon: const Icon(Icons.edit),
              iconSize: 32,
              splashColor: primaryColor,
              highlightColor: primaryColor,
              splashRadius: 25,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: IconButton(
                icon: const Icon(Icons.delete),
                splashColor: primaryColor,
                highlightColor: primaryColor,
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
                                style: const ButtonStyle(
                                    foregroundColor:
                                        MaterialStatePropertyAll(miscColor)),
                                child: const Text('Cancel'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              TextButton(
                                style: const ButtonStyle(
                                    foregroundColor:
                                        MaterialStatePropertyAll(miscColor)),
                                child: const Text('Delete'),
                                onPressed: () {
                                  final docProduct = db
                                      .collection('products')
                                      .doc(productStatId);

                                  final docImage = storage.child(
                                      'productImages/$productStatImageName');

                                  docProduct.delete();
                                  docImage.delete();
                                  Navigator.popUntil(
                                      context, ModalRoute.withName('/'));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text('Product Deleted'),
                                    duration: Duration(seconds: 1),
                                    backgroundColor: red,
                                  ));
                                },
                              ),
                            ],
                          )));
                },
              ),
            ),
          ]),
      body: ListView(physics: const AlwaysScrollableScrollPhysics(), children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ImagePage(
                              image: productStatImage,
                            ))),
                child: Container(
                    width: 400,
                    height: 350,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey[400],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.file(
                        File(productStatImage),
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    )),
              ),
              verticalSpace(),
              GridView.count(
                mainAxisSpacing: 2,
                crossAxisSpacing: 2,
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  statContainer(
                    const Icon(Icons.attach_money_rounded),
                    'Price',
                    productStatPrice,
                    20,
                  ),
                  statContainer(
                    const Icon(Icons.code_rounded),
                    'Code',
                    productStatCode,
                    20,
                  ),
                  statContainer(
                    const Icon(Icons.shopping_bag),
                    'Sizes',
                    productStatSize,
                    15,
                  ),
                  colorStatContainer(productStatColor),
                  statContainer(
                    const Icon(Icons.south_america_outlined),
                    'Brand',
                    productStatBrand,
                    20,
                  ),
                  statContainer(
                    const Icon(Icons.category_rounded),
                    'Type',
                    productStatType,
                    20,
                  ),
                ],
              ),
              verticalSpace(),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '4 =   L    = 44-46\n5 =  XL   = 46-48\n6 = XXL = 48-50\n7 = 3XL = 52-54',
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }
}

class ImagePage extends StatelessWidget {
  final String image;
  const ImagePage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        toolbarHeight: 36,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_rounded),
          iconSize: 30,
          color: primaryColor,
        ),
      ),
      body: SafeArea(
        child: InteractiveViewer(
          child: Center(
            child: Image.file(
              File(image),
              fit: BoxFit.contain,
              width: double.infinity,
            ),
          ),
        ),
      ),
    );
  }
}
