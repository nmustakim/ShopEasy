import 'package:flutter/material.dart';

class ReusableBodyPart extends StatelessWidget {

  final Widget childWidget;
  final double topMargin;

  const ReusableBodyPart({super.key,  required this.topMargin,required this.childWidget,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body:Stack(
    children: [
     SizedBox(width:double.infinity,child: Image.asset("assets/images/groceries.jpg",fit: BoxFit.fill)),
    Center(
      child: Container(

      decoration: const BoxDecoration(
    color: Colors.white,

      borderRadius: BorderRadius.only(topLeft:Radius.circular(30),topRight: Radius.circular(30))
      ),

      margin: EdgeInsets.only(top:topMargin),
      child: SingleChildScrollView(

      child: childWidget
      )),
    )

   ] )
    );
  }
}
