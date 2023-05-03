import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopeasy/constants.dart';
import 'package:shopeasy/repositories/product_repository.dart';
import 'package:shopeasy/screens/cart/cart.dart';
import 'package:shopeasy/screens/dairy/dairy.dart';
import 'package:shopeasy/screens/fruits/fruits.dart';
import 'package:shopeasy/screens/meat/meat.dart';
import 'package:shopeasy/screens/vegetables/vegetables.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../global_widgets/category_item_card.dart';
import '../../models/product.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ProductRepository? _productRepository;
  List<Product>? productsList;
  List<Product>? productsListContainer;
  final scaffoldKey = GlobalKey<ScaffoldState>();

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
      productsListContainer = await _productRepository!.getAllItems();
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            key: scaffoldKey,
            backgroundColor: Colors.white,
            appBar: AppBar(
              leading: IconButton(
                color: Colors.red,
                icon: const Icon(Icons.menu),
                onPressed: () {
                  if (scaffoldKey.currentState!.isDrawerOpen) {
                    scaffoldKey.currentState!.closeDrawer();
                    //close drawer, if drawer is open
                  } else {
                    scaffoldKey.currentState!.openDrawer();
                    //open drawer, if drawer is closed
                  }
                },
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const Cart()));
                    },
                    icon: const Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.redAccent,
                    ))
              ],
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              title: Text(
                "Products",
                style: titleTextStyle1,
              ),
            ),

            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(children: [
                    Container(
                      height: 120,
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              colors: [Color(0XFFE2E9FF), Color(0XFFFFEAEA)]),
                          borderRadius: BorderRadius.circular(16)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Free shipping',
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700,
                                  fontFamily:
                                      GoogleFonts.montserrat().fontFamily,
                                  color: Colors.red)),
                          const SizedBox(
                            height: 4,
                          ),
                          Row(
                            children: [
                              Text('When ordering',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      fontFamily:
                                          GoogleFonts.montserrat().fontFamily,
                                      color: const Color(0XFF000000))),
                              const Expanded(
                                child: SizedBox(),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: const Color(0XFFFFBB56)),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 3, 8, 3),
                                  child: Text('From 50\$',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: GoogleFonts.montserrat()
                                              .fontFamily,
                                          color: const Color(0XFF000000))),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ]),
                  const SizedBox(
                    height: 25,
                  ),
                  Expanded(
                    child: GridView.builder(
                        itemCount: productsList!.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                        itemBuilder: (context, index) {
                          Product data = productsList![index];
                          return InkWell(
                            onTap: () {
                              const List<Widget> screens = [
                                Fruits(),
                                Vegetables(),
                                Dairies(),
                                Meats()
                              ];
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => screens[index]));
                            },
                            child: GridTile(
                                child: CategoryItemCard(
                                    image: data.image, name: data.name)),
                          );
                        }),
                  ),
                ],
              ),
            )));
  }
}
