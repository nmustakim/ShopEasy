import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String? id;
 final String name;
 final String image;
 final dynamic price;

 Product({this.id,required this.name, required this.image, required this.price});
 toJson(){

  return {"name":name, "image":image,"price":price};
 }

factory Product.fromSnapshot(DocumentSnapshot<Map<String, dynamic>>documentSnapshot){
  final data = documentSnapshot.data();
  return Product(
      id: documentSnapshot.id,
      name: data!["name"],
      image: data["image"],
      price: data["price"]

  );
}
}
