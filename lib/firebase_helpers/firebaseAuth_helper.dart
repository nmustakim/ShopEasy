import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../constants.dart';
import '../models/user.dart';
import '../screens/login/login.dart';

class FirebaseAuthHelper {
  static FirebaseAuthHelper firebaseAuthHelper = FirebaseAuthHelper();
  final _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<User?> get getAuthChange => _firebaseAuth.authStateChanges();

  Future<bool> login(String email, String password, BuildContext context) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return true;
    } on FirebaseAuthException catch (error) {
      _handleError(context, error);
      return false;
    }
  }

  void signOut(BuildContext context) async {
    try {
      _showLoaderDialog(context);
      await _firebaseAuth.signOut();
      Navigator.of(context, rootNavigator: true).pop();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
            (route) => false,
      );
    } on FirebaseAuthException catch (error) {
      _handleError(context, error);
    }
  }

  Future<bool> signUp(
      String name,
      String email,
      String age,
      String phone,
      String password,
      BuildContext context,
      ) async {
    try {
      _showLoaderDialog(context);
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final userModel = UserModel(
        id: userCredential.user!.uid,
        name: name,
        email: email,
        image: null,
        age: age,
        phone: phone,
      );

      await _firestore.collection("users").doc(userModel.id).set(userModel.toJson());
      Navigator.of(context, rootNavigator: true).pop();
      return true;
    } on FirebaseAuthException catch (error) {
      _handleError(context, error);
      return false;
    }
  }

  Future<bool> changePassword(String password, BuildContext context) async {
    try {
      _showLoaderDialog(context);
      await _firebaseAuth.currentUser!.updatePassword(password);
      Navigator.of(context, rootNavigator: true).pop();
      Fluttertoast.showToast(msg: "Password Changed");
      Navigator.of(context).pop();
      return true;
    } on FirebaseAuthException catch (error) {
      _handleError(context, error);
      return false;
    }
  }

  void _handleError(BuildContext context, FirebaseAuthException error) {
    Navigator.of(context, rootNavigator: true).pop();
    Fluttertoast.showToast(msg: error.code.toString());
  }

  void _showLoaderDialog(BuildContext context) {
    showLoaderDialog(context);
  }
}
