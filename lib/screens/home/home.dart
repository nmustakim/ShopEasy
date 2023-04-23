import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopeasy/constants.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shopeasy/repositories/product_repository.dart';
import 'package:shopeasy/screens/dairy/dairy.dart';
import 'package:shopeasy/screens/item_details/item_details.dart';
import 'package:shopeasy/screens/vegetables/vegetables.dart';
import '../../global_widgets/bottom_appbar.dart';
import '../../global_widgets/category_item_card.dart';
import '../../models/fruit.dart';
import '../fruits/fruits.dart';
import '../item_card/item_card.dart';
import '../meat/meat.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ProductRepository? _productRepository;
  List<Product>? productsList;
  List<Product>? productsListContainer;
  List<Product>? popularList;
  List<Product>? popularListContainer;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  void initState() {
_productRepository = ProductRepository();
productsList = [];
productsListContainer = [];
popularList = [];
popularListContainer = [];
fetchFruitsList();
fetchPopularList();
    super.initState();
  }
  void fetchFruitsList()async {
    try {
      productsListContainer = await _productRepository!.getAllItems();
      if (productsListContainer!.isNotEmpty) {
        setState(() {
          productsList = productsListContainer;
        });
      } else {}
    }
    catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.toString())));
    }
  }
  void fetchPopularList()async {
    try {
      popularListContainer = await _productRepository!.getAllPopular();
      if (popularListContainer!.isNotEmpty) {
        setState(() {
          popularList = popularListContainer;
        });
      } else {}
    }
    catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.toString())));
    }
  }
  @override
  Widget build(BuildContext context) {


    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

               Text("Popular",style: titleTextStyle4,),
                SizedBox(height: 10,),
            CarouselSlider.builder(
                      itemBuilder: (BuildContext context, int index, int realIndex) {
                        Product pl = popularList![index];
                         return InkWell(
                           onTap: (){
                             Navigator.push(context, MaterialPageRoute(builder: (context)=>ItemDetails(name: pl.name,price: pl.price,image:pl.image)));
                           },
                             child: ItemCard(image:pl.image,name:pl.name,price:pl.price));

                     }, itemCount: popularList!.length.compareTo(0), options:CarouselOptions(
                       disableCenter: true,
                    height: 115,
                       enableInfiniteScroll: true,
                       autoPlay: true,
                     ),

                     ),


const SizedBox(height: 25,),
                Text("Categories",style: titleTextStyle4,),
               SizedBox(height: 20,),

                   Expanded(
                          child: GridView.builder(
                              itemCount:productsList!.length,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2), itemBuilder: (context, index) {
                            Product data = productsList![index];
                            return InkWell(
                              onTap: (){
                               const List <Widget> screens = [Fruits(),Vegetables(),Dairy(),Meat()];
                               Navigator.push(context, MaterialPageRoute(builder: (context)=>screens[index]));

                              },
                              child: GridTile(
                                  child: CategoryItemCard(image: data.image, name: data.name)),
                            );
                          }),
                        ),

                const SizedBox(
                  height: 40,
                  child: BottomBar(
                  ),
                )
              ],
            ),
        ),
        )
    );
  }
}
