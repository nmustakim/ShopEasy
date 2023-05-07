import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopeasy/models/product.dart';
import 'package:shopeasy/shop_provider/shop_provider.dart';
import '../../constants.dart';
import '../../global_widgets/bottomButton.dart';
import '../../global_widgets/bottom_appbar.dart';


class Cart extends StatefulWidget {
  const Cart({super.key});


  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {




  @override
  Widget build(BuildContext context) {
    ShopProvider shopProvider = Provider.of<ShopProvider>(context);
    return
      SafeArea(
        child: Scaffold(

        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text("Cart",style: titleTextStyle1,),
          elevation: 0,
          leading: IconButton(icon: const Icon(Icons.arrow_circle_left,color: Colors.red,size: 40,),onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>const BottomBar()));
          },)
        ),
            body:Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(

                children: [
                  Expanded(
                  child:ListView.builder(itemCount:shopProvider.getCartProductList.length,itemBuilder: (context,index){
                    ProductModel pm = shopProvider.getCartProductList[index];
                    return Card(
                      elevation: 2,
                      child: ListTile(
                        leading: Image.network(pm.image),
                        title: Text(pm.name),
                        subtitle: Text(pm.quantity.toString()),
                        trailing: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.min,children:
                        [
                         const Icon(Icons.add_circle) ,
                          const Text("12"),
                          const Icon(Icons.remove_circle),

                        ]
                          ,),

                      ),
                    );

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


