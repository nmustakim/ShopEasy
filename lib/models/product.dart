import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel(
      {required this.image,
      required this.id,
      required this.name,
      required this.price,
      required this.description,
      required this.isFav,
      this.quantity});

  String image;
  String id;
  bool isFav;
  String name;
  double price;
  String description;
  int? quantity;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
      id: json["id"],
      image: json["image"],
      price: double.parse(json["price"].toString()),
      name: json["name"],
      description: json['description'],
      isFav: false,
      quantity: json["quantity"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "description": description,
        "isFav": isFav,
        "price": price,
        "quantity": quantity,
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
