import 'package:e_commerce/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void customShowTopSnackBar(String title, String subTitle,String titleButton,IconData icon,Function() onPressed) {
  Get.snackbar(
    "",
    "",
    titleText: Text(
      title,
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 16,
        fontFamily: 'PlayfairDisplay',
      ),
    ),
    messageText: Text(
      subTitle,
      textAlign: TextAlign.center,
      style: const TextStyle(color: Colors.white, fontSize: 12),
    ),
    icon:  Icon(icon, color: Colors.white),
    snackPosition: SnackPosition.TOP,
    backgroundColor: AppColor.hotRed.withAlpha(204),
    borderRadius: 15.0,
    margin: const EdgeInsets.all(15),
    duration: const Duration(seconds: 3),
    isDismissible: true,
    dismissDirection: DismissDirection.horizontal,
    forwardAnimationCurve: Curves.easeOutBack,
    reverseAnimationCurve: Curves.easeInBack,
    animationDuration: const Duration(milliseconds: 600),
    boxShadows: [
      BoxShadow(
        color: Colors.black.withAlpha(150),
        spreadRadius: 3,
        blurRadius: 10,
        offset: const Offset(0, 5),
      ),
    ],
    mainButton: TextButton(
      onPressed: onPressed,
      child:  Text(
        titleButton,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    ),
  );
}
