import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopeasy/screens/login/login.dart';
import '../../constants.dart';
import '../../global_widgets/bottomButton.dart';

class Profile extends StatelessWidget {
  Profile({Key? key}) : super(key: key);

  FirebaseFirestore? firestore = FirebaseFirestore.instance;
 String? email = FirebaseAuth.instance.currentUser!.email;

  Future getUserdata() async {
    var userData = await firestore!
        .collection("users-data")
        .doc(email)
        .get();
    return userData;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
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
                  height: 4,
                ),
                FutureBuilder(
                  future: getUserdata(),
                  builder: (context, snapshot) {

    if (!snapshot.hasData){
    return const Center(child: Text("No data. Loading...."),);
    }
    else {
      return Text(snapshot.data["name"], style: titleTextStyle1,);
    }},
                ),
                Text(email!,style: titleTextStyle4.copyWith(color: Colors.black),),

                SizedBox(
                  height: 4,
                ),

                Row(
                  children: [
                    Expanded(
                        child: BottomButton(
                            buttonName: "Log Out", onPressed: () async{
                              bool loggedOut = false;
                              await FirebaseAuth.instance.signOut();
                              if(FirebaseAuth.instance.currentUser == null){
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
                              }



                            })),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    )));
  }
}
