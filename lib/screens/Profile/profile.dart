import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopeasy/my_profile.dart';
import 'package:shopeasy/reusable_parts/bottomButton.dart';
import 'package:shopeasy/reusable_parts/bottom_appbar.dart';
import 'package:shopeasy/screens/Profile/profile_parts/profile_card.dart';
import 'package:shopeasy/screens/login/login.dart';
import '../../constants.dart';

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

                    return Text(snapshot.data["name"],style: titleTextStyle1,);
                  },
                ),
                Text(email!,style: titleTextStyle4.copyWith(color: Colors.black),),

                SizedBox(
                  height: 4,
                ),
                ProfileCard(icon: Icons.person, text: "My Profile",onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) { return MyProfile(); }));
                },),
                const SizedBox(
                  height: 4,
                ),
                ProfileCard(icon: Icons.list_alt_outlined, text: "My Order(s)",onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) { return Profile(); }));
                },),
                const SizedBox(
                  height: 4,
                ),
                ProfileCard(
                    icon: Icons.location_city_outlined, text: "Address",onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) { return Profile(); }));
                },),
                const SizedBox(
                  height: 4,
                ),
                ProfileCard(icon: Icons.settings, text: " Settings",onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) { return Profile(); }));
                },),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                        child: BottomButton(
                            buttonName: "Log Out", onPressed: () {})),
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
