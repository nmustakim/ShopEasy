import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../constants.dart';
import '../models/user.dart';

class FirebaseAuthHelper {
  static FirebaseAuthHelper firebaseAuthHelper = FirebaseAuthHelper();
  final _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<User?> get getAuthChange => _firebaseAuth.authStateChanges();

  Future <bool> login(String email, password, BuildContext context) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return true;
    }
    on FirebaseException catch (error) {
      Fluttertoast.showToast(msg: error.code.toString());
      return false;
    }
  }
  void signOut() async {
    await _firebaseAuth.signOut();
  }
  Future<bool> signUp(
      String name, String email, String password, BuildContext context) async {
    try {
      showLoaderDialog(context);
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      UserModel userModel = UserModel(
          id: userCredential.user!.uid, name: name, email: email, image: null, age: "", phone: "");

      _firestore.collection("users").doc(userModel.id).set(userModel.toJson());
      Navigator.of(context,rootNavigator: true).pop();
      return true;
    } on FirebaseAuthException catch (error) {
      Navigator.of(context,rootNavigator: true).pop();
      Fluttertoast.showToast(msg: error.code.toString());
      return false;
    }
  }
}