import 'package:e_commerce/controller/notification_controller.dart';
import 'package:e_commerce/core/class/handlingdata.dart';
import 'package:e_commerce/core/constant/color.dart';
import 'package:e_commerce/view/widget/notification/custom_app_bar_notification.dart';
import 'package:e_commerce/view/widget/notification/custom_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationControllerImp>(
      builder: (controller) {
        return DefaultTabController(
          length: 6,
          child: Scaffold(
            backgroundColor: AppColor.background,
            appBar: CustomAppBarNotification(),
            body: HandlingDataView(
              statusRequest: controller.statusRequest,
              widget: CustomTabBarView(),
            ),
          ),
        );
      },
    );
  }
}
