import 'package:e_commerce/controller/orders/refresh_all_page_controller.dart';
import 'package:e_commerce/controller/orders/view_the_way_controller.dart';
import 'package:e_commerce/view/widget/orders/custom_order_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomOrdersListCardCondTheWay extends StatelessWidget {


  const CustomOrdersListCardCondTheWay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    RefreshAllPageControllerImp refreshAllPageControllerImp = Get.find();
    return GetBuilder<ViewTheWayOrdersControllerImp>(
      id: "ViewTheWayOrders",
      builder: (controller) => RefreshIndicator(
        onRefresh: () async =>
            await refreshAllPageControllerImp.refreshAllPage(),
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          itemCount: controller.data.length,
          itemBuilder: (context, index) {
            var order = controller.data[index];
            return CustomOrderCard(
              numberOrder: order.ordersId.toString(),
              ordersTotalPrice: order.ordersPrice!.toStringAsFixed(2),
              ordersStatus: order.ordersStatus.toString(),
              ordersDate: order.orderDatetime.toString(),
              ordersCouponName: order.couponName.toString(),
              ordersItemsCount: order.itemsCount.toString(),
              onPressed: () {
                controller.viewOrderDetails(order);
              },
              onPressedRe: () => controller.resendAndRemove(order),
            );
          },
        ),
      ),
    );
  }
}
