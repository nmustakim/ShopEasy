import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shopeasy/screens/cart/widgets/cart_product_card.dart';
import 'package:shopeasy/shop_provider/shop_provider.dart';
import '../../constants.dart';
import '../../global_widgets/bottom_button.dart';
import '../checkout_screen/check_out_cart.dart';


class Cart extends StatefulWidget {
   const Cart({super.key});


  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {

  @override
  Widget build(BuildContext context) {
    ShopProvider shopProvider = Provider.of<ShopProvider>(context);
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            foregroundColor:Colors.white,
            title: const Text(
              "Cart",
            ),
            elevation: 0,
          ),

          body: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 64),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: shopProvider.getCartProductList.length,
                      itemBuilder: (context, index) {

                        return CartProductCard(productModel:shopProvider.getCartProductList[index],);
                      }),
                ),
                const SizedBox(height: 12,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Text("Total",style: titleTextStyle3,),
                  Text(shopProvider.cartProductsTotalPrice().toString(),style: titleTextStyle3,)
                ],),
                const SizedBox(height: 12,),
                Row(
                  children: [
                    Expanded(
                      child: BottomButton(
                          buttonName: 'Checkout', onPressed: () {
                        shopProvider.getOrderedProducts.clear();
                        shopProvider.orderMultiProduct();
                        shopProvider.getCartProductList.clear();
                        if (shopProvider.getOrderedProducts.isEmpty) {
                          Fluttertoast.showToast(msg: "Cart is empty");
                        } else {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return const CheckoutScreen();
                              }

                          ));
                        }
                      }
    ),
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }
}
