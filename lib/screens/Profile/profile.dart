import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  TextEditingController ?_name;
  TextEditingController ?_phone;
  TextEditingController ?_age;
  CollectionReference collectionReference = FirebaseFirestore.instance.collection("users-data");


  setToTextField(data){
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Name',style: titleTextStyle4,),
        const SizedBox(height: 8,),
        TextField(
          decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
          controller: _name = TextEditingController(text: data['name']),
        ),
        const SizedBox(height: 15,),
        Text('Phone',style: titleTextStyle4,),
        const SizedBox(height: 8,),
        TextField(
          decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
          controller: _phone = TextEditingController(text: data['phone']),
        ),
        const SizedBox(height: 15,),
        Text('Age',style: titleTextStyle4,),
        const SizedBox(height: 8,),
        TextField(
          decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
          controller: _age = TextEditingController(text: data['age']),
        ),
        const SizedBox(height: 15,),
        Center(child: ElevatedButton(
          style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
            onPressed: ()=>updateData(), child: const Text("Update")))
      ],
    );
  }

  updateData(){

    return collectionReference.doc(FirebaseAuth.instance.currentUser!.email).update(
        {
          "name":_name!.text,
          "phone":_phone!.text,
          "age":_age!.text,
        }
    ).then((value) => print("Updated Successfully"));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text("Profile", style: titleTextStyle1),
              const SizedBox(
                height: 8,
              ),
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage("assets/images/profilepic.jpg"),
              ),
              const SizedBox(
                height: 20,
              ),
              StreamBuilder(
                stream: collectionReference.doc(FirebaseAuth.instance.currentUser!.email).snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot){
                  var data = snapshot.data;
                  if(data==null){
                    return const Center(child: CircularProgressIndicator(),);
                  }
                  return setToTextField(data);
                },

              ),
            ],
          ),
        )),
      ),
    );
  }
}