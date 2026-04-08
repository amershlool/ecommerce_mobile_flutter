import 'package:e_commerce/controller/notification_controller.dart';
import 'package:e_commerce/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBarNotification extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomAppBarNotification({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(140);

  @override
  Widget build(BuildContext context) {
    NotificationControllerImp notificationControllerImp = Get.find();
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColor.hotRed, AppColor.hotRed2],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.back(); // This navigates back to the previous screen.
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new_outlined,
                          color: Colors.white,
                        ),
                      ),
                      const Text(
                        "Notifications",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.notifications,
                              color: Colors.white,
                            ),
                            onPressed: () {},
                          ),
                          if (notificationControllerImp.data
                              .where((n) => (n.notificationIsRead ?? 0) == 0)
                              .isNotEmpty)
                            Positioned(
                              right: 6,
                              top: 6,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  "${notificationControllerImp.data.where((n) => (n.notificationIsRead ?? 0) == 0).length}",
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
                      IconButton(
                        icon: const Icon(
                          Icons.delete_sweep_outlined,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Center(
                                  child: const Text("Confirm Deletion"),
                                ),
                                content: const Text(
                                  "Are you sure you want to delete all notifications?",
                                ),
                                actions: [
                                  TextButton(
                                    child: const Text(
                                      "cancelled",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    onPressed: () {
                                      Get.back();
                                    },
                                  ),
                                  TextButton(
                                    child: const Text("Delete"),
                                    onPressed: () {
                                      notificationControllerImp.data.clear();
                                      notificationControllerImp
                                          .removeAllNotification();
                                      // notificationControllerImp.update();
                                      Get.back();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // تاب بار الحالة
            Container(
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(5),
              ),
              child: TabBar(
                isScrollable: false,
                indicatorColor: AppColor.darkGray,
                indicatorWeight: 4.0,
                // Make the indicator line thicker
                labelColor: AppColor.darkGray,
                // Active icon color
                unselectedLabelColor: Colors.white,
                // Inactive icon color
                tabs: const [
                  Tab(
                    icon: Icon(Icons.list_alt),
                    //   text: "All"
                  ),
                  Tab(
                    icon: Icon(Icons.mark_email_unread),
                    // text: "Unread",
                  ),
                  Tab(
                    icon: Icon(Icons.mark_email_read),
                    //text: "Read",
                  ),
                  Tab(
                    icon: Icon(Icons.local_offer),
                    //   text: "Offers"
                  ),
                  Tab(
                    icon: Icon(Icons.settings),
                    //  text: "System"
                  ),
                  Tab(
                    icon: Icon(Icons.update),
                    //  text: "Updates"
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
