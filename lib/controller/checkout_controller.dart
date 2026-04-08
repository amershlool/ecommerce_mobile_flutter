import 'package:e_commerce/controller/Rating_controller.dart';
import 'package:e_commerce/controller/address_controller.dart';
import 'package:e_commerce/controller/cart_controller.dart';
import 'package:e_commerce/controller/orders/refresh_all_page_controller.dart';
import 'package:e_commerce/core/class/statusRequest.dart';
import 'package:e_commerce/core/constant/routesname.dart';
import 'package:e_commerce/core/function/handlingdatacontroller.dart';
import 'package:e_commerce/core/serveces/services.dart';
import 'package:e_commerce/data/datasource/remote/checkout_data.dart';
import 'package:e_commerce/data/datasource/remote/coupon_data.dart';
import 'package:e_commerce/data/datasource/remote/rating_data.dart';
import 'package:e_commerce/data/model/address_model.dart';
import 'package:e_commerce/data/model/coupon_model.dart';
import 'package:e_commerce/data/model/paymentMethode_model.dart';
import 'package:e_commerce/view/widget/cart/custom_snackbar.dart';
import 'package:e_commerce/view/widget/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class CheckoutController extends GetxController {
  chooseDeliveryMethod(String val);

  choosePaymentMethod(String val);

  choosePaymentCard(ViewPaymentMethods card);

  chooseDeliveryTime(String val);

  chooseShippingAddress(AddressModel address);

  validateAddressSelection();

  checkOut();

  checkCoupon();

  getTotalPrice();

  onRemove();

  // دالة جديدة لعرض دايلوج التقييم
  void showProductRatingDialog(List<Map<String, dynamic>> products);
}

class CheckoutControllerImp extends CheckoutController {
  // Controllers
  CartControllerImp cartControllerImp = Get.find();
  AddressControllerImp addressControllerImp = Get.put(AddressControllerImp());
  RatingData ratingData = RatingData(Get.find());
RatingController ratingController = Get.find();
  // Coupon
  TextEditingController? couponController;
  CouponModel? couponModel;
  CouponData couponData = CouponData(Get.find());
  int? discountCoupon = 0;
  String? couponName;
  int? couponId;

  // Checkout & Stripe
  late double priceOrders;
  CheckOutData checkOutData = Get.put(CheckOutData(Get.find()));
  StatusRequest statusRequest = StatusRequest.none;
  MyServices myServices = Get.find();
  double priceShipping = 5.0;
  String deliveryMethod = "Delivery";
  int deliveryType = 0;
  String paymentMethod = "Cash";
  int paymentType = 0;
  String deliveryTime = "Morning (8am - 12pm)";
  int deliveryTimeType = 1;
  String addressId = "0";
  TextEditingController? notesController;
  AddressModel? selectedAddress;
  ViewPaymentMethods? selectedPaymentMethods;
  bool isSelectedAddress = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // متغيرات للتقييم
  List<Map<String, dynamic>> orderedProducts = [];
  bool showRatingDialog = false;

  // ---------------------------------------------
  @override
  void onInit() async {
    super.onInit();
    couponController = TextEditingController();
    notesController = TextEditingController();
    discountCoupon = 0;
    couponName = null;
    couponId = null;
    deliveryType = deliveryMethod == "Delivery" ? 0 : 1;
    deliveryTimeType = deliveryType == 0 ? 1 : 0;
    orderedProducts = [];
    showRatingDialog = false;
    update();
  }

  @override
  void onClose() {
    couponController?.dispose();
    notesController?.dispose();
    super.onClose();
  }

  @override
  getTotalPrice() {
    double discount = (discountCoupon ?? 0).toDouble();
    double priceAfterDiscount =
        cartControllerImp.totalPrice -
        (cartControllerImp.totalPrice * (discount / 100));
    priceOrders = double.parse(
      (priceAfterDiscount + priceShipping).toStringAsFixed(2),
    );
    return priceOrders;
  }

  double get discountCouponAmount {
    if (couponModel == null || couponModel!.couponDiscount == null) return 0.0;
    final discountPercentage = couponModel!.couponDiscount!.toDouble();
    return cartControllerImp.totalPrice * (discountPercentage / 100);
  }

  @override
  onRemove() {
    couponId = null;
    discountCoupon = 0;
    couponName = null;
    couponModel = null;
    couponController?.clear();
    update();
  }

  @override
  chooseDeliveryMethod(String val) {
    deliveryMethod = val;
    if (deliveryMethod == 'Delivery') {
      deliveryType = 0;
      deliveryTimeType = 1;
      priceShipping = 5.0;
    } else {
      deliveryType = 1;
      deliveryTimeType = 0;
      priceShipping = 0.0;
    }
    update();
  }

  @override
  choosePaymentMethod(String val) {
    paymentMethod = val;
    paymentType = (paymentMethod == 'Cash') ? 0 : 1;
    update();
  }

  @override
  choosePaymentCard(ViewPaymentMethods card) {
    selectedPaymentMethods = card;
    update();
  }

  @override
  chooseShippingAddress(AddressModel address) {
    if (deliveryMethod == 'From Store') {
      addressId = "0";
    } else {
      selectedAddress = address;
      addressId = selectedAddress!.addressId!.toString();
    }
    update();
  }

  @override
  chooseDeliveryTime(String val) {
    deliveryTime = val;
    if (deliveryType == 0) {
      if (deliveryTime == 'Morning (8am - 12pm)') {
        deliveryTimeType = 1;
      } else if (deliveryTime == 'Afternoon (12pm - 4pm)') {
        deliveryTimeType = 2;
      } else {
        deliveryTimeType = 3;
      }
    } else {
      deliveryTimeType = 0;
    }
    update();
  }

  @override
  validateAddressSelection() {
    isSelectedAddress =
        selectedAddress != null && selectedAddress!.addressName!.isNotEmpty;
    update();
  }

  // ---------------------------------------------
  @override
  checkCoupon() async {
    if (couponController!.text.trim().isEmpty) return;
    var response = await couponData.checkCoupon(couponController!.text.trim());

    if (response['status'] == 'success') {
      couponModel = CouponModel.fromJson(response['data']);
      discountCoupon = int.parse(couponModel!.couponDiscount.toString());
      couponName = couponModel!.couponName;
      couponId = couponModel!.couponId;
      update();
      CustomSnackbar.showCartEmpty(
        "تم تطبيق الكوبون بنجاح ✅",
        "تم خصم $discountCoupon% من إجمالي السعر.",
        Icons.check_circle_outline,
      );
    } else if (response['status'] == 'max_usage') {
      CustomSnackbar.showCartEmpty(
        "كوبون غير متاح",
        "تم استخدام هذا الكوبون بالعدد الأقصى المسموح لجميع المستخدمين.",
        Icons.warning,
      );
      discountCoupon = 0;
      couponName = null;
      couponId = null;
      update();
    } else if (response['status'] == 'end_expired') {
      CustomSnackbar.showCartEmpty(
        "انتهت صلاحية الكوبون",
        "هذا الكوبون لم يعد صالحًا للاستخدام.",
        Icons.event_busy,
      );
      discountCoupon = 0;
      couponName = null;
      update();
    } else {
      CustomSnackbar.showCartEmpty(
        "كوبون غير صالح",
        "يرجى التأكد من كتابة اسم الكوبون بشكل صحيح.",
        Icons.error_outline,
      );
      discountCoupon = 0;
      couponName = null;
      couponId = 0;
      update();
    }
  }

  // دالة لتحويل الاستجابة إلى لائحة منتجات
  List<Map<String, dynamic>> _extractProductsFromResponse(dynamic response) {
    List<Map<String, dynamic>> products = [];

    if (response is Map && response.containsKey('data')) {
      var data = response['data'];
      if (data is List) {
        for (var item in data) {
          if (item is Map<String, dynamic>) {
            products.add({
              'id': item['cart_itemsid']?.toString() ?? '',
              'nameAr': item['name_ar']?.toString() ?? '',
              'nameEn': item['name_en']?.toString() ?? '',
              'imageUrl': item['image_url']?.toString() ?? '',
            });
          }
        }
      }
    }

    return products;
  }


  @override
  void showProductRatingDialog(List<Map<String, dynamic>> products) {
    if (products.isEmpty) return;
    orderedProducts = products;
    showRatingDialog = true;
    update();

    Future.delayed(Duration(milliseconds: 1500), () {
      ratingController.setItemsToRate(products, Get.context!);
      ratingController.startRatingFlow(Get.context!);
    });
  }

  // ---------------------------------------------
  @override
  checkOut() async {
    statusRequest = StatusRequest.loading;
    update();

    // فحص الكوبون
    if (couponController!.text.trim().isNotEmpty) {
      await checkCoupon();
      if (couponId == null || discountCoupon == 0) {
        statusRequest = StatusRequest.none;
        update();
        return;
      }
    }

    // فحص البطاقات و العنوان
    if (paymentType != 0 && selectedPaymentMethods == null) {
      customShowTopSnackBar(
        "Select Payment Card ❌",
        "Please choose a payment card to complete your order.",
        "",
        Icons.warning,
        () {},
      );
      statusRequest = StatusRequest.none;
      update();
      return;
    }

    if (deliveryType == 0 && selectedAddress == null) {
      customShowTopSnackBar(
        "Select Delivery Address ❌",
        "Please select a shipping address to continue.",
        "",
        Icons.warning,
        () {},
      );
      statusRequest = StatusRequest.none;
      update();
      return;
    }

    getTotalPrice();

    Map<String, dynamic> data = {
      "ordersUsersId": myServices.sharedPref.getString('userid'),
      "ordersAddress": deliveryType == 0 ? addressId : "0",
      "ordersType": deliveryType.toString(),
      "ordersPriceDelivery": deliveryType == 1 ? "0" : "5",
      "ordersPrice": priceOrders.toString(),
      "ordersCouponId": couponId != null ? couponId.toString() : "0",
      "ordersPaymentMethod": paymentType.toString(),
      "ordersPaymentCardId": selectedPaymentMethods?.paymentMethodId ?? "",
      "orderNotes": notesController!.text,
      "orderDeliveryDate": deliveryTimeType.toString(),
    };

    // إرسال البيانات
    var response = await checkOutData.setCheckOutData(data);
    statusRequest = handlingData(response);
    update();

    // اتصال/خادم فشل
    if (statusRequest != StatusRequest.success) {
      customShowTopSnackBar(
        "Connection Error ❌",
        "Unable to connect to the server. Please try again.",
        "",
        Icons.wifi_off,
        () {},
      );
      return;
    }

    // خطأ من الباك-إند
    if (response['status'] == 'error') {
      customShowTopSnackBar(
        "Payment Failed ❌",
        response['message'] ?? "Payment could not be completed.",
        "",
        Icons.error_outline,
        () {},
      );
      return;
    }

    // نجاح الطلب
    if (response['status'] == 'success') {
      final cartController = Get.find<CartControllerImp>();
      final refreshAllPageOrder = Get.find<RefreshAllPageControllerImp>();

      cartController.onInit();
      refreshAllPageOrder.refreshAllPage();

      // استخراج بيانات المنتجات من الاستجابة
      List<Map<String, dynamic>> products = _extractProductsFromResponse(
        response,
      );

      if (paymentType != 0 && selectedPaymentMethods != null) {
        customShowTopSnackBar(
          "Payment Successful 💳",
          "Your card ending with ${selectedPaymentMethods!.last4} has been charged successfully.",
          "",
          Icons.check_circle_outline,
          () {},
        );
      } else {
        customShowTopSnackBar(
          "Order Successful 🎉",
          "Your order has been placed successfully. Thank you for shopping with us!",
          "",
          Icons.check_circle_outline,
          () {},
        );
      }

      await cartControllerImp.viewCart();

      // عرض دايلوج التقييم إذا كان هناك منتجات
      if (products.isNotEmpty) {
        // انتظر قليلاً ثم اعرض دايلوج التقييم
        Future.delayed(Duration(milliseconds: 1000), () {
          showProductRatingDialog(products);
        });
      }

      Get.offAllNamed(AppRoutes.homepage);
    }
    update();
  }
}
