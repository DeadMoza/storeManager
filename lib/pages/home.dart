import 'info.dart';
import '../misc/theme.dart';
import 'package:flutter/material.dart';
import 'create.dart';
import '../misc/utlis.dart';

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
        backgroundColor: secondaryColor,
        leadingWidth: 500,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const CreatePage()));
            },
            color: primaryColor,
            iconSize: 40,
            highlightColor: miscColor,
            splashRadius: 25,
            splashColor: miscColor,
          ),
        ],
      ),
      body: StreamBuilder(
        stream: db.collection('products').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return GridView.builder(
            itemCount: snapshot.data?.docs.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) {
              var doc = snapshot.data?.docs[index].data();
              String price = doc!['price'].toString();
              String code = doc['code'];
              List sizes = doc['size'];
              String color = doc['color'];
              String brand = doc['brand'];
              String type = doc['type'];

              return Padding(
                padding: const EdgeInsets.all(4),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: secondaryColor),
                  padding: const EdgeInsets.all(10),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailsPage(
                                    productStatPrice: price,
                                    productStatCode: code,
                                    productStatSize: sizes.join(', '),
                                    productStatColor: color,
                                    productStatBrand: brand,
                                    productStatType: type,
                                  )));
                    },
                    child: Column(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Text(
                                price,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const Spacer(),
                              Text(
                                brand,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const Spacer(),
                              Text(
                                code,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
