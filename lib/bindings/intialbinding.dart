import 'package:e_commerce/controller/Rating_controller.dart';
import 'package:e_commerce/controller/cart_controller.dart';
import 'package:e_commerce/controller/change_password.dart';
import 'package:e_commerce/controller/favorite_view_controller.dart';
import 'package:e_commerce/controller/featured_products_controller.dart';
import 'package:e_commerce/controller/home_controller.dart';
import 'package:e_commerce/controller/logout_controller.dart';
import 'package:e_commerce/controller/notification_controller.dart';
import 'package:e_commerce/controller/offers_controller.dart';
import 'package:e_commerce/controller/orders/refresh_all_page_controller.dart';
import 'package:e_commerce/controller/orders/view_all_controller.dart';
import 'package:e_commerce/controller/orders/view_await_approve_controller.dart';
import 'package:e_commerce/controller/orders/view_history_controller.dart';
import 'package:e_commerce/controller/orders/view_order_details_controller.dart';
import 'package:e_commerce/controller/orders/view_progress_controller.dart';
import 'package:e_commerce/controller/orders/view_the_way_controller.dart';
import 'package:e_commerce/controller/paymenMethod/paymentMethodeView_controller.dart';
import 'package:e_commerce/controller/paymenMethod/paymentAdd_controller.dart';
import 'package:e_commerce/controller/trending_now_controller.dart';
import 'package:get/get.dart';
import 'package:e_commerce/core/class/crud.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(Crud());
    Get.put(HomeControllerImp());
    Get.put(CartControllerImp());
    Get.put(TrendingNowControllerImp());
    Get.put(FavoriteViewControllerImp());
    Get.put(LogoutControllerImp());
    Get.put(NotificationControllerImp());
    Get.put(RefreshAllPageControllerImp());
    Get.put(ViewAllOrdersControllerImp());
    Get.put(ViewAwaitApproveControllerImp());
    Get.put(ViewProgressOrdersControllerImp());
    Get.put(ViewTheWayOrdersControllerImp());
    Get.put(ViewHistoryOrdersControllerImp());
    Get.put(ViewOrderDetailsControllerImp());
    Get.put(OffersControllerImp());
    Get.put(FeaturedProductsControllerImp());
    Get.put(PaymentMethodeViewControllerImp());
    Get.put(PaymentMethodeAddControllerImp());
    Get.put(RatingController());
    Get.put(ChangePasswordControllerImp());
  }
}
