import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.image,
    required this.id,
    required this.name,
    required this.age,
    required this.phone,
    required this.email,
  });

  String? image;
  String name;
  String email;
  String id;
  String age;
  String phone;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    image: json["image"],
    email: json["email"],
    name: json["name"],
    phone: json["phone"],
    age: json["age"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "name": name,
    "email": email,
    "phone": phone,
    "age" : age
  };


}