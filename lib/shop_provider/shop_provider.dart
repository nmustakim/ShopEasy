import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopeasy/firebase_helpers/firebase_storage_helper.dart';
import 'package:shopeasy/firebase_helpers/firestore_helper.dart';

import '../constants.dart';
import '../models/product.dart';
import '../models/user.dart';

class ShopProvider with ChangeNotifier {
  final List<ProductModel> _cartProducts = [];
  final List<ProductModel> _favoriteProducts = [];
  final List<ProductModel> _orderedProducts = [];

  void addProduct(ProductModel pm) {
    final itemIsExist = _cartProducts.where((e) => e.id == pm.id);
    if (itemIsExist.isEmpty) {
      _cartProducts.add(pm);
      notifyListeners();
      Fluttertoast.showToast(msg: "Item added");
    } else {
      Fluttertoast.showToast(msg: "Already added");
    }
  }

  void removeProduct(ProductModel pm) {
    _cartProducts.remove(pm);
    notifyListeners();
  }

  List<ProductModel> get getCartProductList => _cartProducts;
  void updateQty(ProductModel productModel, int qty) {
    int index = _cartProducts.indexOf(productModel);
    _cartProducts[index].quantity = qty;
    notifyListeners();
  }

  void updateQuantity(ProductModel productModel, int qty) {
    int index = _cartProducts.indexOf(productModel);
    _cartProducts[index].quantity = qty;
    notifyListeners();
  }



  void addToFavorite(ProductModel pm) {
    _favoriteProducts.add(pm);
    notifyListeners();
  }

  void removeFavorite(ProductModel pm) {
    _favoriteProducts.remove(pm);
    notifyListeners();
  }

  List<ProductModel> get getFavoriteProductList => _favoriteProducts;
  UserModel? _userModel;
  UserModel get getUserInformation => _userModel!;
  void getUserInfoFirebase() async {
    _userModel = await FireStoreHelper.fireStoreHelper.getUser();
    notifyListeners();
  }

  void updateUserInfoFirebase(
      BuildContext context, UserModel userModel, File? file) async {
    if (file == null) {
      showLoaderDialog(context);

      _userModel = userModel;
      await FirebaseFirestore.instance
          .collection("users")
          .doc(_userModel!.id)
          .set(_userModel!.toJson());
      Navigator.of(context, rootNavigator: true).pop();
      Navigator.of(context).pop();
    } else {
      showLoaderDialog(context);

      String imageUrl =
          await FirebaseStorageHelper.instance.uploadUserImage(file);
      _userModel = userModel.copyWith(image: imageUrl);
      await FirebaseFirestore.instance
          .collection("users")
          .doc(_userModel!.id)
          .set(_userModel!.toJson());
      Navigator.of(context, rootNavigator: true).pop();
      Navigator.of(context).pop();
    }
    Fluttertoast.showToast(msg: "Updated!");

    notifyListeners();
  }

  double cartProductsTotalPrice() {
    double totalPrice = 0.0;
    for (var element in _cartProducts) {
      totalPrice += element.price * element.quantity!;
    }
    return totalPrice;
  }
  List <ProductModel> get getOrderedProducts => _orderedProducts;
  void orderProduct(ProductModel pm){
    _orderedProducts.add(pm);
    notifyListeners();

  }

}
