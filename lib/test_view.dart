import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_commerce/controller/test_controller.dart';
import 'package:e_commerce/core/class/handlingdata.dart';

class TestView extends StatelessWidget {
  const TestView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(TestController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("title"),
      ),
      body:
      // CustomError(animation: AppLottieAsset.no_internet)
      GetBuilder<TestController>(builder: (controller) {
        return HandlingDataView(
          statusRequest: controller.statusRequest,
          widget: ListView.builder(
            itemCount: controller.data.length,
            itemBuilder: (context, index) {
              return Text("${controller.data}"); // Display each item in data list
            },
          ),
        );
      },
    ),
    );
  }
}
