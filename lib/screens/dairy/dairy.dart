import 'package:flutter/material.dart';
import '../../reusable_parts/category_items_body.dart';


class Dairy extends StatelessWidget {
  const Dairy({super.key});

  @override
  Widget build(BuildContext context) {
    return const CategoryItemsBody(title: "DAIRIES", collection: "dairy");
  }
}