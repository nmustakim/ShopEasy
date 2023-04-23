import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopeasy/screens/login/login.dart';
import 'package:shopeasy/screens/registration/parts/reusable_part.dart';

import '../../constants.dart';
import '../../global_widgets/bottomButton.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({Key? key}) : super(key: key);

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  TextEditingController? nameController;
  TextEditingController? phoneController;
  TextEditingController? ageController;
  TextEditingController? genderController;
  TextEditingController? emailController;
  FirebaseFirestore? firestore;
  FirebaseAuth? firebaseAuth;
  @override
  void initState() {
    firebaseAuth = FirebaseAuth.instance;
    firestore = FirebaseFirestore.instance;
    phoneController = TextEditingController();
    nameController = TextEditingController();
    emailController = TextEditingController();
    ageController = TextEditingController();
    genderController = TextEditingController();
    super.initState();
  }
 static List<String> genderList = <String>["Male", "Female", "Other"];
  String? dropdownValue = genderList.first;

  @override
  Widget build(BuildContext context) {

sendUserData()async{
  var currentUser = firebaseAuth!.currentUser;
  CollectionReference collectionReference = firestore!.collection("users-data");
  return await collectionReference.doc(currentUser!.email).set({
    "name":nameController!.text,
    "phone":phoneController!.text,
    "age": ageController!.text,
    "gender": dropdownValue


  }).then((value) => print("User data added")).catchError((onError)=>print("Something wrong"));

  
}
    return Scaffold(
      body: ReusableBodyPart(
        topMargin: 120,
        childWidget: Padding(
          padding:  const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("User Details", style:  titleTextStyle1),
              const SizedBox(height: 4,),
              const Text("Please fill the field as follows to create your account"),
              const SizedBox(height: 16,),

              SizedBox(height: 50,
                  child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        hintText: "Enter your name",
                          labelText: "Name",
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)
                          ))
                  )),
              
              const SizedBox(
                height: 8,
              ),
              SizedBox(height: 50,
                  child: TextField(
                      controller: phoneController,
                      decoration: InputDecoration(
                          hintText: "Enter phone number",
                          labelText: "Phone number",
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)
                          ))
                  )),

              const SizedBox(
                height: 8,
              ),
              SizedBox(height: 50,
                  child: TextField(
                      controller:ageController,
                      decoration: InputDecoration(
                          hintText: "Enter your age",
                          labelText: "Age",
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)
                          ))
                  )),

              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(

                        borderRadius: BorderRadius.circular(12)),
                    child: const Text("Select your gender"),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  DropdownButton<String>(
                    value: dropdownValue!,
                    icon: const Icon(Icons.arrow_drop_down_sharp),
                    style: const TextStyle(color: Colors.deepPurple),
                    onChanged: (String? value) {
                      setState(() {
                        dropdownValue = value;
                      });
                    },
                    items: genderList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
         
         Row(
           children: [
             Expanded(
               child: BottomButton(buttonName: "Sign Up", onPressed: ()async{
                 await sendUserData();
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>const Login()));

               }),
             ),
           ],
         )
            ],
          ),
        ),
      ),
    );
  }
}
