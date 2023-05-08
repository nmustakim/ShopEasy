import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopeasy/shop_provider/shop_provider.dart';

import '../../../models/product.dart';

class CartProductCard extends StatefulWidget {
final ProductModel productModel;

  const CartProductCard({super.key, required this.productModel});

  @override
  State<CartProductCard> createState() => _CartProductCardState();
}

class _CartProductCardState extends State<CartProductCard> {
  int quantity = 1;
  @override
  void initState() {
quantity = widget.productModel.quantity!;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    ShopProvider shopProvider = Provider.of<ShopProvider>(context);
    return  Card(
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(height:100,width:80,color:Colors.black,child: InkWell(onTap:(){shopProvider.removeProduct(widget.productModel);},child: const Padding(
                padding: EdgeInsets.only(left: 30),
                child: Icon(Icons.delete_forever_rounded,color: Colors.red,size: 35,),
              ))),

            ],
          ),
          Container(
height: 100,
            width: 270,
            decoration: const BoxDecoration(color:Colors.white,borderRadius: BorderRadius.only(bottomRight: Radius.circular(15),topRight: Radius.circular(15))),
            child: Row(
mainAxisAlignment: MainAxisAlignment.start,
             children: [
               Container(padding:const EdgeInsets.only(left: 8,right: 8),height: 50,child:Image.network(widget.productModel.image)),

             Column(children: [
               const SizedBox(height: 30,),
               Text(widget.productModel.name,style: const TextStyle(fontSize:18,fontWeight: FontWeight.bold)),
               Text("${widget.productModel.price} \$")

             ],),
               const SizedBox(width: 8,),
               InkWell(
             onTap: () {
               setState(() {
                 quantity++;
               });
               shopProvider.updateQuantity(widget.productModel, quantity);
             },
             child: const Icon(
               Icons.add_circle,
               size: 25,
               color: Colors.red,
             ),
               ),
               Padding(
                 padding: const EdgeInsets.only(left: 4,right: 4),
                 child: Text(quantity.toString(),style: const TextStyle(fontSize:18,fontWeight: FontWeight.bold),),
               ),
               InkWell(
             onTap: () {
               if (quantity >= 1) {
                 setState(() {
                   quantity--;
                 });
                 shopProvider.updateQuantity(widget.productModel, quantity);

               }
             },
             child: const Icon(
               Icons.remove_circle,
               size: 25,
               color: Colors.red,
             ),
               ),





             ],
            ),
          ),

        ],
      ),
    );
  }
}
