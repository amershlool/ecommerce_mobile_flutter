import 'package:e_commerce/controller/paymenMethod/paymentMethodeView_controller.dart';
import 'package:e_commerce/core/class/statusRequest.dart';
import 'package:e_commerce/core/constant/routesname.dart';
import 'package:e_commerce/core/serveces/services.dart';
import 'package:e_commerce/data/datasource/remote/paymentMethod/stripe_customer.dart';
import 'package:e_commerce/data/datasource/remote/paymentMethod/stripe_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';

abstract class PaymentMethodeAddController extends GetxController {
  saveCreditCard();

  sendPaymentMethodToServer(var pmId);

  checkingCustomer();
}

class PaymentMethodeAddControllerImp extends PaymentMethodeAddController {
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  late TextEditingController cardNumberAdd;
  late TextEditingController expiryDate;
  late TextEditingController cardHolderName;
  late TextEditingController cvvCode;
  late bool isCvvFocused;
  StatusRequest statusRequest = StatusRequest.none;
  StripeData stripeData = StripeData(Get.find());
  StripeCustomer stripeCustomer = StripeCustomer(Get.find());
  MyServices myServices = Get.find();
  PaymentMethodeViewControllerImp paymentMethodeViewControllerImp =
      Get.find();

  @override
  void onInit() {
    super.onInit();
    cardNumberAdd = TextEditingController();
    expiryDate = TextEditingController();
    cardHolderName = TextEditingController();
    cvvCode = TextEditingController();
    isCvvFocused = false;
  }

  @override
  checkingCustomer() async {
    if (!formState.currentState!.validate()) return;
    statusRequest = StatusRequest.loading;
    update();
    try {
      await stripeCustomer.getData(myServices.sharedPref.getString("email")!);
      await saveCreditCard();
    } catch (e) {
      statusRequest = StatusRequest.failure;
      update();
      Get.snackbar('خطأ', 'فشل في التحقق من العميل');
    }
  }

  @override
  saveCreditCard() async {
    try {
      final cardDetails = CardDetails(
        number: cardNumberAdd.text,
        expirationMonth: int.parse(expiryDate.text.split('/')[0]),
        expirationYear: 2000 + int.parse(expiryDate.text.split('/')[1]),
        cvc: cvvCode.text,
      );
      await Stripe.instance.dangerouslyUpdateCardDetails(cardDetails);
      final paymentMethod = await Stripe.instance.createPaymentMethod(
        params: PaymentMethodParams.card(
          paymentMethodData: PaymentMethodData(
            billingDetails: BillingDetails(name: cardHolderName.text),
          ),
        ),
      );
      final pmId = paymentMethod.id;
      await sendPaymentMethodToServer(pmId);
      cardNumberAdd.clear();
      expiryDate.clear();
      cvvCode.clear();

    } catch (e) {
      statusRequest = StatusRequest.none;
      update();
      Get.snackbar('خطأ', 'فشل في حفظ البطاقة');
    }
  }

  @override
  sendPaymentMethodToServer(pmId) async {
    try {
      var response = await stripeData.getData(
        myServices.sharedPref.getString("userid")!,
        pmId,
      );
      if (response['status'] == "success") {
        statusRequest = StatusRequest.success;
        await paymentMethodeViewControllerImp.viewPaymentMethod();
        Get.offNamed(AppRoutes.paymentMethods);
      } else {
        statusRequest = StatusRequest.failure;
        update();
        Get.snackbar('خطأ', 'فشل في إرسال بيانات البطاقة');
      }
    } catch (e) {
      statusRequest = StatusRequest.failure;
      update();
      print('Error sending payment method: $e');
      Get.snackbar('خطأ', 'فشل في الاتصال بالخادم');
    }
  }
}
