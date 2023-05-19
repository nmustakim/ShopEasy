import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import '../../global_widgets/bottomButton.dart';
import '../../global_widgets/bottom_appbar.dart';
import '../../shop_provider/shop_provider.dart';
import '../cart/widgets/cart_product_card.dart';

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
                        itemCount: shopProvider.getFavoriteProductList.length,
                        itemBuilder: (context, index) {
                          return CartProductCard(productModel: shopProvider
                              .getCartProductList[index],);
                        }),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: BottomButton(
                            buttonName: 'Checkout', onPressed: () {}),
                      ),
                    ],
                  )
                ],
              ),
            )),
      );
    }
  }

