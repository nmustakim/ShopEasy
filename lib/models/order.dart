
import 'package:shopeasy/models/product.dart';



class OrderModel {
  OrderModel({
    required this.totalPrice,
    required this.orderId,
    required this.payment,
    required this.products,
    required this.status,
  });


  double totalPrice;
  String orderId;
  String payment;
  String status;
  List <ProductModel> products;



  factory OrderModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> productMap = json["products"];
    return OrderModel(
      orderId: json["orderId"],
      status: json["status"],
      payment: json["payment"],
      totalPrice: json["totalPrice"],
      products: productMap.map((e) => ProductModel.fromJson(e)).toList(),
    );
  }



}

