import 'package:cloud_firestore/cloud_firestore.dart';
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
  String? searchResult;

  int drawerIndex = 0;

  void drawerOnTap(int index) {
    setState(() {
      drawerIndex = index;
      Navigator.pop(context);
    });
  }

  ListTile drawerTile(String label, int i) {
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
        selected: drawerIndex == i,
        onTap: () {
          drawerOnTap(i);
        });
  }

  @override
  void initState() {
    super.initState();
    getBrands();
  }

  void getBrands() async {
    DocumentSnapshot docBrands =
        await db.collection('settings').doc('brands').get();

    List<dynamic> firestoreArray = docBrands.get('brand list') ?? [];
    List<String> convertedList =
        firestoreArray.map((item) => item.toString()).toList();

    setState(() {
      brands = convertedList;
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
          drawerTile('All Dresses', 0),
          const Divider(),
          drawerTile('Long Dresses', 1),
          drawerTile('Short Dresses', 2),
          drawerTile('Jackets And Blouse', 3),
          drawerTile('Skirts And Trousers', 4),
          const Divider(),
          for (int i = 0; i < brands.length; i++) drawerTile(brands[i], i + 5),
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
              contentPadding: const EdgeInsets.symmetric(vertical: 15),
              prefixIcon: const Icon(Icons.search_rounded),
              prefixIconColor: miscColor,
              filled: true,
              labelText: 'Search Code',
              labelStyle: const TextStyle(color: miscColor),
              suffix: IconButton(
                  color: miscColor,
                  highlightColor: miscColor,
                  splashRadius: 25,
                  splashColor: miscColor,
                  icon: const Icon(Icons.clear_rounded),
                  onPressed: () {
                    searchController.clear();
                    setState(() {
                      drawerIndex = 0;
                    });
                  }),
            ),
            cursorColor: miscColor,
            onSubmitted: (value) {
              setState(() {
                if (searchController.text.isNotEmpty) {
                  searchResult = value;
                  drawerIndex = -1;
                }
              });
            },
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
        stream: (drawerIndex > 0 && drawerIndex <= 4)
            ? db
                .collection('products')
                .where('type', isEqualTo: types[drawerIndex - 1])
                .snapshots()
            : drawerIndex > 4
                ? db
                    .collection('products')
                    .where('brand', isEqualTo: brands[drawerIndex - 5])
                    .snapshots()
                : drawerIndex == 0
                    ? db.collection('products').snapshots()
                    : db
                        .collection('products')
                        .where('code', isEqualTo: searchResult)
                        .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                'No Results',
                style: TextStyle(fontSize: 25, color: miscColor),
              ),
            );
          }
          return GridView.builder(
            itemCount: snapshot.data?.docs.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) {
              final doc = snapshot.data?.docs[index].data();
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
                      child: Image.network(
                        'https://firebasestorage.googleapis.com/v0/b/elshamistore-c6810.appspot.com/o/productImages%2F$imageName?alt=media',
                        fit: BoxFit.cover,
                        width: double.infinity,
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
                          return const Center(
                              child: Text('Error Loading Image'));
                        },
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
