import 'package:e_commerce/core/class/statusRequest.dart';
import 'package:e_commerce/core/serveces/services.dart';
import 'package:e_commerce/data/datasource/remote/paymentMethod/viewPaymentMethod_data.dart';
import 'package:e_commerce/data/model/paymentMethode_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class PaymentMethodeViewController extends GetxController {
  viewPaymentMethod();

  selectedCardDefault(int index, String paymentMethodeLast4);
}

class PaymentMethodeViewControllerImp extends PaymentMethodeViewController {
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  List<ViewPaymentMethods> data = [];
  StatusRequest statusRequest = StatusRequest.none;
  MyServices myServices = Get.find();
  PaymentMethodViewData paymentMethodViewData = PaymentMethodViewData(
    Get.find(),
  );
  int selectedCardIndexDefault = -1;

  @override
  viewPaymentMethod() async {
    statusRequest = StatusRequest.loading;
    update();
    try {
      var response = await paymentMethodViewData.viewData(
        myServices.sharedPref.getString("userid")!,
      );
      if (response['status'] == 'success') {
        data.clear();
        List dataResponse = response['data'];
        data.addAll(dataResponse.map((e) => ViewPaymentMethods.fromJson(e)));
        statusRequest = StatusRequest.success;
      } else {
        statusRequest = StatusRequest.failure;
      }
    } catch (e) {
      statusRequest = StatusRequest.serverFailure;
      print("Error in viewPaymentMethod: $e");
    }

    update();
  }

  @override
  @override
  selectedCardDefault(int index, String paymentMethodId) async {
    if (selectedCardIndexDefault == index) {
      selectedCardIndexDefault = -1;
      await myServices.sharedPref.remove("defaultCard");
    } else {
      selectedCardIndexDefault = index;
      await myServices.sharedPref.setString(
        "defaultCard",
        paymentMethodId,
      );
    }
    update();
  }

  @override
  void onInit() {
    super.onInit();
    String? defaultCardId = myServices.sharedPref.getString("defaultCard");
    viewPaymentMethod().then((_) {
      if (defaultCardId != null) {
        int index = data.indexWhere(
          (card) => card.paymentMethodId == defaultCardId,
        );
        if (index != -1) {
          selectedCardIndexDefault = index;
        }
      }
    });
  }
}
