import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopeasy/repositories/product_repository.dart';
import '../../constants.dart';
import '../../global_widgets/bottomButton.dart';


class ItemDetails extends StatefulWidget {
 final String? image,name;
  final num ?price;


  const ItemDetails({super.key, this.image, this.name,this.price});

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
ProductRepository productRepository = ProductRepository();
var quantity = 0;
bool isAdded = false;
final FirebaseFirestore firestore = FirebaseFirestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;
Future checkAdded()async {
  final QuerySnapshot result =  await firestore.collection('users-cart').doc(_auth.currentUser!.email).collection('items').where('name',isEqualTo: widget.name).get();
  final List < DocumentSnapshot > documents = result.docs;
  if (documents.isNotEmpty) {
    isAdded = true;
  } else {
isAdded = false;
  }
}

  Future addToCart() async {
  var currentUser = _auth.currentUser;
  CollectionReference cr =
  firestore.collection("users-cart");
  return cr
      .doc(currentUser!.email)
      .collection("items")
      .doc()
      .set({
  "name": widget.name,
  "price": widget.price,
  "image": widget.image,
    "quantity":quantity,
  }).then((value) => print("Added to cart"));
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
          body: Stack(
        children: [
          Image.network(
            "${widget.image}",fit: BoxFit.fill,
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20, 260  ,20,20),

decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),),


              child: Material(
                color: Colors.white,
                elevation: 15,
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(55),topRight: Radius.circular(55),bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15),),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20,),
                      Text(
                        "${widget.name}",

                        style:   titleTextStyle1,
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        children: [
                          const Text(
                            "\$",
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          Text("${widget.price}", style:   bodyTextStyle1),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                              decoration: const BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.all(Radius.circular(6))),
                              padding: const EdgeInsets.all(2),
                              child: const Text(
                                "Per KG",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 12),
                              ))
                        ],
                      ),
                      const SizedBox(height: 20,),
                      Row(
                        children: [
                          const Icon(
                            Icons.star_rate_rounded,
                            color: Colors.orangeAccent,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "4.5",
                            style:   bodyTextStyle2,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text("(420)"),
                          const Expanded(child: SizedBox()),
                          InkWell(
                            onTap: (){if(quantity<50){setState(() {
                              quantity++;
                            });}},
                            child: const Icon(
                              Icons.add_circle,
                              size: 40,
                              color: Colors.red,
                            ),
                          ),
                          Text(
                            quantity.toString(),
                            style:   titleTextStyle3,
                          ),
                          InkWell(
                            onTap:(){if(quantity > 0){setState(() {
                              quantity--;
                            });}},
                            child: const Icon(
                              Icons.remove_circle,
                              size: 40,
                              color: Colors.red,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 30,),
                      Text(
                        "Details",
                        style:   titleTextStyle3,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                          "The ${widget.name} are consumed in diverse ways: raw or cooked, and in many dishes, sauces, salads, and drinks.vegetable ingredient or side dish.",
                          style:   bodyTextStyle3),
                      const Expanded(child: SizedBox()),
                      Row(
                        children: [
                          Expanded(
                            child: BottomButton(buttonName: "Add to cart", onPressed: ()async{
                              if(isAdded = true){
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Item already added')));
                              }
                              else if(quantity == 0){  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Choose quantity')));}
                              else{
                              await addToCart();
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Item added successfully')));
                            }}),
                          ),
                        ],
                      )

                    ],
                  ),
                ),
              ),
            ),

        ],
      )),
    );
  }
}
