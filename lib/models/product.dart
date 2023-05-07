import 'dart:convert';

ProductModel ProductModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

String ProductModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel( {
    required this.image,
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.isFav,
    this.quantity


  });

  String image;
  String name;
 dynamic price;
  String id;
  String description;
  bool isFav;
  int? quantity;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json["id"],
    image: json["image"],
    price: json["price"],
    name: json["name"], description: json['description'],
    isFav: false,
    quantity: json["quantity"]

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "name": name,
    "price": price,
    "description":description,
    "isFav":isFav,
    "quantity":quantity,
  };
  ProductModel copyWith({
    int? quantity,
  }) =>
      ProductModel(
        id: id,
        name: name,
        description: description,
        image: image,
        isFav: isFav,
        quantity: quantity ?? this.quantity,
        price: price,
      );


}