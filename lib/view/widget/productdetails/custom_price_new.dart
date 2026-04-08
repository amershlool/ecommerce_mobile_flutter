import 'package:e_commerce/core/constant/color.dart';
import 'package:flutter/material.dart';

class CustomPriceNew extends StatelessWidget {
  final String price;

  const CustomPriceNew({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    return  Text(
      "\$$price",
      style: TextStyle(
        fontSize: 28,
        color: AppColor.hotRed2,
        fontFamily: 'PlayfairDisplay',
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
