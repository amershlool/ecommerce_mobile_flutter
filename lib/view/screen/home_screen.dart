import 'dart:io';

import 'package:e_commerce/controller/homescreen_controller.dart';
import 'package:e_commerce/controller/notification_controller.dart';
import 'package:e_commerce/view/widget/custom_exit_dialog.dart';
import 'package:e_commerce/view/widget/floating_action_button.dart';
import 'package:e_commerce/view/widget/home/custom_bottom_appbar_home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeScreenControllerImp());
    Get.put(NotificationControllerImp());

    return Scaffold(
      body: PopScope(
        canPop: false,
        child: GetBuilder<HomeScreenControllerImp>(
          builder: (controller) => Scaffold(
            floatingActionButton: CustomFloatingActionButton(),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: CustomBottomAppbarHome(),
            body: controller.listPage[controller.currentPage],
          ),
        ),
        onPopInvokedWithResult: (x,cacPop) {
          showDialog(context: context,
              barrierDismissible: true,
              builder: (context){
            return CustomExitDialog(onPressed: (){
              Get.back();
            },onPressedCon: (){
              exit(0);
            },);

              });
          //return Future.value(false);
        },
      ),
    );
  }

}

