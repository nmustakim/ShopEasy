import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/product.dart';

class ShopProvider with ChangeNotifier{
  final List<ProductModel> _cartProducts = [];
  

  void addProduct(ProductModel pm) {
    final itemIsExist  = _cartProducts.where((e)=> e.id == pm.id);
    if(itemIsExist.isEmpty) {
      _cartProducts.add(pm);
      notifyListeners();
      Fluttertoast.showToast(msg: "Item added");
    }
    else{
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


}