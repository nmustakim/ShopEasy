import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/product.dart';

class ProductRepository  {
  final _fdb = FirebaseFirestore.instance;
  Future <List<Product>> getAllItems()async{
    final snapshot = await _fdb.collection("categories").get();
    final categories = snapshot.docs.map((e) => Product.fromSnapshot(e)).toList();
    return categories;

  }
  Future <List<Product>> getAllFruits()async{
    final snapshot = await _fdb.collection("fruits").get();
    final fruits = snapshot.docs.map((e) => Product.fromSnapshot(e)).toList();
    return fruits;

  }

  Future <List<Product>> getAllDairy()async{
    final snapshot = await _fdb.collection("dairy").get();
    final dairy = snapshot.docs.map((e) => Product.fromSnapshot(e)).toList();
    return dairy;

  }
  Future <List<Product>> getAllMeats()async{
    final snapshot = await _fdb.collection("meat").get();
    final meats = snapshot.docs.map((e) => Product.fromSnapshot(e)).toList();
    return meats;

  }
  Future <List<Product>> getAllVegs()async{
    final snapshot = await _fdb.collection("items").get();
    final vegs = snapshot.docs.map((e) => Product.fromSnapshot(e)).toList();
    return vegs;

  }
  Future <List<Product>> getAllPopular()async{
    final snapshot = await _fdb.collection("popular").get();
    final popular = snapshot.docs.map((e) => Product.fromSnapshot(e)).toList();
    return popular;

  }
}