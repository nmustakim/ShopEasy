import 'package:flutter/material.dart';
import 'package:shopeasy/constants.dart';
import 'package:shopeasy/firebase_helpers/firebaseAuth_helper.dart';
import 'package:shopeasy/global_widgets/bottom_appbar.dart';
import 'package:shopeasy/screens/terms_privacy_policies/terms_privacy.dart';
import '../../global_widgets/bottom_button.dart';
import '../../utils/registration_utils.dart';
import '../login/login.dart';
import 'widgets/bottom_row.dart';
import 'widgets/reusable_part.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isObscure = true;
  bool? isChecked = false;

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    ageController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String hintText,
  }) {
    return SizedBox(
      height: 50,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget buildPasswordTextField() {
    return SizedBox(
      height: 50,
      child: TextField(
        obscureText: isObscure,
        controller: passwordController,
        decoration: InputDecoration(
          hintText: "Password",
          suffixIcon: InkWell(
            onTap: () {
              setState(() {
                isObscure = !isObscure;
              });
            },
            child: const Icon(Icons.remove_red_eye_sharp),
          ),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget buildCheckboxRow(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          checkColor: Colors.black,
          fillColor: MaterialStateProperty.resolveWith(
                (states) => Colors.red,
          ),
          value: isChecked,
          onChanged: (value) {
            setState(() {
              isChecked = value;
            });
          },
        ),
        const Text("I accepted "),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const TermsAndPrivacy(),
              ),
            );
          },
          child: const Text(
            "Terms & Privacy Policies,",
            style: TextStyle(color: Colors.red),
          ),
        )
      ],
    );
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
            const SizedBox(height: 8),
            Text(
              "Welcome to explore the pure & fresh groceries of ShopEasy",
              style: bodyTextStyle2,
            ),
            const SizedBox(height: 16),
            buildTextField(controller: nameController, hintText: "Name"),
            const SizedBox(height: 8),
            buildTextField(controller: phoneController, hintText: "Phone"),
            const SizedBox(height: 8),
            buildTextField(controller: emailController, hintText: "Email"),
            const SizedBox(height: 8),
            buildPasswordTextField(),
            buildCheckboxRow(context),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: BottomButton(
                    buttonName: 'Sign Up',
                    onPressed: () async {
                      bool isValidated = signUpValidation(
                        nameController.text,
                        emailController.text,
                        phoneController.text,
                        passwordController.text,
                      );
                      if (isValidated) {
                        bool isLoggedIn = await FirebaseAuthHelper
                            .firebaseAuthHelper
                            .signUp(
                          nameController.text,
                          emailController.text,
                          ageController.text,
                          phoneController.text,
                          passwordController.text,
                          context,
                        );
                        if (isLoggedIn) {
                          Future.delayed(const Duration(seconds: 1), () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const BottomBar(),
                              ),
                                  (route) => false,
                            );
                          });
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: BottomRow(
                navigatingScreen: const Login(),
                bottomText: "Already have an account? ",
                buttonName: "Sign In",
              ),
            )
          ],
        ),
      ),
    );
  }
}
