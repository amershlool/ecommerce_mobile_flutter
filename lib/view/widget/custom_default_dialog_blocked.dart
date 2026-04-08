import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDialogs {
  static void showBlockedDialog() {
    Get.defaultDialog(
      title: "Blocked",
      middleText:
      "This email and phone number have been temporarily blocked due to exceeding the allowed number of verification code requests. "
          "Please contact technical support for further assistance.",
      actions: [
        ElevatedButton(
          onPressed: () {
          //  Get.toNamed("/support");
          },
          child: const Text("Contact Technical Support"),
        ),
      ],
      barrierDismissible: true,
      onWillPop: () {
        Get.offAllNamed("/login");
        return Future.value(true);
      },
    );
  }
}
