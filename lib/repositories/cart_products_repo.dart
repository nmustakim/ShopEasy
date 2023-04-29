// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import '../models/cart_product.dart';
// class CartProductRepository {
//   final _fdb = FirebaseFirestore.instance;
//   final _auth = FirebaseAuth.instance;
//
//   Future <List<CartProduct>> getCartItems() async {
//     final snapshot = await _fdb.collection("users-cart").doc(
//         FirebaseAuth.instance.currentUser!.email).collection("items").get();
//     final cart = snapshot.docs.map((e) => CartProduct.fromSnapshot(e)).toList();
//     return cart;
//   }
//
//
//
// }