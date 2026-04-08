import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_commerce/view/widget/alertexit/custombutton.dart';

Future<bool> alertExitApp() {
  Get.defaultDialog(
      title: "Warning",
      titleStyle: TextStyle(
          fontSize: 30,
          color: Colors.red,
          fontFamily: "BalooBhaijaan",
          fontWeight: FontWeight.bold),
      middleText: "Do you want to exit the application!",
      middleTextStyle: TextStyle(fontSize: 15),
      titlePadding: const EdgeInsets.all(5),
      actions: [
        Expanded(
            flex: 1,
            child: CustomButtonExit(
              onPressed: () {
                exit(0);
              },
              childText: "Exit",
              backgroundColor: Colors.red.withOpacity(0.5), colorBorder:Colors.white12,
            )),
        Expanded(
            flex: 1,
            child: CustomButtonExit(onPressed: () {Get.back();}, childText: "Cancel",
                backgroundColor: Colors.white12.withOpacity(0.5), colorBorder:Colors.black12
            )),
      ]);
  return Future.value(true);
}
