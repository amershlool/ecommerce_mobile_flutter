import 'package:e_commerce/controller/orders/refresh_all_page_controller.dart';
import 'package:e_commerce/controller/orders/view_progress_controller.dart';
import 'package:e_commerce/core/class/handlingdata.dart';
import 'package:e_commerce/data/model/orders/view_Progress_model.dart';
import 'package:e_commerce/data/model/orders/view_all_model.dart';
import 'package:e_commerce/view/widget/orders/custom_order_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomOrdersListCardCondInProg extends StatelessWidget {


  const CustomOrdersListCardCondInProg({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    RefreshAllPageControllerImp refreshAllPageControllerImp = Get.find();

    return GetBuilder<ViewProgressOrdersControllerImp>(
        id: "ViewProgressOrders",
        builder: (controller) => RefreshIndicator(
            onRefresh: () async => await refreshAllPageControllerImp.refreshAllPage(),
            child: HandlingDataView(
                statusRequest: controller.statusRequest,
                widget: ListView.builder(
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
          onPressed: () => controller.viewOrderDetails(order),
          onPressedRe: ()=>controller.resendAndRemove(order),
        );
      },
    ))));
  }
}
