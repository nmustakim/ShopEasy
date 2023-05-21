import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopeasy/firebase_helpers/firestore_helper.dart';

import '../../models/categories.dart';
import '../../models/product.dart';
import '../../shop_provider/shop_provider.dart';
import '../item_details/item_details.dart';
import '../product_by_category/products_by_categories.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categoriesList = [];
  List<ProductModel> popularProductsList = [];

  bool isLoading = false;
  @override
  void initState() {
    ShopProvider appProvider =
        Provider.of<ShopProvider>(context, listen: false);
    appProvider.getUserInfoFirebase();
    getCategoryList();
    super.initState();
  }

  void getCategoryList() async {
    setState(() {
      isLoading = true;
    });

    categoriesList = await FireStoreHelper.fireStoreHelper.getCategories();
    popularProductsList = await FireStoreHelper.fireStoreHelper.getPopular();

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  TextEditingController searchController = TextEditingController();
  List<ProductModel> searchList = [];
  void runFilter(String value) {
    setState(() {
      searchList = popularProductsList
          .where((element) =>
              element.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: isLoading
            ? Center(
                child: Container(
                  height: 100,
                  width: 100,
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(),
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 40,
                            child: TextField(
                              textAlign: TextAlign.center,
                              onChanged: (v) => runFilter(v),
                              controller: searchController,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white30,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)),
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
                          const SizedBox(
                            height: 24.0,
                          ),
                          const Text(
                            "Categories",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    categoriesList.isEmpty
                        ? const Center(
                            child: Text("Categories is empty"),
                          )
                        : SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                                children: categoriesList
                                    .map(
                                      (item) => Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: SizedBox(
                                          height: 100,
                                          width: 100,
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ProductByCategory(
                                                              categoryModel:
                                                                  item)));
                                            },
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image.network(
                                                  item.image,
                                                  height: 50,
                                                  width: 100,
                                                ),
                                                Text(item.name)
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList()),
                          ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 12.0, left: 12.0),
                      child: Text(
                        "Popular Products",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    searchController.text.isNotEmpty && searchList.isEmpty
                        ? const Center(
                            child: Text("No Product Found"),
                          )
                        : searchList.isNotEmpty
                            ? Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: GridView.builder(
                                    padding: const EdgeInsets.only(bottom: 50),
                                    shrinkWrap: true,
                                    primary: false,
                                    itemCount: searchList.length,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2),
                                    itemBuilder: (context, index) {
                                      ProductModel product = searchList[index];
                                      return Card(
                                        elevation: 5,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          child: Column(
                                            children: [
                                              const SizedBox(
                                                height: 12.0,
                                              ),
                                              Image.network(
                                                product.image,
                                                height: 70,
                                              ),
                                              const SizedBox(
                                                height: 12.0,
                                              ),
                                              Text(
                                                product.name,
                                                style: const TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text("Price: \$${product.price}"),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              SizedBox(
                                                height: 18,
                                                child: OutlinedButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                ItemDetails(
                                                                    product:
                                                                        product)));
                                                  },
                                                  child: const Text(
                                                    "Buy",
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              )
                            : popularProductsList.isEmpty
                                ? const Center(
                                    child: Text("Best Product is empty"),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: GridView.builder(
                                        padding:
                                            const EdgeInsets.only(bottom: 50),
                                        shrinkWrap: true,
                                        primary: false,
                                        itemCount: popularProductsList.length,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2),
                                        itemBuilder: (context, index) {
                                          ProductModel singleProduct =
                                              popularProductsList[index];
                                          return Card(
                                            elevation: 5,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              child: Column(
                                                children: [
                                                  const SizedBox(
                                                    height: 12.0,
                                                  ),
                                                  Image.network(
                                                    singleProduct.image,
                                                    height: 70,
                                                  ),
                                                  const SizedBox(
                                                    height: 12.0,
                                                  ),
                                                  Text(
                                                    singleProduct.name,
                                                    style: const TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                      "Price: \$${singleProduct.price}"),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  SizedBox(
                                                    height: 18,
                                                    child: OutlinedButton(
                                                      onPressed: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    ItemDetails(
                                                                        product:
                                                                            singleProduct)));
                                                      },
                                                      child: const Text(
                                                        "Buy",
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                    const SizedBox(
                      height: 12.0,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
