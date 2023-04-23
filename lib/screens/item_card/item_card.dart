import 'package:flutter/material.dart';
import 'package:shopeasy/constants.dart';



class ItemCard extends StatelessWidget {


final String image,name;
final num price;


 const ItemCard({super.key,required this.image,required this.name,required this.price});



  @override
  Widget build(BuildContext context) {

    return Card(
      elevation: 5,
      child: Column(

                  children: [
                      Image.network(image,height:80,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(name,style:bodyTextStyle2,),
                        const Icon(Icons.arrow_right_sharp),
                        Text("$price\$",style: bodyTextStyle2,),
                      ],
                    )


                  ],
                ),
    );
  }
}
