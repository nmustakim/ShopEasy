
import 'package:flutter/material.dart';
import '../screens/Profile/profile.dart';
import '../screens/cart/cart.dart';
import '../screens/home/home.dart';


class BottomBar extends StatelessWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      BottomAppBar(

        elevation: 10,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>const Home()));}, icon:const Icon(Icons.home_filled)),
            IconButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> Cart()));}, icon:const Icon(Icons.shopping_cart)),
            IconButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile()));}, icon:const Icon(Icons.person)),
          ],
        ),);
  }
}
