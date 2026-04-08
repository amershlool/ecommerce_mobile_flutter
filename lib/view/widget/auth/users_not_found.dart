import 'package:flutter/material.dart';
import 'package:get/get.dart';
void showSnackbarErrorLogin(String title, String message) {
  Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.red[700],
    colorText: Colors.white,
    duration: const Duration(seconds: 4),
    icon: const Icon(
      Icons.cancel_rounded,
      color: Colors.white,
      size: 30,
    ),
    shouldIconPulse: true,
    barBlur: 10,
    isDismissible: true,
    dismissDirection: DismissDirection.horizontal,
    forwardAnimationCurve: Curves.easeOutBack,
    reverseAnimationCurve: Curves.easeInBack,
    margin: const EdgeInsets.all(16),
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    borderRadius: 15,
    boxShadows: [
      BoxShadow(
        color: Colors.black.withOpacity(0.3),
        spreadRadius: 3,
        blurRadius: 10,
        offset: const Offset(0, 5),
      ),
    ],
  );
}

