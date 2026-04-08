import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_commerce/core/constant/color.dart';

class CustomSnackbar {
  final String title;

  final String subTitle;
  final IconData iconData;


  CustomSnackbar( {required this.title, required this.subTitle,required this.iconData,});

  static void showCartEmpty(String title, String subTitle,IconData iconData) {
    Get.snackbar(
      "",
      "",
      titleText:  Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: Colors.white,
        ),
      ),
      messageText:  Text(
        subTitle,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 15,
          color: Colors.white,
        ),
      ),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColor.hotRed2.withOpacity(0.95),
      colorText: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.all(16),
      borderRadius: 16,
      maxWidth: 500,
      overlayBlur: 1.5,
      boxShadows: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 10,
          offset: const Offset(0, 4),
        )
      ],
      icon:  Icon(iconData, color: Colors.white, size: 28),
      shouldIconPulse: true,
      duration: const Duration(seconds: 3),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
      reverseAnimationCurve: Curves.easeIn,
    );
;
  }
}
