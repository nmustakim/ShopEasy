import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopeasy/screens/forgot_password/forgot_password.dart';
import '../../constants.dart';
import '../../firebase_helpers/firebaseAuth_helper.dart';
import '../../global_widgets/bottomButton.dart';
import '../../global_widgets/bottom_appbar.dart';
import '../registration/parts/bottom_row.dart';
import '../registration/parts/reusable_part.dart';
import '../registration/registration.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController? emailController;
  TextEditingController? passwordController;
  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }
  signIn()async{
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
          email: emailController!.text,
          password: passwordController!.text);
      var authCredential = credential.user;
      if(authCredential!.uid.isNotEmpty){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const BottomBar()));
      }

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text("User not found"),
          action: SnackBarAction(label: 'Cancel', onPressed: (){
            Navigator.pop(context);
          }),),
        );

      }
      else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text("Wrong password!"),
          action: SnackBarAction(label: 'Cancel', onPressed: (){
            Navigator.pop(context);
          }),),
        );

      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return ReusableBodyPart(
         topMargin: 120,
        childWidget: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text("Sign In", style:   titleTextStyle1),
              const SizedBox(height: 8,),
              Text("Welcome back to explore the pure & fresh groceries of ShopEasy", style:   bodyTextStyle2),
              const SizedBox(
                height: 12,
              ),

              SizedBox(height: 50,
                  child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(

                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)
                          ))
                  )),
              const SizedBox(height: 8,),


              SizedBox(height: 50,
                  child: TextField(
                      obscureText: true,
                      controller: passwordController,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)
                          ))
                  )),
              const SizedBox(
                height: 20,
              ),
        Row(
          children: [
            Expanded(
              child: BottomButton(buttonName: 'Log in', onPressed: ()async{
bool isValidated = loginVaildation(emailController!.text, passwordController!.text);
if(isValidated == true){
  bool isLoggedIn = await FirebaseAuthHelper.firebaseAuthHelper.login(emailController!.text, passwordController!.text, context);
  if(isLoggedIn == true){
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const BottomBar()), (route) => false);
  }
}



              }
              ),
            ),
          ],
        ),

         TextButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>const ForgotPassword()));}, child: Text("Forgot password?",style:   bodyTextStyle1.copyWith(color: Colors.red),)),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: BottomRow(
                    navigatingScreen: const Registration(),
                    bottomText: "Don't have account?",
                    buttonName: "Sign Up"),
              ),
            ],
          ),
        ));
  }
}
