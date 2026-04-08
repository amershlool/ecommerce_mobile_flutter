import 'package:flutter/material.dart';

class CustomPriceOld extends StatelessWidget {
  final String price;
  const CustomPriceOld({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    return Text(
      "\$$price",
      style: TextStyle(
        fontSize: 22,
        color: Colors.grey,
        decoration: TextDecoration.lineThrough,
        fontWeight: FontWeight.w500,
      ),
    );

  }
}
