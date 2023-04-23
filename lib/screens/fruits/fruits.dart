import 'package:flutter/material.dart';

import '../../global_widgets/category_items_body.dart';


class Fruits extends StatelessWidget {
  const Fruits({super.key});
  @override
  Widget build(BuildContext context) {
    return const CategoryItemsBody(title: "FRUITS", collection: "fruits");
  }
}