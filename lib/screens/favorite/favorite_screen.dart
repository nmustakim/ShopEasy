import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopeasy/screens/favorite/widgets/favorite_card.dart';
import '../../constants.dart';
import '../../global_widgets/bottom_button.dart';
import '../../shop_provider/shop_provider.dart';
import '../checkout_screen/check_out_cart.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
    Widget build(BuildContext context) {
      ShopProvider shopProvider = Provider.of<ShopProvider>(context);
      return SafeArea(
        child: Scaffold(
            appBar: AppBar(
                centerTitle: true,
                backgroundColor: Colors.white,
                title: Text(
                  "Favorites",
                  style: titleTextStyle1,
                ),
                elevation: 0,
            ),
            body: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 64),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: shopProvider.getFavoriteProductList.length,
                        itemBuilder: (context, index) {
                          return FavoriteCard(singleProduct: shopProvider
                              .getFavoriteProductList[index],);
                        }),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: BottomButton(
                            buttonName: 'Checkout', onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context)=>const CheckoutScreen()));}),
                      ),
                    ],
                  )
                ],
              ),
            )),
      );
    }
  }

