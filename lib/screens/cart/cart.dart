import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopeasy/screens/cart/widgets/cart_product_card.dart';
import 'package:shopeasy/shop_provider/shop_provider.dart';
import '../../constants.dart';
import '../../global_widgets/bottomButton.dart';
import '../../global_widgets/bottom_appbar.dart';
import '../checkout_screen/check_out_cart.dart';
import '../checkout_screen/single_checkout.dart';

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
              backgroundColor: Colors.white,
              title: Text(
                "Cart",
                style: titleTextStyle1,
              ),
              elevation: 0,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_circle_left,
                  color: Colors.red,
                  size: 40,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BottomBar()));
                },
              )),
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
                          buttonName: 'Checkout', onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context){
                            shopProvider.getOrderedProducts.clear();
                            shopProvider.orderMultiProduct();
                            shopProvider.getCartProductList.clear();

                            return const CheckoutScreen();}));}),
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }
}
