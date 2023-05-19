import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shopeasy/models/product.dart';
import '../../constants.dart';
import '../../global_widgets/bottomButton.dart';
import '../../shop_provider/shop_provider.dart';
import '../cart/cart.dart';

class ItemDetails extends StatefulWidget {
  final ProductModel product;

  const ItemDetails({super.key, required this.product});

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    ShopProvider shopProvider = Provider.of<ShopProvider>(
      context,
    );
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            foregroundColor: Colors.red,
            elevation: 0,
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Cart()));
                  },
                  icon: const Icon(
                    Icons.shopping_cart_outlined,
                  )),
            ],
          ),
          body: Stack(
            children: [
              Image.network(
                widget.product.image,
                height: 150,
                width: 420,
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 180, 20, 70),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Material(
                  color: Colors.white,
                  elevation: 15,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(55),
                    topRight: Radius.circular(55),
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.product.name,
                              style: titleTextStyle1,
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  widget.product.isFav =
                                  !widget.product.isFav;
                                });
                                if (widget.product.isFav) {
                                  shopProvider.addToFavorite(widget.product);

                                } else {
                                  shopProvider.removeFavorite(widget.product);

                                }
                              },
                              icon: Icon(color:Colors.red,shopProvider.getFavoriteProductList
                                  .contains(widget.product)
                                  ? Icons.favorite
                                  : Icons.favorite_outline),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const Text(
                              "\$",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            Text(widget.product.price.toString(),
                                style: bodyTextStyle1),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                                decoration: const BoxDecoration(
                                    color: Colors.red,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6))),
                                padding: const EdgeInsets.all(2),
                                child: const Text(
                                  "Per KG",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ))
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [

                            const SizedBox(
                              width: 5,
                            ),

                            const Expanded(child: SizedBox()),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  quantity++;
                                });
                              },
                              child: const Icon(
                                Icons.add_circle,
                                size: 30,
                                color: Colors.red,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                quantity.toString(),
                                style: titleTextStyle3,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                if (quantity >= 1) {
                                  setState(() {
                                    quantity--;
                                  });
                                }
                              },
                              child: const Icon(
                                Icons.remove_circle,
                                size: 30,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Details",
                          style: titleTextStyle3,
                        ),
                        Text(
                            "The ${widget.product.name} are consumed in diverse ways: raw or cooked, and in many dishes, sauces, salads, and drinks.vegetable ingredient or side dish.",
                            style: bodyTextStyle3),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: BottomButton(
                                  buttonName: "Add to cart",
                                  onPressed: () {

                                     if(quantity == 0){
                                      Fluttertoast.showToast(msg: "Choose quantity");
                                    }
                                    else {

                                      ProductModel pm = widget.product
                                          .copyWith(quantity: quantity);
                                      shopProvider.addProduct(pm);


                                    }

                                  }),
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
