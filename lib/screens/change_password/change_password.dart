
import 'package:flutter/material.dart';
import 'package:shopeasy/screens/login/login.dart';
import '../../constants.dart';
import '../../global_widgets/bottomButton.dart';
import '../registration/parts/reusable_part.dart';


class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController? changePasswordController;
  TextEditingController? confirmPasswordController;
  @override
  void initState() {
    changePasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ReusableBodyPart(topMargin: 70, childWidget: Padding(
      padding:   EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Change password",
            style:  titleTextStyle1),

          const SizedBox(height: 24,),
          const Text("Password"),
          const SizedBox(height: 4,),

          SizedBox(height: 50,
              child: TextField(
                  controller: changePasswordController,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)
                      ))
              )),
          const SizedBox(height: 20,),
          const Text("Confirm password"),
        const SizedBox(height: 4,),
          SizedBox(height: 50,
              child: TextField(
                  controller: confirmPasswordController,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)
                      ))
              )),
          const SizedBox(height: 25,),
        Row(
          children: [
            Expanded(child: BottomButton(buttonName: 'Reset password', onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>const Login()));})),
          ],
        )

        ],
      ),
    ));
  }
}
