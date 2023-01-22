import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopeasy/constants.dart';
import 'package:shopeasy/reusable_parts/bottom_appbar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shopeasy/reusable_parts/category_item_card.dart';
import 'package:shopeasy/screens/dairy/dairy.dart';
import 'package:shopeasy/screens/item_details/item_details.dart';
import 'package:shopeasy/screens/vegetables/vegetables.dart';
import '../fruits/fruits.dart';
import '../item_card/item_card.dart';
import '../meat/meat.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future getPopular() async{
      var popular = await firestore.collection("popular").get();
      return popular;

    }
    Future getCategory() async{
      var category = await firestore.collection("categories").get();
      return category;

    }
    return SafeArea(
      child: Scaffold(
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             Container(
               margin: const EdgeInsets.all(8),
                
                height: 45,
                child: TextField(

                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
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
             Padding(
               padding: const EdgeInsets.all(6.0),
               child: Center(child: Text("Popular",style: titleTextStyle4,)),
             ),
            FutureBuilder(
                 future: getPopular(),
                   builder: (context,snapshot){
                   if (!snapshot.hasData){
                     return const Center(child: Text("No data. Loading...."),);
                   }
                   else{
                   return CarouselSlider.builder(
                    itemBuilder: (BuildContext context, int index, int realIndex) {
                       DocumentSnapshot pl = snapshot.data!.docs[index];
                       return InkWell(
                         onTap: (){
                           Navigator.push(context, MaterialPageRoute(builder: (context)=>ItemDetails(name: pl["name"],price: pl["price"],image:pl["image"])));
                         },
                           child: ItemCard(image:pl["image"],name:pl["name"],price:pl["price"]));

                   }, itemCount: snapshot.data!.docs.length, options:CarouselOptions(
                     disableCenter: true,
                  height: 115,
                     enableInfiniteScroll: true,
                     autoPlay: true,
                   ),

                   );

                   }}),



              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Text("Categories",style: titleTextStyle4,),
              ),
             FutureBuilder(
             future: getCategory(),
                  builder: (context,snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: Text("No data...Loading"),);
                    }
                    else {
                      return Expanded(
                        child: GridView.builder(
                            itemCount: snapshot.data!.docs.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2), itemBuilder: (context, index) {
                          DocumentSnapshot data = snapshot.data!.docs[index];
                          return InkWell(
                            onTap: (){
                             const List <Widget> screens = [Fruits(),Vegetables(),Dairy(),Meat()];
                             Navigator.push(context, MaterialPageRoute(builder: (context)=>screens[index]));

                            },
                            child: GridTile(
                                child: CategoryItemCard(image: data["image"], name: data["name"])),
                          );
                        }),
                      );
                    }
                  }
              ),
              const SizedBox(
                height: 40,
                child: BottomBar(
                ),
              )
            ],
          ),
        )
    );
  }
}
