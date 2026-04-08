import 'package:flutter/material.dart';

class CustomButtonAuth extends StatelessWidget {
  final void Function()? onPressed;

  final String childText;

  const CustomButtonAuth(
      {super.key, required this.onPressed, required this.childText});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            elevation: 15,
            side: const BorderSide(
              color: Colors.black38,
              width: 1,
            ),
            backgroundColor: Colors.white70,
            foregroundColor: Colors.black54),
        child: Text(
          childText,
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w700,fontFamily: "BalooBhaijaan"),
        ),
      ),
    );
  }
}
