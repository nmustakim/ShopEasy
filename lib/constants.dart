
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

    TextStyle titleTextStyle1 = const TextStyle(fontSize: 35, fontWeight: FontWeight.bold,color:Colors.red);
    TextStyle titleTextStyle2 = const TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
    TextStyle titleTextStyle3 = const TextStyle(fontSize: 25, fontWeight: FontWeight.bold);
    TextStyle titleTextStyle4 = const TextStyle(fontSize:20,color: Colors.white);
    TextStyle bodyTextStyle1 = const TextStyle(fontSize: 20);
    TextStyle bodyTextStyle2 = const TextStyle(fontSize: 15);
    TextStyle bodyTextStyle3 = const TextStyle(fontSize: 12);




bool loginVaildation(String email, String password) {
    if (email.isEmpty && password.isEmpty) {
     Fluttertoast.showToast(msg:'Both Fields are empty');

        return false;
    } else if (email.isEmpty) {
        Fluttertoast.showToast(msg:'Email is empty');
        return false;
    } else if (password.isEmpty) {
        Fluttertoast.showToast(msg:'Password is empty');
        return false;
    } else {
        return true;
    }

}
bool signUpVaildation(
    String email, String password, String name, String phone) {
    if (email.isEmpty && password.isEmpty && name.isEmpty && phone.isEmpty) {

        Fluttertoast.showToast(msg:'All Fields are empty');
        return false;
    } else if (name.isEmpty) {
        Fluttertoast.showToast(msg:'Name is empty');
        return false;
    } else if (email.isEmpty) {
        Fluttertoast.showToast(msg:'Email is empty');
        return false;
    } else if (phone.isEmpty) {
        Fluttertoast.showToast(msg:'Phone is empty');
        return false;
    } else if (password.isEmpty) {
        Fluttertoast.showToast(msg:'Password is empty');
        return false;
    } else {
        return true;
    }
}
showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
        content: Builder(builder: (context) {
            return SizedBox(
                width: 100,
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                        const CircularProgressIndicator(
                            color: Color(0xffe16555),
                        ),
                        const SizedBox(
                            height: 18.0,
                        ),
                        Container(
                            margin: const EdgeInsets.only(left: 7),
                            child: const Text("Loading...")),
                    ],
                ),
            );
        }),
    );
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
            return alert;
        },
    );
}




