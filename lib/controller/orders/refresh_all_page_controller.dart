import 'package:e_commerce/controller/orders/view_all_controller.dart';
import 'package:e_commerce/controller/orders/view_await_approve_controller.dart';
import 'package:e_commerce/controller/orders/view_history_controller.dart';
import 'package:e_commerce/controller/orders/view_progress_controller.dart';
import 'package:e_commerce/controller/orders/view_the_way_controller.dart';
import 'package:get/get.dart';

abstract class RefreshAllPageController extends GetxController{
  refreshAllPage();
}
class RefreshAllPageControllerImp extends  RefreshAllPageController{


  @override
  refreshAllPage() {
    Get.find<ViewAllOrdersControllerImp>().refreshPage();
    Get.find<ViewAwaitApproveControllerImp>().refreshPage();
    Get.find<ViewProgressOrdersControllerImp>().refreshPage();
    Get.find<ViewTheWayOrdersControllerImp>().refreshPage();
    Get.find<ViewHistoryOrdersControllerImp>().refreshPage();
  }
}