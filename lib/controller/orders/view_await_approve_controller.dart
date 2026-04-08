import 'package:e_commerce/controller/orders/refresh_all_page_controller.dart';
import 'package:e_commerce/controller/orders/view_order_details_controller.dart';
import 'package:e_commerce/core/class/statusRequest.dart';
import 'package:e_commerce/core/function/handlingdatacontroller.dart';
import 'package:e_commerce/core/serveces/services.dart';
import 'package:e_commerce/data/datasource/remote/orders/remove_orders_data.dart';
import 'package:e_commerce/data/datasource/remote/orders/view_await_approve_data.dart';
import 'package:e_commerce/data/model/orders/view_await_approve_model.dart';
import 'package:e_commerce/view/widget/orders/bottomSheet/custom_order_details_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class ViewAwaitApproveController extends GetxController {
  getViewAwaitApprove();

  refreshPage();

  viewOrderDetails(OrderViewAwaitApproveModel order);

  removeOrder(OrderViewAwaitApproveModel order);

  resendAndRemove(OrderViewAwaitApproveModel order);
}

class ViewAwaitApproveControllerImp extends ViewAwaitApproveController {
  List<OrderViewAwaitApproveModel> data = [];
  StatusRequest statusRequest = StatusRequest.loading;
  OrdersViewAwaitApprove ordersViewAwaitApprove = OrdersViewAwaitApprove(
    Get.find(),
  );
  MyServices myServices = Get.find();
  RemoveOrdersData removeOrdersData = RemoveOrdersData(Get.find());
  RefreshAllPageControllerImp refreshAllPageControllerImp = Get.find();

  @override
  Future<void> removeOrder(order) async {
    var response = await removeOrdersData.removeData(
      order.ordersId!.toString(),
    );
    if (response['status'] == "success") {
      data.removeWhere((e) => e.ordersId == order.ordersId);
      update(["ViewAwaitApprove"]);
    } else {
      Get.snackbar("Error", "Failed to delete order");
    }
  }

  @override
  resendAndRemove(order) {
    order.ordersStatus == -1 || order.ordersStatus == 3
        ? {
            removeOrder(order),
            refreshAllPageControllerImp.refreshAllPage(),
            update(),
          }
        : print("-------------------Resend-------------");
  }

  @override
  refreshPage() async {
    await getViewAwaitApprove();
    update(["ViewAwaitApprove"]);
  }

  @override
  viewOrderDetails(order) async {
    ViewOrderDetailsControllerImp viewOrderDetailsControllerImp = Get.find();
    await viewOrderDetailsControllerImp.getViewOrdersDetailsData(
      order.ordersId.toString(),
    );
    if (viewOrderDetailsControllerImp.data.isNotEmpty) {
      showModalBottomSheet(
        isScrollControlled: true,
        builder: (context) => CustomOrderDetailsBottomSheet(
          orderId: order.ordersId.toString(),
          ordersDetails: viewOrderDetailsControllerImp.data,
        ),
        context: Get.context!,
      );
    } else {
      Get.snackbar("Error", "Failed to load order details");
    }
  }

  @override
  getViewAwaitApprove() async {
    data.clear();
    statusRequest = StatusRequest.loading;
    update(["ViewAwaitApprove"]);
    var response = await ordersViewAwaitApprove.getData(
      myServices.sharedPref.getString("userid")!,
    );

    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success &&
        response['status'] == "success") {
      List listData = response['data'];
      data.addAll(listData.map((e) => OrderViewAwaitApproveModel.fromJson(e)));
    } else {
      statusRequest = StatusRequest.failure;
      update(["ViewAwaitApprove"]);
    }

    update(["ViewAwaitApprove"]);
  }

  @override
  void onInit() {
    super.onInit();
    getViewAwaitApprove();
  }
}
