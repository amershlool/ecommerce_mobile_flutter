import 'package:flutter/material.dart';
class CustomButtonForgot extends StatelessWidget {
  final String text ;
  final void Function() onPressed;

  const CustomButtonForgot({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed:onPressed,
      style: ElevatedButton.styleFrom(
          elevation: 15,
          side: const BorderSide(
            color: Colors.white12,
            width: 1,
          ),
          backgroundColor:const Color(0xFFFF9999).withOpacity(0.2)
          ,
          foregroundColor: Colors.black54),
      child: Text(text ,
        style:const TextStyle(
            fontSize: 25, fontWeight: FontWeight.bold,color: Colors.white60),
      ),
    );
  }
}
