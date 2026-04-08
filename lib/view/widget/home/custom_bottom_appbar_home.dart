import 'package:e_commerce/controller/homescreen_controller.dart';
import 'package:e_commerce/core/constant/color.dart';
import 'package:e_commerce/view/widget/home/custom_button_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBottomAppbarHome extends GetView<HomeScreenControllerImp> {
  const CustomBottomAppbarHome({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: AppColor.hotRed,
      shape: CircularNotchedRectangle(),
      notchMargin: 10,
      child: SizedBox(
        child: Row(
          children: [
            ...List.generate(controller.listPage.length + 1, (index) {
              int i = index > 2 ? index - 1 : index;
              return index == 2
                  ? Spacer()
                  : CustomButtonAppbar(
                onPressed: () {
                  controller.changePage(i);
                },
                textButton: controller.titleBottomAppbar[i],
                colorItemSelected: Colors.white,
                colorTextSelected: Colors.white,
                colorItemUnSelected: Colors.white,
                colorTextUnSelected: Colors.white,
                active: controller.currentPage == i ? true : false, index: i,
              );
            }),
          ],
        ),
      ),
    );
  }
}
