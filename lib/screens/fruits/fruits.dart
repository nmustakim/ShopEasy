import 'package:flutter/material.dart';

import '../../reusable_parts/category_items_body.dart';

class Fruits extends StatelessWidget {
  const Fruits({super.key});
  @override
  Widget build(BuildContext context) {
    return const CategoryItemsBody(title: "FRUITS", collection: "fruits");
  }
}