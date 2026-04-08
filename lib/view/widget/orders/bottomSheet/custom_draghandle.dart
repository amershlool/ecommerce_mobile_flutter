import 'package:e_commerce/core/constant/color.dart';
import 'package:flutter/material.dart';

class CustomDragHandle extends StatelessWidget {
  const CustomDragHandle({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 60,
        height: 4,
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: AppColor.hotRed.withAlpha(200),
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}
