import 'package:e_commerce/core/constant/color.dart';
import 'package:e_commerce/core/constant/routesname.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

PreferredSizeWidget customAppBar(
    String titleAppBar, {
      bool goToHomeIfTrue = false,
    }) {
  return AppBar(
    backgroundColor: Colors.transparent,
    title: Text(
      titleAppBar,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontFamily: 'Amiri',
        fontSize: 25,
      ),
    ),
    centerTitle: true,
    elevation: 0,
    flexibleSpace: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColor.hotRed, AppColor.hotRed2],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    ),
    leading: IconButton(
      icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
      onPressed: () {
        if (goToHomeIfTrue) {
          Get.offAllNamed(AppRoutes.homepage);
        } else {
          Get.back();
        }
      },
    ),
  );
}
