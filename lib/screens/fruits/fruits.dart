import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../global_widgets/category_item_card.dart';
import '../../models/product.dart';
import '../../repositories/product_repository.dart';
import '../item_details/item_details.dart';

class Fruits extends StatefulWidget {

  const Fruits({
    super.key,
  });

  @override
  State<Fruits> createState() => _FruitsState();
}

class _FruitsState extends State<Fruits> {
  final searchController = TextEditingController();
  ProductRepository? _productRepository;
  List<Product>? productsList;
  List<Product>? productsListContainer;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  void initState() {
    _productRepository = ProductRepository();
    productsList = [];
    productsListContainer = [];

    fetchFruitsList();

    super.initState();
  }

  void fetchFruitsList() async {
    try {
      productsListContainer = await _productRepository!.getAllFruits();
      if (productsListContainer!.isNotEmpty) {
        setState(() {
          productsList = productsListContainer;
        });
      } else {}
    } catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.toString())));
    }
  }
  void runFilter(String enteredString) {
    if (enteredString.isEmpty) {
      setState(() {
        productsList = productsListContainer!;
      });
    } else {
      setState(() {
        productsList = productsListContainer!
            .where((element) => element.name
            .toLowerCase()
            .contains(enteredString.toLowerCase()))
            .toList();
      });
    }
  }

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
          title: const Text(
           'Fruits',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                textAlign: TextAlign.center,
                onChanged: (v) => runFilter(v),
                controller: searchController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16)),
                    labelText: "search by title",
                    prefixIcon: IconButton(
                        onPressed: () {}, icon: const Icon(Icons.search_rounded)),
                    suffixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.sort,
                          color: Colors.red,
                        ))),
              ),
              const SizedBox(height: 25,),
              Expanded(
                child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                    itemCount: productsList!.length,
                    itemBuilder: (context, index) {
                      Product data = productsList![index];
                      return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ItemDetails(
                                          price: data.price,
                                          image: data.image,
                                          name: data.name,
                                        )));
                          },
                          child: CategoryItemCard(
                            image: data.image,
                            name: data.name,
                          ));
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
