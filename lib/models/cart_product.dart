// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class CartProduct {
// final int quantity;
//   final String name;
//   final String image;
//   final dynamic price;
//
//   CartProduct({required this.quantity,required this.name, required this.image, required this.price});
//   toJson(){
//
//     return {"name":name, "image":image,"price":price};
//   }
//
//   factory CartProduct.fromSnapshot(DocumentSnapshot<Map<String, dynamic>>documentSnapshot){
//     final data = documentSnapshot.data();
//     return CartProduct(
//         quantity: data!["quantity"],
//         name: data["name"],
//         image: data["image"],
//         price: data["price"]
//
//     );
//   }
// }
