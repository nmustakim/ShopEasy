import 'package:flutter/material.dart';
import 'package:shopeasy/constants.dart';
import 'package:shopeasy/firebase_helpers/firebaseAuth_helper.dart';
import 'package:shopeasy/global_widgets/bottom_appbar.dart';
import 'package:shopeasy/screens/terms_privacy_policies/terms_privacy.dart';
import '../../global_widgets/bottom_button.dart';
import '../login/login.dart';
import 'widgets/bottom_row.dart';
import 'widgets/reusable_part.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {

  TextEditingController? emailController;
  TextEditingController? passwordController;
  TextEditingController? nameController;
  TextEditingController? phoneController;
  TextEditingController? ageController;

bool isObscure = true;
  bool? isChecked;
  @override
  void initState() {
    isChecked = false;
  nameController = TextEditingController();
 phoneController = TextEditingController();
    emailController = TextEditingController();
    ageController = TextEditingController();
    passwordController = TextEditingController();
    
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return ReusableBodyPart(
      topMargin: 120,
      childWidget: Padding(
        padding: const EdgeInsets.all(8),
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
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: "Name",
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
                        hintText: "phone",
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
                    controller: emailController,
                    decoration: InputDecoration(
                        hintText: "Email",
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
                 obscureText: isObscure,

                 controller: passwordController,
                 decoration: InputDecoration(
                     hintText: "Password",
                     suffixIcon: InkWell(onTap:(){setState(() {
                       isObscure = !isObscure;
                     });},child: const Icon(Icons.remove_red_eye_sharp)),

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
                  child: BottomButton(buttonName: 'Sign Up',

                    onPressed: ()  async{
                    
bool isValidated = signUpVaildation(  nameController!.text,emailController!.text, phoneController!.text,passwordController!.text);
if(isValidated == true){
  bool isLoggedIn = await FirebaseAuthHelper.firebaseAuthHelper.signUp( nameController!.text,emailController!.text, ageController!.text,phoneController!.text,passwordController!.text,context);
  if(isLoggedIn == true){
    Future.delayed(const Duration(seconds: 1), () {

      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const BottomBar()), (route) => false);
    });

  }
}
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
