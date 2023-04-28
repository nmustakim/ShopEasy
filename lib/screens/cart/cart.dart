import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../global_widgets/bottomButton.dart';
import '../../models/cart_product.dart';
import '../../models/product.dart';
import '../../repositories/cart_products_repo.dart';


class Cart extends StatefulWidget {

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  CartProductRepository? _productRepository;
  List<CartProduct>? productsList;
  List<CartProduct>? productsListContainer;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  void initState() {
    _productRepository = CartProductRepository();
    productsList = [];
    productsListContainer = [];
    fetchCart();

    super.initState();
  }

  void fetchCart() async {
    try {
      productsListContainer = await _productRepository!.getCartItems();
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
    return
      SafeArea(
        child: Scaffold(

        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text("Cart",style: titleTextStyle1,),
          elevation: 0,
          leading: IconButton(icon: const Icon(Icons.arrow_circle_left),onPressed: (){
            Navigator.pop(context);
          },)
        ),
            body:Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(

                children: [
                  Expanded(
                  child:ListView.builder(
                            itemCount:productsList!.length,
                            itemBuilder: (context, index) {
                              CartProduct pl = productsList![index];
                              return Card(child: ListTile(
                                onLongPress: (){},
                                trailing: Image.network(pl.image),
                                title: Text(pl.name,),
                                subtitle: Text('${pl.quantity.toString()} KG'),
                             ));
                            })
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: BottomButton(buttonName: 'Checkout', onPressed: (){

                        }),
                      ),
                    ],
                  )
                ],
              ),
            )
    ),
      );
  }
}
