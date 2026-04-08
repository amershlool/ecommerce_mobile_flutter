import 'package:e_commerce/core/class/crud.dart';
import 'package:e_commerce/linkapi.dart';

class StripeData {
  Crud crud;

  StripeData(this.crud);

  getData(String userId, String paymentMethodId) async {
    var response = await crud.postData(AppLink.stripeAttach, {
      "userid": userId,
      "payment_method_id": paymentMethodId,
    });
    return response.fold(((l) => l), (r) => r);
  }
}
