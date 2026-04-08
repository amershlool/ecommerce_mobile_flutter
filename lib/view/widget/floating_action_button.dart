import 'package:e_commerce/core/constant/color.dart';
import 'package:e_commerce/core/constant/routesname.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: AppColor.hotRed,
      shape: CircleBorder(),
      onPressed: () {
        Get.toNamed(AppRoutes.orders);
      },
      child: Icon(Icons.shopping_bag_outlined, color: Colors.white),
    );
  }
}
