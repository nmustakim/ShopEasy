import 'package:flutter/material.dart';

import '../models/categories.dart';




List <Categories> categoriesList = [
  Categories(name:"Fruits",image:"images/fruits.png" )
];

class Category extends StatefulWidget {
  const Category({Key? key}) : super(key: key);

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
