import 'package:e_commerce/controller/notification_controller.dart';
import 'package:e_commerce/core/constant/color.dart';
import 'package:e_commerce/core/constant/routesname.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String titleAppbar;
  final IconData iconAction;
  final void Function() onPressedIconAction;
  final void Function() onPressedIconSearch;
  final void Function(String) onChanged;
  final TextEditingController textEditingController;
  final bool isSearch;

  const CustomAppbar({
    super.key,
    required this.titleAppbar,
    required this.onPressedIconSearch,
    required this.onPressedIconAction,
    required this.iconAction,
    required this.onChanged,
    required this.textEditingController,
    required this.isSearch,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationControllerImp>(
      builder: (notificationControllerImp) => SafeArea(
        child: Column(
          children: [
            // SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    print("done Pup");
                    Scaffold.of(context).openDrawer();
                  },
                  icon: Icon(Icons.menu, color: AppColor.darkGray, size: 25),
                ),

                Expanded(
                  flex: 3,
                  child: isSearch
                      ? TextFormField(
                          controller: textEditingController,
                          onChanged: onChanged,
                          decoration: InputDecoration(
                            hintText: titleAppbar,
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontFamily: 'PlayfairDisplay',
                              color: Colors.grey[600],
                              fontSize: 20,
                            ),
                            prefixIcon: IconButton(
                              onPressed: onPressedIconSearch,
                              icon: Icon(
                                Icons.search,
                                color: AppColor.darkGray,
                              ),
                            ),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 15,
                            ),
                            // filled: true,
                            // fillColor: Colors.grey.shade200,
                          ),
                        )
                      : Text(
                          titleAppbar,
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(
                                color: AppColor.darkGray,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'PlayfairDisplay',
                                fontSize: 22,
                              ),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                ),
                SizedBox(width: 5),

                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      SizedBox(width: 5),
                      SizedBox(
                        width: 15,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          onPressed: onPressedIconAction,
                          icon: Icon(
                            iconAction,
                            color: AppColor.darkGray,
                            size: 25,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),

                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          SizedBox(
                            width: 50,
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              onPressed: () {
                                Get.toNamed(AppRoutes.notification);
                              },
                              icon: const Icon(
                                Icons.notifications_none,
                                color: AppColor.darkGray,
                                size: 27,
                              ),
                            ),
                          ),
                          if (notificationControllerImp.unreadCount > 0)
                            Positioned(
                              right: 5,
                              top: -1,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  "${notificationControllerImp.unreadCount}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10);
}
