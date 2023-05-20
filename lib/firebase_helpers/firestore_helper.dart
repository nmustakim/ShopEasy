import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopeasy/constants.dart';
import 'package:shopeasy/models/order.dart';

import '../models/categories.dart';
import '../models/product.dart';
import '../models/user.dart';

class FireStoreHelper{

  static FireStoreHelper fireStoreHelper = FireStoreHelper();
  final _firestore = FirebaseFirestore.instance;
  final uid = FirebaseAuth.instance.currentUser!.uid;

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
  Future <bool> orderToFirebase(List<ProductModel> list,BuildContext context,String payment)async{
    try{
showLoaderDialog(context);
        double totalPrice = 0.0;
        for (var element in list) {
          totalPrice += element.price * element.quantity!;
        }

DocumentReference documentReference = _firestore
    .collection("usersOrders")
    .doc(uid)
    .collection("orders")
    .doc();
DocumentReference admin = _firestore.collection("orders").doc();

admin.set({
  "products": list.map((e) => e.toJson()),
  "status": "Pending",
  "totalPrice": totalPrice,
  "payment": payment,
  "orderId": admin.id,
});

 await documentReference.set({
   "products": list.map((e) => e.toJson()).toList(),
  "status": "Pending",
  "totalPrice": totalPrice,
  "payment": payment,
  "orderId": documentReference.id,
});
     Navigator.of(context,rootNavigator: true).pop();
     Fluttertoast.showToast(msg: "Order placed");
      return true;
    }
    catch(e){
      Fluttertoast.showToast(msg: e.toString());

      Navigator.of(context,rootNavigator: true).pop();
      return false;

    }

  }
  Future <List<OrderModel>> getOrderFromFirebase()async{

   try {
     QuerySnapshot<Map<String, dynamic>> querySnapshot =
     await  _firestore.collection("usersOrders").doc(uid).collection("orders").get();

     List<OrderModel> ordersList = querySnapshot.docs
         .map((e) => OrderModel.fromJson(e.data()))
         .toList();

     return ordersList ;
   } catch (e) {
     Fluttertoast.showToast(msg: e.toString());
     return [];
   }
  }
}