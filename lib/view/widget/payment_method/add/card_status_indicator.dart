import 'package:e_commerce/core/constant/color.dart';
import 'package:flutter/material.dart';

class CardStatusIndicator extends StatelessWidget {
  const CardStatusIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColor.hotRed.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColor.hotRed.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.info_outline_rounded, color: AppColor.hotRed, size: 16),
          const SizedBox(width: 8),
          Text(
            'البطاقة المعروضة تحدث فورياً',
            style: TextStyle(
              color: AppColor.hotRed,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
