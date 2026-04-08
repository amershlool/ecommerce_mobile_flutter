import 'package:flutter/material.dart';

class TextTap extends StatelessWidget {
  final String text;

  final Function() onTap;
  final Color color;
final String? fontFamily;
  final double fontSize;
  final FontWeight? fontWeight;

  const TextTap(
      {super.key,
      required this.text,
      required this.onTap,
      required this.color,
      required this.fontSize,
      this.fontWeight,  this.fontFamily});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Text(
          text,
          style: TextStyle(
            color: color,
            fontSize: fontSize,
            fontWeight: fontWeight,
          fontFamily: fontFamily,
          ),
        ));
  }
}
