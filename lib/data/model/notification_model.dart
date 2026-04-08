class NotificationModel {
  int? notificationId;
  String? notificationTitle;
  String? notificationBody;
  int? notificationUsersId;
  int? notificationIsRead;
  String? notificationType;
  String? notificationDateTime;


  NotificationModel(
      {this.notificationId,
        this.notificationTitle,
        this.notificationBody,
        this.notificationUsersId,
        this.notificationIsRead,
        this.notificationType,
        this.notificationDateTime,
      });

  NotificationModel.fromJson(Map<String, dynamic> json) {
    notificationId = json['notification_id'];
    notificationTitle = json['notification_title'];
    notificationBody = json['notification_body'];
    notificationUsersId = json['notification_users_id'];
    notificationIsRead = json['notification_is_read'];
    notificationType = json['notification_type'];
    notificationDateTime = json['notification_datetime'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['notification_id'] = this.notificationId;
    data['notification_title'] = this.notificationTitle;
    data['notification_body'] = this.notificationBody;
    data['notification_users_id'] = this.notificationUsersId;
    data['notification_is_read'] = this.notificationIsRead;
    data['notification_type'] = this.notificationType;
    data['notification_datetime'] = this.notificationDateTime;
    return data;
  }
}
