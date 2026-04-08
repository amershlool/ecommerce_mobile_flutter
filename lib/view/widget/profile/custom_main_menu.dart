import 'package:e_commerce/controller/logout_controller.dart';
import 'package:e_commerce/core/constant/routesname.dart';
import 'package:e_commerce/view/widget/custom_exit_dialog.dart';
import 'package:e_commerce/view/widget/profile/custom_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomMainMenu extends StatelessWidget {
  const CustomMainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          CustomMenuItem(
            icon: Icons.notifications_rounded,
            title: 'Orders',
            subTitle: 'View previous order history',
            color: Color(0xFFCC0000),
            onTap: () {
              Get.toNamed(AppRoutes.orders);
            },
          ),
          CustomBuildDivider(),
          CustomMenuItem(
            icon: Icons.notifications_rounded,
            title: 'Favorites',
            subTitle: 'Your favorite products',
            color: Color(0xFFFF6B6B),
            onTap: () {
              Get.toNamed(AppRoutes.myFavorite);
            },
          ),
          CustomBuildDivider(),

          CustomMenuItem(
            onTap: () {
              Get.toNamed(AppRoutes.addressView);
            },

            icon: Icons.notifications_rounded,
            title: 'Address',
            subTitle: 'Managing delivery addresses',
            color: Color(0xFFFF4444),
          ),
          CustomBuildDivider(),

          CustomMenuItem(
            onTap: () {
              print("Payment methods");
            },

            icon: Icons.notifications_rounded,
            title: 'Payment methods',
            subTitle: 'Payment Method Management',
            color: Color(0xFFFFD166),
          ),
          CustomBuildDivider(),

          CustomMenuItem(
            onTap: () {
              Get.toNamed(AppRoutes.notification);
            },

            icon: Icons.notifications_rounded,
            title: 'Notifications',
            subTitle: 'Manage notifications',
            color: Color(0xFFFF6B6B),
          ),
          CustomBuildDivider(),

          CustomMenuItem(
            onTap: () {
              print("Help");
            },

            icon: Icons.notifications_rounded,
            title: 'Help',
            subTitle: 'Frequently Asked Questions and Support',
            color: Color(0xFFCC0000),
          ),
          CustomBuildDivider(),

          CustomMenuItem(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return CustomExitDialog(
                    onPressed: () {
                      Get.back();
                    },
                    onPressedCon: () {
                      LogoutControllerImp controller = Get.find();
                      controller.logout();
                    },
                  );
                },
              );
            },

            icon: Icons.notifications_rounded,
            title: 'Log Out',
            subTitle: 'Log out of your account',
            color: Color(0xFFFF4444),
          ),
        ],
      ),
    );
  }
}

class CustomBuildDivider extends StatelessWidget {
  const CustomBuildDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Divider(height: 1, color: Colors.white.withAlpha(30)),
    );
  }
}
