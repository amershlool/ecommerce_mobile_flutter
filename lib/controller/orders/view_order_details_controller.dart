import 'package:e_commerce/core/class/statusRequest.dart';
import 'package:e_commerce/core/function/handlingdatacontroller.dart';
import 'package:e_commerce/data/datasource/remote/orders/view_order_details_data.dart';
import 'package:e_commerce/data/model/orders/view_order_details_model.dart';
import 'package:get/get.dart';

abstract class ViewOrderDetailsController extends GetxController {
  getViewOrdersDetailsData(String ordersId);
}

class ViewOrderDetailsControllerImp extends ViewOrderDetailsController {
  late StatusRequest statusRequest;

  ViewOrderDetailsData viewOrderDetailsData = ViewOrderDetailsData(Get.find());
  List<OrdersDetailsModel> data = [];
  @override
  getViewOrdersDetailsData(ordersId) async {
    data.clear();
    statusRequest = StatusRequest.loading;
    update();
    var response = await viewOrderDetailsData.getData(ordersId);
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        List listData = response['data'];
        data = listData.map((e) => OrdersDetailsModel.fromJson(e)).toList();
      }
    } else {
      statusRequest = StatusRequest.failure;
    }
    update();
  }
}
