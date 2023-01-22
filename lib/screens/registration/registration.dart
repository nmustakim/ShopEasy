import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopeasy/constants.dart';
import 'package:shopeasy/reusable_parts/bottomButton.dart';
import 'package:shopeasy/screens/terms_privacy_policies/terms_privacy.dart';
import 'package:shopeasy/screens/user_details/user_details.dart';
import '../login/login.dart';
import 'parts/bottom_row.dart';
import 'parts/reusable_part.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  FirebaseAuth? firebaseAuth;
  TextEditingController? emailController;
  TextEditingController? passwordController;
  bool? isChecked;
  @override
  void initState() {
    isChecked = false;

    emailController = TextEditingController();
    passwordController = TextEditingController();

    firebaseAuth = FirebaseAuth.instance;
    super.initState();
  }
  register()async{
    if(isChecked==false){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text("Check the box "),
        action: SnackBarAction(label: 'Cancel', onPressed: () {},),
      ));
    }
    else{
      try {
        final credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
            email: emailController!.text,
            password: passwordController!.text);
        var authCredential = credential.user;
        if(authCredential!.uid.isNotEmpty )
        {
          Navigator.push(context,
              MaterialPageRoute(
                  builder: (context) => const UserDetails()));}
        else{
          return ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Error!"),
          ));
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          await showDialog(
              context: context,
              builder: (context) =>
                  AlertDialog(
                    title: const Text("Weak Password!"),
                    content: const Text(
                        "The password you have provided is too weak"),
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: const ButtonStyle(
                              backgroundColor:
                              MaterialStatePropertyAll(
                                  Colors.red)),
                          child: const Text("Cancel"))
                    ],
                  ));
        } else if (e.code == 'email-already-in-use') {
          showDialog(
              context: context,
              builder: (context) =>
                  AlertDialog(
                    title: const Text("Used email"),
                    content: const Text(
                        "The account already exists for that email."),
                    actions: [
                      ElevatedButton(

                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: const ButtonStyle(
                              backgroundColor:
                              MaterialStatePropertyAll(
                                  Colors.red)),
                          child: const Text("Cancel"))
                    ],
                  ));
        }
      } catch (e) {
        print(e);
      }

    }

  }

  @override
  Widget build(BuildContext context) {
    return ReusableBodyPart(
      topMargin: 120,
      childWidget: Padding(
        padding: defaultPadding3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Sign Up", style: titleTextStyle1),
            const SizedBox(
              height: 8,
            ),
            Text("Welcome to explore the pure & fresh groceries of ShopEasy",
                style:bodyTextStyle2),
            const SizedBox(
              height: 16,
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

            const SizedBox(
              height: 8,
            ),
           SizedBox(height: 50,
               child: TextField(
                 obscureText: true
                   ,
                 controller: passwordController,
                 decoration: InputDecoration(

                   filled: true,
                   fillColor: Colors.white,
                   border: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(12)
                   ))
               )),
          Row(
                children: [
                  Checkbox(
                      checkColor: Colors.black,
                      fillColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.red),
                      value: isChecked,
                      onChanged: (value) {
                        setState(() {
                          isChecked = value;
                        });
                      }),
                  const Text("I accepted "),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const TermsAndPrivacy()));
                      },
                      child: const Text(
                        "Terms & Privacy Policies,",
                        style: TextStyle(color: Colors.red),
                      ))
                ],
              ),

            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: BottomButton(buttonName: 'Next',

                    onPressed: () async {
                    register();

                      }

                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: BottomRow(
                  navigatingScreen: const Login(),
                  bottomText: "Already have an account? ",
                  buttonName: "Sign In"),
            )
          ],
        ),
      ),
    );
  }
}
