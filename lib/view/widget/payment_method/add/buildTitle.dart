import 'package:e_commerce/core/constant/color.dart';
import 'package:flutter/material.dart';

class BuildTitle extends StatelessWidget {
  final String title ;
  const BuildTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColor.hotRed.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.credit_card_rounded,
            color: AppColor.hotRed,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColor.hotRed,
          ),
        ),

      ],
    );
  }
}
