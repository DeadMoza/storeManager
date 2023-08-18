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
  const DetailsPage(
      {super.key,
      required this.productStatPrice,
      required this.productStatCode,
      required this.productStatSize,
      required this.productStatColor,
      required this.productStatBrand,
      required this.productStatType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: secondaryColor,
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
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text('Product Deleted'),
                                      duration: Duration(seconds: 3),
                                      backgroundColor: red,
                                    ));
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
      body: ListView(physics: const AlwaysScrollableScrollPhysics(), children: [
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
              GridView.count(
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  statContainer(
                    const Icon(Icons.attach_money_rounded),
                    'Price',
                    productStatPrice,
                  ),
                  statContainer(
                    const Icon(Icons.code_rounded),
                    'Code',
                    productStatCode,
                  ),
                  sizesStatContainer(
                    const Icon(Icons.format_size_rounded),
                    'Sizes',
                    productStatSize,
                  ),
                  colorStatContainer(productStatColor),
                  statContainer(
                    const Icon(Icons.home_work_rounded),
                    'Brand',
                    productStatBrand,
                  ),
                  statContainer(
                    const Icon(Icons.type_specimen),
                    'Type',
                    productStatType,
                  ),
                ],
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
