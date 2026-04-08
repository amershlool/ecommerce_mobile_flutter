import 'package:e_commerce/controller/logout_controller.dart';
import 'package:e_commerce/core/constant/color.dart';
import 'package:e_commerce/core/serveces/services.dart';
import 'package:e_commerce/view/widget/popuMenuItemAppbar/custom_build_header.dart';
import 'package:e_commerce/view/widget/popuMenuItemAppbar/custom_build_menu_content.dart';
import 'package:e_commerce/view/widget/popuMenuItemAppbar/custom_user_stats_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CustomSideMenu extends StatefulWidget {
final bool secondColors;
   const CustomSideMenu({
    super.key,
     this.secondColors = false,

  });

  @override
  State<CustomSideMenu> createState() => _CustomSideMenuState();
}

class _CustomSideMenuState extends State<CustomSideMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width * 0.82;
    final MyServices myServices = Get.find();

    return Drawer(
      width: width,
      elevation: 24.0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topRight: Radius.circular(30.0)),
      ),
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Container(
            color: AppColor.hotRed.withAlpha(5),
            child: Column(
              children: [
                // Header
                CustomBuildHeader(myServices: myServices),
                //StatsBar
                CustomUserStatsBar(),
                // menu Option
                CustomBuildMenuContent(),

                // Footer
                _buildAdvancedFooter(),
              ],
            ),
          );
        },
      ),
    );
  }




  Widget _buildAdvancedFooter() {
    return Container(
      padding: const EdgeInsets.all(25.0),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey.shade300, width: 1.0),
        ),
      ),
      child: Column(
        children: [
          // معلومات التطبيق
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "E-Commerce Pro",
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo',
                    ),
                  ),
                  Text(
                    "Version 2.1.0",
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 10.0,
                    ),
                  ),
                ],
              ),

              // النجوم
              Row(
                children: [
                  Icon(Icons.star, color: Colors.amber, size: 16.0),
                  Icon(Icons.star, color: Colors.amber, size: 16.0),
                  Icon(Icons.star, color: Colors.amber, size: 16.0),
                  Icon(Icons.star, color: Colors.amber, size: 16.0),
                  Icon(Icons.star_half, color: Colors.amber, size: 16.0),
                ],
              ),
            ],
          ),

          const SizedBox(height: 16.0),

          // زر التقييم
          Container(
            width: double.infinity,
            height: 45.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColor.hotRed.withOpacity(0.8), AppColor.hotRed],
              ),
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                  color: AppColor.hotRed.withOpacity(0.3),
                  blurRadius: 10.0,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(15.0),
                onTap: () {},
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.star, color: Colors.white, size: 18.0),
                      const SizedBox(width: 8.0),
                      Text(
                        "Rate Our App",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Cairo',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        elevation: 20.0,
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(30.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.white, Colors.grey.shade50],
            ),
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // أيقونة التنبيه
              Container(
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.red.withOpacity(0.3),
                    width: 2.0,
                  ),
                ),
                child: Icon(Iconsax.logout_15, color: Colors.red, size: 40.0),
              ),

              const SizedBox(height: 20.0),

              // النص
              Text(
                "Logout Confirmation",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                  fontFamily: 'Cairo',
                ),
              ),

              const SizedBox(height: 12.0),

              Text(
                "Are you sure you want to logout from your account?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey.shade600,
                  fontFamily: 'Cairo',
                ),
              ),

              const SizedBox(height: 30.0),

              // الأزرار
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.back(),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        side: BorderSide(color: Colors.grey.shade300),
                      ),
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontFamily: 'Cairo',
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 15.0),

                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.red, Colors.red.shade700],
                        ),
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.red.withOpacity(0.3),
                            blurRadius: 10.0,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(15.0),
                          onTap: () {
                            Get.back();
                            Get.find<LogoutControllerImp>().logout();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                            child: Center(
                              child: Text(
                                "Logout",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Cairo',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
