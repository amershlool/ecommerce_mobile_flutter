import 'package:e_commerce/core/class/statusRequest.dart';
import 'package:e_commerce/core/function/handlingdatacontroller.dart';
import 'package:e_commerce/core/serveces/services.dart';
import 'package:e_commerce/data/datasource/remote/notification_data.dart';
import 'package:e_commerce/data/model/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class NotificationController extends GetxController {
  viewAllData();
  splitNotifications(List<NotificationModel> notifications);
  removeNotification(String idNotification);
  removeAllNotification();
  isReadNotification(String usersIdNotification);
  isNotReadNotification(String usersIdNotification);
  getNotificationIcon(String? type);
}

class NotificationControllerImp extends NotificationController {
  NotificationData notificationData = NotificationData(Get.find());
  late StatusRequest statusRequest;
  MyServices myServices = Get.find();
  List<NotificationModel> data = [];
  List<NotificationModel> unreadNotifications = [];
  List<NotificationModel> readNotifications = [];
  List<NotificationModel> offersNotifications = [];
  List<NotificationModel> systemNotifications = [];
  List<NotificationModel> updatesNotifications = [];
  int unreadCount = 0;

  @override
  viewAllData() async {
    data.clear();
    unreadNotifications.clear();
    readNotifications.clear();
    offersNotifications.clear();
    systemNotifications.clear();
    updatesNotifications.clear();
    unreadCount = 0;
    statusRequest = StatusRequest.loading;
    var response = await notificationData.getData(
      myServices.sharedPref.getString("userid")!,
    );
    statusRequest = handlingData(response);
    update();
    if (StatusRequest.success == statusRequest) {
      if (response["status"] == "success") {
        List responseData = response['data'];
        data.addAll(responseData.map((e) => NotificationModel.fromJson(e)));
        await splitNotifications(data);
        unreadCount = unreadNotifications.length;
        statusRequest = StatusRequest.success;

        update();
      }
      update();
    }
  }

  @override
  Future<void> splitNotifications(notifications) async {
    unreadNotifications = notifications
        .where((n) => n.notificationIsRead == 0)
        .toList();
    readNotifications = notifications
        .where((n) => n.notificationIsRead == 1)
        .toList();
    offersNotifications = notifications
        .where((n) => n.notificationType == "Offers")
        .toList();
    systemNotifications = notifications
        .where((n) => n.notificationType == "System")
        .toList();
    updatesNotifications = notifications
        .where((n) => n.notificationType == "Updates")
        .toList();
  }

  @override
  void onInit() {
    super.onInit();
    viewAllData();
  }

  @override
  removeNotification(idNotification) async {
   await notificationData.removeNotificationData(
      idNotification,
    );
    await viewAllData();
  }

  @override
  isReadNotification(idNotification) async {
    await notificationData.isReadNotificationData(idNotification);
    await viewAllData();
  }
  @override
  isNotReadNotification(idNotification) async {
    await notificationData.isNotReadNotificationData(idNotification);
    await viewAllData();
  }

  @override
  removeAllNotification() async {
    await notificationData.removeAllNotificationData(
      myServices.sharedPref.getString("userid")!,
    );
    await viewAllData();
  }

  @override
  getNotificationIcon( type) {
switch(type){
  case "Offers":
    return Icons.local_offer;
  case "Updates":
    return Icons.update;
  case "System":
    return Icons.settings;
  default:
    return Icons.notifications;

}
  }
}
