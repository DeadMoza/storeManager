import 'dart:io';
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
  int drawerIndex = 0;

  void drawerOnTap(int index) {
    setState(() {
      drawerIndex = index;
    });
  }

  ListTile tile(String label, int i) {
    return ListTile(
        dense: true,
        visualDensity: const VisualDensity(vertical: -4),
        title: Text(
          label,
          style: const TextStyle(fontSize: 15),
        ),
        selected: drawerIndex == i,
        onTap: () {
          drawerOnTap(i);
          Navigator.pop(context);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: beige,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        width: 195,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(children: [
              tile('All Dresses', 0),
              const Divider(),
              tile('Long Dresses', 1),
              const Divider(),
              tile('Short Dresses', 2),
              const Divider(),
              tile('Jackets And Blouse', 3),
              const Divider(),
              tile('Trousers And Skirts', 4),
              const Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomLeft,
                  child: ListTile(
                    leading: Icon(Icons.account_tree_outlined),
                    title: Text('Version 1.0.0'),
                  ),
                ),
              )
            ]),
          ),
        ),
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
          title: SearchAnchor(
            isFullScreen: false,
            viewBackgroundColor: beige,
            viewConstraints: const BoxConstraints(
              maxHeight: 300,
            ),
            dividerColor: miscColor,
            viewShape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            viewLeading: IconButton(
                iconSize: 27,
                color: miscColor,
                highlightColor: miscColor,
                splashRadius: 25,
                splashColor: miscColor,
                icon: const Icon(Icons.arrow_back_rounded),
                onPressed: () {
                  Navigator.pop(context);
                  //FocusManager.instance.primaryFocus?.unfocus();
                }),
            viewTrailing: const Iterable.empty(),
            builder: (context, searchController) {
              return SearchBar(
                controller: searchController,
                leading: const Icon(
                  Icons.search,
                  color: miscColor,
                ),
                trailing: List<IconButton>.generate(
                    1,
                    (index) => IconButton(
                          padding: const EdgeInsets.only(bottom: 0, left: 10),
                          color: miscColor,
                          highlightColor: miscColor,
                          splashRadius: 25,
                          splashColor: miscColor,
                          icon: const Icon(Icons.clear_rounded),
                          onPressed: () => searchController.clear(),
                        )),
                constraints: const BoxConstraints(maxHeight: 45, minHeight: 35),
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5))),
                shadowColor: MaterialStateColor.resolveWith(
                    (states) => Colors.transparent),
                backgroundColor:
                    MaterialStateColor.resolveWith((states) => beige),
                padding: MaterialStateProperty.all(const EdgeInsets.all(4)),
                onTap: () {
                  searchController.openView();
                },
              );
            },
            suggestionsBuilder: (context, searchController) {
              return List<ListTile>.generate(brands.length, (index) {
                return ListTile(
                  title: Text(brands[index]),
                  trailing: const Icon(Icons.numbers),
                  onTap: () {
                    setState(() {
                      searchController.closeView(
                        brands[index],
                      );
                    });
                  },
                );
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
