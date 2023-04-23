import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../screens/item_details/item_details.dart';
import 'bottom_appbar.dart';
import 'category_item_card.dart';

class CategoryItemsBody extends StatefulWidget {
 final String title,collection;

 const CategoryItemsBody({super.key, required this.title, required this.collection});

  @override
  State<CategoryItemsBody> createState() => _CategoryItemsBodyState();
}

class _CategoryItemsBodyState extends State<CategoryItemsBody> {


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.keyboard_backspace_outlined,
                )),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 0,
            centerTitle: true,
            title: Text(
              widget.title,
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 36),
                    child: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16)),
                          labelText: "search by title",
                          prefixIcon: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.search_rounded)),
                          suffixIcon: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.sort,
                                color: Colors.red,
                              ))),
                    ),
                  ),
                  Expanded(
                      child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection(widget.collection)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(
                                child: Text("No data. Loading...."),
                              );
                            } else {
                              return GridView.builder(
                                  gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3),
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    DocumentSnapshot data =
                                    snapshot.data!.docs[index];
                                    return InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ItemDetails(
                                                        price: data["price"],
                                                        image: data["image"],
                                                        name: data["name"],
                                                      )));
                                        },
                                        child: CategoryItemCard(
                                          image: data["image"],
                                          name: data["name"],
                                        ));
                                  });
                            }
                          })),
                  const SizedBox(),
                  const BottomBar()

                ],
              ),
            ),
          )),
    );
  }
}
