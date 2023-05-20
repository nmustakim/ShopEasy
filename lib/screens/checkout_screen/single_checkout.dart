import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopeasy/firebase_helpers/firestore_helper.dart';
import 'package:shopeasy/global_widgets/bottomButton.dart';
import 'package:shopeasy/models/product.dart';

import '../../global_widgets/bottom_appbar.dart';
import '../../shop_provider/shop_provider.dart';


class SingleCheckoutScreen extends StatefulWidget {
 final ProductModel productModel;

  const SingleCheckoutScreen({super.key, required this.productModel});

  @override
  State<SingleCheckoutScreen> createState() => _SingleCheckoutScreenState();
}

class _SingleCheckoutScreenState extends State<SingleCheckoutScreen> {
  int groupValue = 1;
  @override
  Widget build(BuildContext context)
  {
    ShopProvider shopProvider = Provider.of<ShopProvider>(context);
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            "SingleCheckoutScreen",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(children: [
            const SizedBox(
              height: 36.0,
            ),
            Container(
              height: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                      color: Theme.of(context).primaryColor, width: 3.0)),
              width: double.infinity,
              child: Row(
                children: [
                  Radio(
                    value: 1,
                    groupValue: groupValue,
                    onChanged: (value) {
                      setState(() {
                        groupValue = value!;
                      });
                    },
                  ),
                  const Icon(Icons.money),
                  const SizedBox(
                    width: 12.0,
                  ),
                  const Text(
                    "Cash on Delivery",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
            Container(
                height: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                        color: Theme.of(context).primaryColor, width: 3.0)),
                width: double.infinity,
                child: Row(children: [
                  Radio(
                    value: 2,
                    groupValue: groupValue,
                    onChanged: (value) {
                      setState(() {
                        groupValue = value!;
                      });
                    },
                  ),
                  const Icon(Icons.money),
                  const SizedBox(
                    width: 12.0,
                  ),
                  const Text(
                    "Online payment",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ])),
           const SizedBox(height: 20,),
           Row(
             children: [
               Expanded(child: BottomButton(buttonName: "Continue", onPressed: ()async {

                 shopProvider.orderSingleProduct(widget.productModel);
                bool isTrue = await FireStoreHelper.fireStoreHelper.orderToFirebase(shopProvider.getOrderedProducts, context,groupValue==1? "COD": "PO");
                 shopProvider.getOrderedProducts.clear();
                if(isTrue){
                  Future.delayed(const Duration(seconds: 2), () {

                    Navigator.push(context,MaterialPageRoute(builder: (context)=>const BottomBar()));
                  });

                }
               })),
             ],
           )
          ]),
        ));
  }
}
