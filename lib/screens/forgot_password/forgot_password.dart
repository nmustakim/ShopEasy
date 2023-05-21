import 'package:flutter/material.dart';
import 'package:shopeasy/screens/change_password/change_password.dart';
import '../../constants.dart';
import '../../global_widgets/bottom_button.dart';
import '../registration/widgets/reusable_part.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}



class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController? emailController;
  @override
  void initState() {
  emailController = TextEditingController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ReusableBodyPart(topMargin: 60, childWidget: Padding(
      padding:  EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            "Forgot password",
              style:  titleTextStyle1),
         const SizedBox(height: 4,),
         const Text("Submit your email to change your your password"),
         const SizedBox(height: 24,),

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
          const SizedBox(height: 20,),
        Row(
          children: [
            Expanded(child: BottomButton(buttonName: 'Submit', onPressed:(){

              Navigator.push(context, MaterialPageRoute(builder: (context)=>const ChangePassword()));
              })),
          ],
        )


        ],
      ),
    ));
  }
}












