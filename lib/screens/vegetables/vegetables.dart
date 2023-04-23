import 'package:flutter/material.dart';

import '../../global_widgets/category_items_body.dart';

class Vegetables extends StatelessWidget {
  const Vegetables({super.key});

  @override
  Widget build(BuildContext context) {
    return const CategoryItemsBody(title: "VEGETABLES", collection: "items");
  }
}