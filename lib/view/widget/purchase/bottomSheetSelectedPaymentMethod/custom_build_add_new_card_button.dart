import 'package:e_commerce/core/constant/color.dart';
import 'package:e_commerce/core/constant/routesname.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBuildAddNewCardButton extends StatelessWidget {
  const CustomBuildAddNewCardButton({super.key});

  @override
  Widget build(BuildContext context) {
    return       Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: GestureDetector(
        onTap: () {
          Get.toNamed(AppRoutes.addPaymentMethods);
        },
        child: Container(
          height: 56,
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade200, width: 1.5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add_circle_outline_rounded,
                color: AppColor.hotRed,
                size: 22,
              ),
              const SizedBox(width: 12),
              Text(
                "Add New Payment Method",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColor.hotRed,
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }
}
