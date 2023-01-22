import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shopeasy/constants.dart';
import 'package:shopeasy/screens/registration/registration.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const Registration()), (route) => false); });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Image.asset("assets/images/logo.png",height: 200,width:300)),
           Text("ShopEasy",style:titleTextStyle1),
          const Text("Shopping made easy")
        ],
      ),
    );
  }
}
