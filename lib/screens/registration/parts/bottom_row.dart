import 'package:flutter/material.dart';

class BottomRow extends StatelessWidget {
Widget navigatingScreen;
String bottomText;
String buttonName;

BottomRow({super.key, required this.navigatingScreen, required this.bottomText, required this.buttonName});

  @override
  Widget build(BuildContext context) {
    return             Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    Text(bottomText,
    style:
    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
    InkWell(
    onTap: () {
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => navigatingScreen));
    },
    child: Container(
      margin: const EdgeInsets.only(left: 10),
    padding: const EdgeInsets.all(5),
    height: 28,
    decoration: const BoxDecoration(
color: Colors.redAccent,
borderRadius: BorderRadius.all(Radius.circular(15))),
    child: Center(
    child: Text(
    // ignore: unnecessary_string_interpolations
    "$buttonName",
    style:
    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
    )),
),
),
],
);
  }
}
