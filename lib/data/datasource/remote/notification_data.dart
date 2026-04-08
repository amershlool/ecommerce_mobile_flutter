import 'package:e_commerce/core/class/crud.dart';
import 'package:e_commerce/linkapi.dart';

class NotificationData {
  Crud crud;

  NotificationData(this.crud);

  getData(String usersId) async {
    var response = await crud.postData(AppLink.notification, {
      "usersId": usersId,
    });
    return response.fold((l) => l, (r) => r);
  }

  isReadNotificationData(String idNotification) async {
    var response = await crud.postData(AppLink.notificationIsRead, {
      "idNotification": idNotification,
    });
    return response.fold((l) => l, (r) => r);
  }
  isNotReadNotificationData(String idNotification) async {
    var response = await crud.postData(AppLink.notificationIsNotRead, {
      "idNotification": idNotification,
    });
    return response.fold((l) => l, (r) => r);
  }
  removeNotificationData(String idNotification) async {
    var response = await crud.postData(AppLink.notificationRemove, {
      "idNotification": idNotification,
    });
    return response.fold((l) => l, (r) => r);
  }
  removeAllNotificationData(String usersIdNotification) async {
    var response = await crud.postData(AppLink.notificationRemoveAll, {
      "usersIdNotification": usersIdNotification,
    });
    return response.fold((l) => l, (r) => r);
  }
}
