import 'dart:ui';

import 'package:e_commerce/controller/notification_controller.dart';
import 'package:e_commerce/core/constant/color.dart';
import 'package:e_commerce/data/model/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

class TopNotificationWidget extends StatefulWidget {
  final NotificationModel notificationModel;
  final VoidCallback? onClose;

  const TopNotificationWidget({
    super.key,
    required this.notificationModel,
    this.onClose,
  });

  @override
  State<TopNotificationWidget> createState() => _TopNotificationWidgetState();
}

class _TopNotificationWidgetState extends State<TopNotificationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1200),
    );

    // الحركة من أعلى إلى الأسفل مع Bounce عند الظهور
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, -1.2), // خارج الشاشة أعلى
      end: Offset(0, 0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

    _controller.forward();

    // إخفاء الإشعار تلقائياً بعد 5 ثواني مع حركة إلى الأعلى
    Future.delayed(Duration(seconds: 5), () async {
      if (!mounted) return;
      await _controller.animateBack(
        0.0,
        duration: Duration(milliseconds: 1000),
        curve: Curves.easeInBack,
      );
      if (mounted) widget.onClose?.call();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  NotificationControllerImp notificationControllerImp = Get.find();

  @override
  Widget build(BuildContext context) {
    bool isRead = (widget.notificationModel.notificationIsRead ?? 0) == 1;

    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          // الخلفية الضبابية
          GestureDetector(
            onTap: () async {
              await _controller.animateBack(
                0.0,
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInBack,
              );
              if (mounted) widget.onClose?.call();
            },
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
              child: Container(color: Colors.black.withAlpha(50)),
            ),
          ),
          SafeArea(
            child: SlideTransition(
              position: _slideAnimation,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  color: Colors.white,
                  child: Container(
                    padding: EdgeInsets.all(12),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 22,
                          backgroundColor: isRead
                              ? Colors.green.withAlpha(50)
                              : AppColor.hotRed,
                          child: Icon(
                            notificationControllerImp.getNotificationIcon(
                              widget.notificationModel.notificationType,
                            ),
                            color: isRead ? AppColor.darkGray : Colors.white,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                widget.notificationModel.notificationTitle ??
                                    "No Title",
                                style: TextStyle(
                                  fontWeight: isRead
                                      ? FontWeight.normal
                                      : FontWeight.bold,
                                  fontSize: 16,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                widget.notificationModel.notificationBody ??
                                    "No Content",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[800],
                                ),
                                maxLines: 5,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                Jiffy.parse(
                                  widget
                                      .notificationModel
                                      .notificationDateTime!,
                                ).fromNow(),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          isRead ? Icons.done_all : Icons.mark_email_unread,
                          color: isRead ? Colors.green : Colors.red,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
