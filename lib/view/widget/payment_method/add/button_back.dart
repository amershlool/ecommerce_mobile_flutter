import 'package:e_commerce/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ButtonBack extends StatelessWidget {
  const ButtonBack({super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        Get.back();
      },
      style: OutlinedButton.styleFrom(
          side: BorderSide(color: AppColor.hotRed, width: 1.5),
          padding: EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16)
          )
      ),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.arrow_back_ios_new_outlined,
              color: AppColor.hotRed,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              'Back',
              style: TextStyle(
                color: AppColor.hotRed,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'PlayfairDisplay'
              ),
            ),

          ]),
    );
  }
}
