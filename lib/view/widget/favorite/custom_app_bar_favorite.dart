import 'package:e_commerce/core/constant/color.dart';
import 'package:e_commerce/view/widget/custom_popupmenuitem_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBarFavorite extends StatelessWidget {
  final String titleAppbar;
  final VoidCallback? onPressedIconNotifications;
  final VoidCallback? onPressedIconSearch;

  const CustomAppBarFavorite({
    super.key,
    required this.titleAppbar,
    required this.onPressedIconNotifications,
    required this.onPressedIconSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Get.back();
            },
            borderRadius: BorderRadius.circular(60),
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: AppColor.hotRed,
              size: 24,
            ),
          ),
          SizedBox(width: 2),

          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                hintText: titleAppbar,
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w100,
                  fontFamily: 'PlayfairDisplay',
                  color: AppColor.grey.withAlpha(400),
                  fontSize: 18,
                ),
                prefixIcon: IconButton(
                  onPressed: onPressedIconSearch,
                  icon: const Icon(Icons.search, color: AppColor.hotRed),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    color: AppColor.hotRed2,
                    width: 1.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(
                    color: AppColor.hotRed,
                    width: 2.0,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),

          const SizedBox(width: 1),

          SizedBox(
            width: 40,
            height: 60,
            child: InkWell(
              onTap: onPressedIconNotifications,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: const EdgeInsets.all(8),
                child: const Icon(
                  Icons.notifications_active_outlined,
                  color: AppColor.hotRed,
                  size: 30,
                ),
              ),
            ),
          ),
          CustomSideMenu(),
        ],
      ),
    );
  }
}
