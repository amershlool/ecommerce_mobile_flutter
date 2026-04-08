import 'package:flutter/material.dart';

class CustomTextForgot extends StatelessWidget {
  final String test;
final double fontSize;
  const CustomTextForgot({super.key, required this.test, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Text(
      test,
      style:  TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: fontSize,
          color: Colors.black54,
          fontFamily: "BalooBhaijaan"
      ),
    );
  }
}
