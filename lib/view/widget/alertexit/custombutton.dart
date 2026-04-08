import 'package:flutter/material.dart';

class CustomButtonExit extends StatelessWidget {
  final Color backgroundColor;

  final void Function()? onPressed;

  final String childText;
  final Color colorBorder;

  const CustomButtonExit(
      {super.key,
      required this.onPressed,
      required this.childText,
      required this.backgroundColor, required this.colorBorder});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 128,
      padding: const EdgeInsets.all(10),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            elevation: 15,
            side: BorderSide(
              color: colorBorder,
              width: 1,
            ),
            backgroundColor: backgroundColor,
            foregroundColor: Colors.black54),
        child: Text(
          childText,
          style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              fontFamily: "BalooBhaijaan"),
        ),
      ),
    );
  }
}
