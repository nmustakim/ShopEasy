import 'package:fluttertoast/fluttertoast.dart';

bool signUpValidation(
    String name,
    String email,
    String phone,
    String password,
    ) {

  if (name.isEmpty || email.isEmpty || phone.isEmpty || password.isEmpty) {
    Fluttertoast.showToast(msg: "Please fill in all fields.");
    return false;
  }

  return true;
}
