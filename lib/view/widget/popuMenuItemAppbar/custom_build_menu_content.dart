import 'package:e_commerce/controller/cart_controller.dart';
import 'package:e_commerce/controller/favorite_view_controller.dart';
import 'package:e_commerce/controller/logout_controller.dart';
import 'package:e_commerce/controller/notification_controller.dart';
import 'package:e_commerce/core/constant/routesname.dart';
import 'package:e_commerce/view/widget/custom_exit_dialog.dart';
import 'package:e_commerce/view/widget/popuMenuItemAppbar/custom_build_menu_item.dart';
import 'package:e_commerce/view/widget/popuMenuItemAppbar/custom_build_section_title.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CustomBuildMenuContent extends StatelessWidget {
  const CustomBuildMenuContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                CustomBuildSectionTitle(title: "General"),
                CustomBuildMenuItem(
                  onTap: () {
                    Get.toNamed(AppRoutes.homepage);
                  },
                  icon: Icons.home_outlined,
                  text: "Home",
                  badgeCount: 0,
                ),
                GetBuilder<FavoriteViewControllerImp>(
                  builder: (controller) {
                    return CustomBuildMenuItem(
                      onTap: () {
                        Get.offAllNamed(AppRoutes.myFavorite);
                      },
                      icon: Icons.favorite_border_outlined,
                      text: "Favorite",
                      badgeCount: controller.data.length,
                    );
                  },
                ),
                GetBuilder<CartControllerImp>(
                  builder: (controller) {
                    return CustomBuildMenuItem(
                      onTap: () {
                        Get.offAllNamed(AppRoutes.cart);
                      },
                      icon: Icons.shopping_cart_outlined,
                      text: "Cart",
                      badgeCount: controller.data.length,
                    );
                  },
                ),
                CustomBuildMenuItem(
                  onTap: () {
                    Get.toNamed(AppRoutes.profile);
                  },
                  icon: Iconsax.profile_circle5,
                  text: "Profile",
                  badgeCount: 0,
                ),
                CustomBuildMenuItem(
                  onTap: () {
                    Get.toNamed(AppRoutes.settings);
                  },
                  icon: Icons.settings,
                  text: "Settings",
                  badgeCount: 0,
                ),
                const SizedBox(height: 5.0),
                CustomBuildSectionTitle(title: "Preferences"),
                GetBuilder<NotificationControllerImp>(
                  builder: (controller) {
                    return CustomBuildMenuItem(
                      onTap: () {
                          Get.toNamed(AppRoutes.notification);
                      },
                      icon: Icons.notifications_none_outlined,
                      text: "Notifications",
                      badgeCount: controller.unreadCount,
                    );
                  },
                ),
                CustomBuildMenuItem(
                  onTap: () {
                    //  Get.offAllNamed(AppRoutes.myFavorite);
                  },
                  icon: Icons.security_outlined,
                  text: "Privacy & Security",
                  badgeCount: 0,
                ),
                CustomBuildMenuItem(
                  onTap: () {
                    //  Get.offAllNamed(AppRoutes.myFavorite);
                  },
                  icon: Icons.language_outlined,
                  text: "Language",
                  badgeCount: 0,
                ),
                CustomBuildMenuItem(
                  onTap: () {
                    //  Get.offAllNamed(AppRoutes.myFavorite);
                  },
                  icon: Icons.support_agent,
                  text: "Connect Us",
                  badgeCount: 0,
                ),
                const SizedBox(height: 20.0),
                const Divider(height: 1, color: Colors.grey),
                const SizedBox(height: 20.0),
                CustomBuildMenuItem(
                  onTap: () {
                    Get.dialog(
                      CustomExitDialog(
                        onPressed: () {
                          Get.back();
                        },
                        onPressedCon: () {
                          Get.back();
                          LogoutControllerImp logoutController = Get.put(
                            LogoutControllerImp(),
                          );
                          logoutController.logout();
                        },
                      ),
                    );
                  },
                  icon: Iconsax.logout_15,
                  text: "Logout",
                  badgeCount: 0,
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
