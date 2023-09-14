import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopeasy/firebase_helpers/firestore_helper.dart';

import '../../constants.dart';
import '../../models/categories.dart';
import '../../models/product.dart';
import '../../shop_provider/shop_provider.dart';
import '../item_details/item_details.dart';
import '../product_by_category/products_by_categories.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = TextEditingController();
  List<CategoryModel> categoriesList = [];
  List<ProductModel> popularProductsList = [];
  List<ProductModel> searchList = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    final appProvider = Provider.of<ShopProvider>(context, listen: false);
    appProvider.getUserInfoFirebase();
    _getCategoryAndProducts();
  }

  Future<void> _getCategoryAndProducts() async {
    try {
      final categories =
      await FireStoreHelper.fireStoreHelper.getCategories();
      final popularProducts =
      await FireStoreHelper.fireStoreHelper.getPopular();

      if (mounted) {
        setState(() {
          categoriesList = categories;
          popularProductsList = popularProducts;
          isLoading = false;
        });
      }
    } catch (error) {

      print('Error fetching data: $error');
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

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
        appBar: AppBar(
          toolbarHeight: 100,
         title:  Text('Products',style: titleTextStyle1.copyWith(color: Colors.black),),
      elevation: 0,
          actions: [
           Image.asset('assets/images/logos_black.png',),
            const SizedBox(width:20)

          ],

        ),
        body: isLoading
            ? const Center(
          child: CircularProgressIndicator(),
        )
            : _buildHomeContent(),
      ),
    );
  }

  Widget _buildHomeContent() {
    return ListView(
      padding: const EdgeInsets.all(12.0),
      children: [
        SizedBox(
          height: 40,
          child: TextField(
            textAlign: TextAlign.center,
            onChanged: runFilter,
            controller: searchController,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white30,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              labelText: "Search by title",
              prefixIcon: const Icon(Icons.search_rounded),
              suffixIcon: const Icon(
                Icons.sort,
                color: Colors.red,
              ),
            ),
          ),
        ),
        const SizedBox(height: 24.0),
        const Text(
          "  Categories",
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        _buildCategories(),
        const SizedBox(height: 12.0),
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
        _buildProductGrid(),
      ],
    );
  }

  Widget _buildCategories() {
    return categoriesList.isEmpty
        ? const Center(
      child: Text("Categories is empty"),
    )
        : SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        margin: const EdgeInsets.only(left: 8),
        child: Row(
          children: categoriesList
              .map(
                (item) => Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: SizedBox(
                height: 100,
                width: 100,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProductByCategory(categoryModel: item),
                      ),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        item.image,
                        height: 50,
                        width: 100,
                      ),
                      Text(item.name),
                    ],
                  ),
                ),
              ),
            ),
          )
              .toList(),
        ),
      ),
    );
  }

  Widget _buildProductGrid() {
    final products = searchController.text.isNotEmpty && searchList.isEmpty
        ? const Center(
      child: Text("No Product Found"),
    )
        : searchList.isNotEmpty
        ? GridView.builder(
      padding: const EdgeInsets.only(bottom: 50),
      shrinkWrap: true,
      primary: false,
      itemCount: searchList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) {
        ProductModel product = searchList[index];
        return _buildProductCard(product);
      },
    )
        : popularProductsList.isEmpty
        ? const Center(
      child: Text("Best Product is empty"),
    )
        : GridView.builder(
      padding: const EdgeInsets.only(bottom: 50),
      shrinkWrap: true,
      primary: false,
      itemCount: popularProductsList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) {
        ProductModel singleProduct = popularProductsList[index];
        return _buildProductCard(singleProduct);
      },
    );

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: products,
    );
  }

  Widget _buildProductCard(ProductModel product) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          children: [
            const SizedBox(height: 12.0),
            Image.network(
              product.image,
              height: 70,
            ),
            const SizedBox(height: 12.0),
            Text(
              product.name,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text("Price: \$${product.price}"),
            const SizedBox(height: 5),
            SizedBox(
              height: 18,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ItemDetails(product: product),
                    ),
                  );
                },
                child: const Text("Buy"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
