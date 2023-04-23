import 'package:flutter/material.dart';

import '../../global_widgets/category_items_body.dart';


class Meat extends StatelessWidget {
  const Meat({super.key});

  @override
  Widget build(BuildContext context) {
    return const CategoryItemsBody(title: "MEATS", collection: "meat");
  }
}