import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/categories.dart';
import '../models/product.dart';
import '../models/user.dart';

class FireStoreHelper{

  static FireStoreHelper fireStoreHelper = FireStoreHelper();
  final _firestore = FirebaseFirestore.instance;

  Future<List<CategoryModel>> getCategories() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await _firestore.collection("categories").get();

      List<CategoryModel> categoriesList = querySnapshot.docs
          .map((e) => CategoryModel.fromJson(e.data()))
          .toList();

      return categoriesList;
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      return [];
    }
  }

  Future<List<ProductModel>> getPopular() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await _firestore.collectionGroup("items").get();

      List<ProductModel> categoriesList = querySnapshot.docs
          .map((e) => ProductModel.fromJson(e.data()))
          .toList();
print(categoriesList);
      return categoriesList;
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      return [];
    }
  }
  Future<List<ProductModel>> getProductsByCategories(String id) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await _firestore.collection("categories").doc(id).collection("items").get();

      List<ProductModel> categoriesList = querySnapshot.docs
          .map((e) => ProductModel.fromJson(e.data()))
          .toList();

      return categoriesList;
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      return [];
    }
  }

  Future<UserModel> getUser() async {
    DocumentSnapshot<Map<String, dynamic>> querySnapshot =
    await _firestore
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    return UserModel.fromJson(querySnapshot.data()!);
  }
}