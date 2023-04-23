import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


import '../../constants.dart';
import '../../global_widgets/bottomButton.dart';

class Cart extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return
      SafeArea(
        child: Scaffold(

        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text("Cart",style: titleTextStyle1,),
          elevation: 0,
          leading: IconButton(icon: const Icon(Icons.arrow_circle_left),onPressed: (){
            Navigator.pop(context);
          },)
        ),
            body:Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(

                children: [
                  Expanded(
                    child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("users-cart").doc(FirebaseAuth.instance.currentUser!.email).collection("items").snapshots(),

                    builder: (context,snapshot){
                      if (!snapshot.hasData){
                        return const Center(child: Text("No data. Loading"),);
                      }
                      else {
                        return ListView.builder(
                            itemCount: snapshot.data!.docs.length,

                            itemBuilder: (context, index) {
                              DocumentSnapshot ds = snapshot.data!.docs[index];
                              return Card(child: ListTile(
                                trailing: Image.network(ds["image"]),
                                title: Text(ds["name"],),
                                subtitle: Text("${ds["price"]}\$"),));
                            });
                      }

        }
        ),
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
