import 'package:e_commerce/controller/orders/view_all_controller.dart';
import 'package:e_commerce/controller/orders/view_progress_controller.dart';
import 'package:e_commerce/view/widget/popuMenuItemAppbar/custom_build_stat_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomUserStatsBar extends StatelessWidget {
  const CustomUserStatsBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.black.withAlpha(100),
        border: Border(bottom: BorderSide(color: Colors.black, width: 0.5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GetBuilder<ViewAllOrdersControllerImp>(
            builder: (controller) {
              return CustomBuildStatItem(
                title: 'Orders',
                value: controller.data.length.toString(),
              );
            },
          ),
          GetBuilder<ViewProgressOrdersControllerImp>(
            builder: (controller) {
              return CustomBuildStatItem(title: 'Pending Order', value: '${controller.data.length}');
            }
          ),
          CustomBuildStatItem(title: 'Points', value: '1.2K'),
        ],
      ),
    );
  }
}
