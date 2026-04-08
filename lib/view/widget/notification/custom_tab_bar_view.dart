import 'package:e_commerce/controller/notification_controller.dart';
import 'package:e_commerce/view/widget/notification/custom_build_notification_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTabBarView extends StatelessWidget {
  NotificationControllerImp notificationControllerImp = Get.find();
  CustomTabBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        buildNotificationList(
          notificationControllerImp,
          notifications: notificationControllerImp.data,
        ),
        buildNotificationList(
          notificationControllerImp,
          notifications: notificationControllerImp.unreadNotifications,
        ),
        buildNotificationList(
          notificationControllerImp,
          notifications: notificationControllerImp.readNotifications,
        ),
        buildNotificationList(
          notificationControllerImp,
          notifications: notificationControllerImp.offersNotifications,
        ),
        buildNotificationList(
          notificationControllerImp,
          notifications: notificationControllerImp.systemNotifications,
        ),
        buildNotificationList(
          notificationControllerImp,
          notifications: notificationControllerImp.updatesNotifications,
        ),
      ],
    )
    ;
  }
}
