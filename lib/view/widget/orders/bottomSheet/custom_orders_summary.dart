import 'package:e_commerce/core/constant/color.dart';
import 'package:flutter/material.dart';

class CustomOrdersSummary extends StatelessWidget {
  final String label;
  final String price;
  final String unit;
  final bool isGrandTotal;

  const CustomOrdersSummary({
    super.key,
    required this.label,
    required this.price,
    this.unit = "JD",
    required this.isGrandTotal,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 20),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: AppColor.darkGray,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Text(
            '$price $unit',
            style: TextStyle(
              fontSize: 14,
              color: isGrandTotal ? Colors.green : AppColor.darkGray,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
