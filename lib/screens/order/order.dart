import 'package:flutter/material.dart';
import 'package:shopeasy/constants.dart';

class Order extends StatelessWidget {
  const Order({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
            backgroundColor: Colors.white,

            title: Text("Orders",style: titleTextStyle1,),
            foregroundColor: Colors.red,
            elevation: 0,
            leading: IconButton(icon: const Icon(Icons.arrow_circle_left),onPressed: (){
              Navigator.pop(context);
            },)
        ),
        body: ListView.builder(
            itemBuilder: (context,index){
              return Card(
                margin: const EdgeInsets.fromLTRB(8, 4, 8,4),
                elevation: 5,
                child: ListTile(
                  leading: Image.asset("assets/images/groceries.jpg"),
                  title: const Text("data"),
                  subtitle: const Text("5\$"),
                  trailing: const Text("data"),

                ),
              );
            }
        ),
      ),
    );
  }
}
