import 'package:e_commerce/controller/paymenMethod/paymentMethodeView_controller.dart';
import 'package:e_commerce/data/datasource/remote/paymentMethod/delete_paymentmehod_data.dart';
import 'package:get/get.dart';

abstract class DeletePaymentMethodController extends GetxController {
  deletePaymentMethod(String paymentMethodId);
}

class DeletePaymentMethodControllerImp extends DeletePaymentMethodController {
  DeletePaymentMethodData deletePaymentMethodData = DeletePaymentMethodData(
    Get.find(),
  );

  PaymentMethodeViewControllerImp paymentMethodeViewControllerImp = Get.find();

  @override
  deletePaymentMethod(paymentMethodId) async {
    var response = await deletePaymentMethodData.getData(paymentMethodId);
    try {
      if (response['status'] == 'success') {
        paymentMethodeViewControllerImp.data.removeWhere(
          (card) => card.paymentMethodId == paymentMethodId,
        );
        paymentMethodeViewControllerImp.update();

        Get.snackbar("نجاح", "تم حذف البطاقة");
      } else {
        Get.snackbar("خطأ", "لم يتم حذف البطاقة: ${response['message']}");
      }
    } catch (e) {
      print(e);
    }
  }
}
