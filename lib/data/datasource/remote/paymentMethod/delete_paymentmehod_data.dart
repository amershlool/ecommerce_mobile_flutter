import 'package:e_commerce/core/class/crud.dart';
import 'package:e_commerce/linkapi.dart';

class DeletePaymentMethodData {
  Crud crud;

  DeletePaymentMethodData(this.crud);

  getData(String paymentMethodId) async {
    var response = await crud.postData(AppLink.stripeDelete, {
      "payment_method_id": paymentMethodId,
    });
    return response.fold(((l) => l), (r) => r);
  }
}
