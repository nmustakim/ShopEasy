import 'package:flutter/material.dart';

bool validateInput(String email, String password,context) {

  if (email.isEmpty || password.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Please fill in all fields."),
        action: SnackBarAction(
          label: 'Cancel',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
    return false;
  }
  return true;
}