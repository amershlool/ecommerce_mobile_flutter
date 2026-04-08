import 'package:e_commerce/core/constant/color.dart';
import 'package:flutter/material.dart';

class CustomTextTitle extends StatelessWidget {
final  String title ;
  const CustomTextTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 34,
        color: AppColor.darkGray,
        fontFamily: 'PlayfairDisplay',
        fontWeight: FontWeight.bold,
        shadows: [
          Shadow(
            offset: Offset(1, 1),
            blurRadius: 3,
            color: Colors.black.withAlpha(77),
          ),
        ],
      ),
    );
  }
}
