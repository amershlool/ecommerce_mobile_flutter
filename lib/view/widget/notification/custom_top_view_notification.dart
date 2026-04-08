import 'package:e_commerce/data/model/notification_model.dart';
import 'package:e_commerce/view/widget/notification/custom_details_notification.dart';
import 'package:flutter/material.dart';

void showTopNotificationOverlay(
    BuildContext context,
    NotificationModel notificationModel, {
      VoidCallback? onClose,
    }) {
  final overlayState = Overlay.of(context, rootOverlay: true);
  late OverlayEntry overlayEntry;

  overlayEntry = OverlayEntry(
    builder: (context) {
      return TopNotificationWidget(
        notificationModel: notificationModel,
        onClose: () {
          overlayEntry.remove();
          if (onClose != null) onClose();
        },
      );
    },
  );

  overlayState.insert(overlayEntry);
}
