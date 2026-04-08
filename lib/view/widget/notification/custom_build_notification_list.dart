import 'dart:ui';

import 'package:e_commerce/controller/notification_controller.dart';
import 'package:e_commerce/core/class/handlingdata.dart';
import 'package:e_commerce/core/constant/color.dart';
import 'package:e_commerce/data/model/notification_model.dart';
import 'package:e_commerce/view/widget/notification/custom_top_view_notification.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

Widget buildNotificationList(
  NotificationControllerImp controller, {
  required List<NotificationModel> notifications,
}) {
  return HandlingDataView(
    statusRequest: controller.statusRequest,
    widget: RefreshIndicator(
      onRefresh: () async => await controller.viewAllData(),
      child: controller.data.isEmpty
          ? Center(child: Text(" لا توجد لديك اي اشعارات"))
          : ListView.separated(
              itemCount: notifications.length,
              separatorBuilder: (context, index) =>
                  Divider(height: 1, color: AppColor.grey.withOpacity(0.3)),
              itemBuilder: (context, index) {
                NotificationModel notification = notifications[index];
                bool isRead = (notification.notificationIsRead ?? 0) == 1;

                return Dismissible(
                  key: ValueKey(notification.notificationId),
                  background: Container(
                    color: isRead ? AppColor.hotRed : Colors.green,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(right: 20),
                    child: Icon(
                      isRead ? Icons.remove_done : Icons.done_all,
                      color: Colors.white,
                      size: 26,
                    ),
                  ),
                  secondaryBackground: Container(
                    color: Colors.redAccent,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(left: 20),
                    child: const Icon(
                      Icons.delete_forever,
                      color: Colors.white,
                      size: 26,
                    ),
                  ),
                  confirmDismiss: (direction) async {
                    if (direction == DismissDirection.startToEnd) {
                      // السحب لليمين → تعليم كمقروء

                      if (notification.notificationIsRead == 0) {
                        notification.notificationIsRead = 1;
                        controller.isReadNotification(
                          "${notification.notificationId}",
                        );
                        controller.update();
                      }
                      else if (notification.notificationIsRead == 1) {
                        notification.notificationIsRead = 0;
                        controller.isNotReadNotification(
                          "${notification.notificationId}",
                        );
                        controller.update();
                      }
                      return false; // لا تحذف العنصر
                    } else {
                      // السحب لليسار → حذف العنصر
                      return true;
                    }
                  },
                  onDismissed: (_) {
                    notifications.remove(notification);
                    controller.removeNotification(
                      "${notification.notificationId}",
                    );
                    controller.update();
                  },
                  child: ListTile(
                    dense: true,
                    onTap: () {
                      showTopNotificationOverlay(context, notification);
                      controller.isReadNotification(
                        "${notification.notificationId}",
                      );
                    },
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundColor: isRead
                          ? Colors.green.withAlpha(50)
                          : AppColor.hotRed,
                      child: Icon(
                        controller.getNotificationIcon(
                          notification.notificationType,
                        ),
                        color: isRead ? AppColor.darkGray : Colors.white,
                      ),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  notification.notificationTitle ?? "No Title",
                                  style: TextStyle(
                                    fontWeight: isRead
                                        ? FontWeight.normal
                                        : FontWeight.bold,
                                    fontSize: 14,
                                    color: AppColor.black,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Flexible(
                                child: Text(
                                  Jiffy.parse(
                                    notification.notificationDateTime!,
                                  ).fromNow(),
                                  style: TextStyle(
                                    fontFamily: 'BalooBhaijaan',
                                    color: isRead
                                        ? Colors.green
                                        : AppColor.darkGray,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 15,),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: isRead
                                ? Colors.green.withAlpha(50)
                                : AppColor.hotRed.withAlpha(
                                    50,
                                  ), // Or another suitable color
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            notification.notificationType ?? "Info",
                            style: TextStyle(
                              color: isRead
                                  ? AppColor.darkGray
                                  : AppColor.hotRed,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    subtitle: Text(
                      notification.notificationBody ?? "No Content",
                      style: TextStyle(color: AppColor.darkGray, fontSize: 13),
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: isRead
                        ? const Icon(
                            Icons.done_all,
                            color: Colors.green,
                            size: 20,
                          )
                        : const Icon(
                            Icons.mark_email_unread,
                            color: Colors.red,
                            size: 20,
                          ),
                  ),
                );
              },
            ),
    ),
  );
}
