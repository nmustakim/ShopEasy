import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  IconData icon;
  String text;
var onTap;




  ProfileCard({super.key, required this.icon, required this.text,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,

      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: InkWell(
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(icon,color: Colors.red,),
              Text(text),
              const Icon(Icons.arrow_forward_ios_rounded,color: Colors.red,),


            ],
          ),
        ),
      ),
    );
  }
}
