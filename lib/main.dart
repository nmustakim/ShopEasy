import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopeasy/firebase_helpers/firebaseAuth_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shopeasy/screens/splash_screen/splash_screen.dart';
import 'package:shopeasy/shop_provider/shop_provider.dart';
import 'firebase_options.dart';
import 'global_widgets/bottom_appbar.dart';
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
    return ChangeNotifierProvider(
      create: (context)=>ShopProvider(),
     child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

fontFamily: ('NovaRound'),

        primarySwatch: Colors.red,


      ),
      home: StreamBuilder(
        stream: FirebaseAuthHelper.firebaseAuthHelper.getAuthChange,
        builder: (context,snapshot){
          if(snapshot.hasData){
            return const BottomBar();
          }
          else{
            return SplashScreen();
          }
        },

      )
    )
    );
  }
}


