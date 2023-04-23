import 'package:flutter/material.dart';

import '../constants.dart';

class CategoryItemCard extends StatelessWidget {
  final String image, name;
  const CategoryItemCard({super.key, required this.image, required this.name});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Image.network(
                image,
                fit: BoxFit.cover,
              ),
            ),
      
            Text(
              name,
              style: bodyTextStyle1,
            ),
          ],
        ),
      ),
    );
  }
}
