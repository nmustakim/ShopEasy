import 'package:flutter/material.dart';
import 'package:shopeasy/constants.dart';

class BottomButton extends StatelessWidget {
  String buttonName;
var onPressed;

 BottomButton({super.key, required this.buttonName,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: ElevatedButton(onPressed:onPressed,
      style: ElevatedButton.styleFrom(shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)) ), child: Text(buttonName,style: titleTextStyle4.copyWith(fontSize: 16),),),
    );
  }
}
