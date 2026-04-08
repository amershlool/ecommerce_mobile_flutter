import 'package:e_commerce/controller/notification_controller.dart';
import 'package:e_commerce/controller/orders/refresh_all_page_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

final FlutterLocalNotificationsPlugin localNotifi =
    FlutterLocalNotificationsPlugin();
final notificationController = Get.find<NotificationControllerImp>();

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  "high_importance_channel",
  "High Importance Channel",
  description: "Used For Important Notifications",
  importance: Importance.high,
);
//-----------------------------------------------------

Future<void> initFCM() async {
  await FirebaseMessaging.instance.requestPermission();
}

//-----------------------------------------------------
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
    refreshPageNotification(message);


  print('Background message: ${message.messageId}, data: ${message.data}');
}

//-----------------------------------------------------

firebaseMessagingListen(RemoteMessage message) async {
  RemoteNotification? notification = message.notification; // title + body
  AndroidNotification? android =
      message.notification?.android; // settingsAndroid

  if (notification != null && android != null) {
    localNotifi.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'high_importance_channel', // نفس ID القناة
          'High Importance Channel',
          channelDescription: 'Used For Important Notifications',
          importance: Importance.high,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
        ),
      ),
    );
  }

  if (message.data.isNotEmpty) {
    refreshPageNotification(message);
  }

  await localNotifi
      .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
      >()
      ?.createNotificationChannel(channel);

  // settingsIOS
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: false,
  );
}

//-----------------------------------------------------
refreshPageNotification(RemoteMessage message) {
  print("===== FCM Data Received =====");
  message.data.forEach((key, value) {
    print("$key : $value");
  });
  print(Get.currentRoute);
  if (Get.currentRoute == '/orders' && message.data['namePage'] == 'orders') {
    RefreshAllPageControllerImp refreshAllPageControllerImp = Get.find();
  refreshAllPageControllerImp.refreshAllPage();
  }
    notificationController.viewAllData();
    notificationController.update();



}
