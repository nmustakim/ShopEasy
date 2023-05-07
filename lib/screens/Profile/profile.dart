import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../constants.dart';
import '../../firebase_helpers/firestore_helper.dart';
import '../../models/user.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  TextEditingController? _name;
  TextEditingController? _email;
  TextEditingController? _phone;
  TextEditingController? _age;
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection("users");

  UserModel? user;
  bool isLoading = false;

  @override
  void initState() {
    getUser();
    super.initState();
  }

  getUser() async {
    setState(() {
      isLoading = true;
    });

    user = await FireStoreHelper.fireStoreHelper.getUser();

    setState(() {
      isLoading = false;
    });
  }

  setToTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Name'),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          height: 35,
          child: TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15))),
            controller: _name = TextEditingController(text: user!.name),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text('Email'),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          height: 35,
          child: TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15))),
            controller: _email = TextEditingController(text: user!.email),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text('Phone'),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          height: 35,
          child: TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15))),
            controller: _phone = TextEditingController(text: user!.phone),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          'Age',
        ),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          height: 35,
          child: TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15))),
            controller: _age = TextEditingController(text: user!.age),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Center(
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
                onPressed: () => updateData(),
                child: const Text("Update")))
      ],
    );
  }

  updateData() {
    return collectionReference
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      "name": _name!.text,
      "email": _email!.text,
      "phone": _phone!.text,
      "age": _age!.text,
    }).then((value) => Fluttertoast.showToast(msg: 'Updated'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(
              child: SizedBox(
                  height: 50, width: 50, child: CircularProgressIndicator()),
            )
          : SingleChildScrollView(
              child: SafeArea(
                  child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text("Profile", style: titleTextStyle1),
                    const SizedBox(
                      height: 8,
                    ),
                    const CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          AssetImage("assets/images/profilepic.jpg"),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    setToTextField()
                  ],
                ),
              )),
            ),
    );
  }
}
