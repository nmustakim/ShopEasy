import 'package:flutter/material.dart';
import 'package:shopeasy/global_widgets/bottomButton.dart';
import 'package:shopeasy/screens/registration/registration.dart';

import 'login/login.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(padding: const EdgeInsets.all(24),child: Center(
        child: Column(
mainAxisAlignment: MainAxisAlignment.center,
          children: [
          SizedBox(width:300,child: BottomButton(buttonName: 'Login', onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>const Login()));})),
          SizedBox(height: 25,),
          SizedBox(width:300,child: BottomButton(buttonName: 'SignUp', onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>const Registration()));}))
        ],),
      ),),
    );
  }
}
