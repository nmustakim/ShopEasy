import 'package:flutter/material.dart';
import 'package:shopeasy/screens/splash/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
Future <void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp( (const ShopEasy()));
}

class ShopEasy extends StatelessWidget {
  const ShopEasy({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

fontFamily: ('NovaRound'),

        primarySwatch: Colors.red,


      ),
      home: const SplashScreen(

      )
    );
  }
}


