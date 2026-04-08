import 'package:flutter/material.dart';
import 'package:e_commerce/core/constant/color.dart';

class CustomButtonLang extends StatelessWidget {
  final String text;

  final void Function() onPressed;

  const CustomButtonLang({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: AppColor.hotRed),
          onPressed: onPressed,
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 22),
          )),
    );
  }
}
