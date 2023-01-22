import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopeasy/reusable_parts/bottomButton.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}


class _MyProfileState extends State<MyProfile> {
  TextEditingController? nameController;
  TextEditingController? phoneController;
  TextEditingController? ageController;
  FirebaseFirestore? firestore;
  FirebaseAuth? auth;

  sendData(data){
    return Column(
      children: [
        TextFormField(controller: nameController,initialValue: data["name"],),
        TextFormField(controller: phoneController,initialValue: data["phone"],),
        TextFormField(controller: ageController,initialValue: data["age"],),
        BottomButton(buttonName: 'Update Profile', onPressed:() {
        updateData;

    })

      ],
    );
  }
  updateData(){
    CollectionReference collectionReference = firestore!.collection("users-data");
    return collectionReference.doc(auth!.currentUser!.email).update({
      "name": nameController!.text,
      "phone": phoneController!.text,
      "age": ageController!.text,
    });
  }
  @override
  void initState() {
    auth = FirebaseAuth.instance;
    firestore = FirebaseFirestore.instance;
   nameController = TextEditingController();
   phoneController = TextEditingController();
   ageController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Profile"),),
      backgroundColor: Colors.white,
      body: StreamBuilder(
        stream: firestore!.collection("users-data").doc(auth!.currentUser!.email).snapshots(),
        builder: (context,snapshot){
          var data = snapshot.data;
          if(!snapshot.hasData){
            return const Center(child:Text("No data..."));
          }
          else {
            return sendData(data);
          }

        },
  )
    );
  }
}
