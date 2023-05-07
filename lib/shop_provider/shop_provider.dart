import 'package:flutter/cupertino.dart';

import '../models/product.dart';

class ShopProvider with ChangeNotifier{
  final List<ProductModel> _cartProducts = [];
  

  void addProduct(ProductModel pm) {
    _cartProducts.add(pm);
    notifyListeners();
  }

  void removeProduct(ProductModel pm) {
    _cartProducts.remove(pm);
    notifyListeners();
  }

  List<ProductModel> get getCartProductList => _cartProducts;
}