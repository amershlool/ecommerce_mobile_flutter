import 'package:e_commerce/core/constant/color.dart';
import 'package:flutter/material.dart';

class CustomRowButton extends StatelessWidget {
  final void Function()? onPressed;

  final void Function()? onPressedRe;

  final String orderStatus;

  const CustomRowButton({
    super.key,
    required this.onPressed,
    required this.onPressedRe,
    required this.orderStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: 40,
          child: OutlinedButton.icon(
            onPressed: onPressedRe,
            icon: Icon(
              orderStatus == "-1"
                  ? Icons.highlight_remove_rounded
                  : orderStatus == "3"
                  ? Icons.highlight_remove_rounded
                  : Icons.refresh,
              size: 18,
              color: AppColor.hotRed,
            ),
            label: Text(
              orderStatus == "-1"
                  ? 'حذف الطلب'
                  : orderStatus == "3"
                  ? 'حذف الطلب'
                  : 'إعادة الطلب',
              style: TextStyle(fontSize: 14, color: AppColor.hotRed),
            ),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColor.hotRed),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
            ),
          ),
        ),
        SizedBox(
          height: 40,
          child: ElevatedButton.icon(
            onPressed: onPressed,
            icon: const Icon(Icons.remove_red_eye_outlined, size: 18),
            label: const Text('تفاصيل الطلب', style: TextStyle(fontSize: 14)),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.hotRed,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              elevation: 4,
            ),
          ),
        ),
      ],
    );
  }
}
