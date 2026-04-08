import 'package:e_commerce/controller/cart_controller.dart';
import 'package:e_commerce/core/constant/routesname.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

PreferredSizeWidget customAppBarFeaturedProducts(
  String title,
  void Function()? onPressedIconShopping,
  void Function()? onPressedIconHeart,
) {
  return AppBar(
    title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
    centerTitle: true,
    actions: [
      GetBuilder<CartControllerImp>(
        builder: (controller) {
          return badges.Badge(
            position: badges.BadgePosition.topEnd(top: -2, end: -2),
            badgeContent: Text(
              controller.totalCountItems.toString(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
            badgeAnimation: badges.BadgeAnimation.scale(toAnimate: true),

            showBadge: controller.totalCountItems > 0,
            child: IconButton(
              onPressed: () {
                Get.toNamed(AppRoutes.cart);
              },
              icon: Icon(Icons.shopping_cart_outlined),
            ),
          );
        },
      ),
      IconButton(
        onPressed: () {
          Get.toNamed(AppRoutes.myFavorite);
        },
        icon: Icon(Iconsax.heart),
      ),
    ],
  );
}
