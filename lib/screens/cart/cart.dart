import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../global_widgets/bottomButton.dart';


class Cart extends StatefulWidget {
  const Cart({super.key});


  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {


  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override

  String? email = FirebaseAuth.instance.currentUser!.email;




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
                  child:StreamBuilder(
                           stream: firestore.collection("users-cart").doc(email).collection("items").snapshots(),
                           builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                             if(snapshot.hasData) {

                               return ListView.builder(itemCount:snapshot.data!.docs.length,itemBuilder: (context,index){
                                 DocumentSnapshot data =
                                 snapshot.data!.docs[index];
                                 return Card(child: ListTile(
                                   onLongPress: () {
                                   firestore.collection("users-cart")
                                         .doc(email)
                                         .collection("items")
                                         .doc(data.id)
                                         .delete();
                                   },
                                   trailing: Image.network(data['image']),
                                   title: Text(data["name"]),
                                   subtitle: Text('${data["quantity"].toString()} KG'),
                                 ));
                               });
                             }
                             else{
                               return const Center(child: CircularProgressIndicator(),);
                             }
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


