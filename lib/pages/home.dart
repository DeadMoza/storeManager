import 'dart:io';
import 'package:elshamistore/pages/settings.dart';
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
  final TextEditingController searchController = TextEditingController();

  int typeDrawerIndex = 0;
  int brandDrawerIndex = 0;

  void typeDrawerOnTap(int index) {
    setState(() {
      typeDrawerIndex = index;
    });
  }

  void brandDrawerOnTap(int index) {
    setState(() {
      brandDrawerIndex = index;
    });
  }

  ListTile typeTile(String label, int i) {
    return ListTile(
        selectedColor: miscColor,
        textColor: miscColor,
        splashColor: primaryColor,
        selectedTileColor: primaryColor,
        dense: true,
        visualDensity: const VisualDensity(vertical: -4),
        title: Text(
          label,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        selected: typeDrawerIndex == i,
        onTap: () {
          typeDrawerOnTap(i);
        });
  }

  ListTile brandTile(String label, int i) {
    return ListTile(
        selectedColor: miscColor,
        textColor: miscColor,
        splashColor: primaryColor,
        selectedTileColor: primaryColor,
        dense: true,
        visualDensity: const VisualDensity(vertical: -4),
        title: Text(
          label,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        selected: brandDrawerIndex == i,
        onTap: () {
          brandDrawerOnTap(i);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: beige,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        width: 195,
        child: ListView(padding: EdgeInsets.zero, children: [
          const SizedBox(
            height: 125,
            child: DrawerHeader(
              decoration: BoxDecoration(color: primaryColor),
              child: Text("Elshami Store",
                  style: TextStyle(
                      fontSize: 18,
                      color: miscColor,
                      fontWeight: FontWeight.bold)),
            ),
          ),
          typeTile('All Dresses', 0),
          typeTile('Long Dresses', 1),
          typeTile('Short Dresses', 2),
          typeTile('Jackets And Blouse', 3),
          typeTile('Trousers And Skirts', 4),
          const Divider(),
          brandTile('All Dresses', 0),
          for (int i = 1; i < brands.length; i++) brandTile(brands[i], i),
          const Divider(),
          ListTile(
            dense: true,
            visualDensity: const VisualDensity(vertical: -4),
            horizontalTitleGap: 0,
            title: const Text(
              'Settings',
              style: TextStyle(fontSize: 16),
            ),
            leading: const Icon(
              Icons.settings_rounded,
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SettingsPage()));
            },
          ),
          const ListTile(
            dense: true,
            visualDensity: VisualDensity(vertical: -4),
            horizontalTitleGap: 0,
            leading: Icon(
              Icons.account_tree_outlined,
            ),
            title: Text(
              'Version 1.0.0',
              style: TextStyle(fontSize: 16),
            ),
          )
        ]),
      ),
      appBar: AppBar(
          backgroundColor: primaryColor,
          leading: Builder(builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu_rounded),
              color: miscColor,
              iconSize: 40,
              highlightColor: miscColor,
              splashRadius: 25,
              splashColor: miscColor,
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          }),
          title: TextField(
            controller: searchController,
            decoration: InputDecoration(
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: miscColor)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              constraints: const BoxConstraints(maxHeight: 40, minHeight: 35),
              contentPadding: const EdgeInsets.all(5),
              prefixIcon: const Icon(Icons.search_rounded),
              prefixIconColor: miscColor,
              filled: true,
              hintText: 'Search Code',
            ),
            cursorColor: miscColor,
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.add_circle),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CreatePage()));
              },
              color: miscColor,
              iconSize: 40,
              highlightColor: miscColor,
              splashRadius: 25,
              splashColor: miscColor,
            ),
          ]),
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
              String image = doc['image'];
              String imageName = doc['image_name'];
              String id = doc['id'];

              return Padding(
                padding: const EdgeInsets.all(4),
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
                                  productStatImage: image,
                                  productStatImageName: imageName,
                                  productStatId: id,
                                )));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: primaryColor),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.file(
                        File(image),
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
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
