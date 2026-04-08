import 'package:e_commerce/core/class/crud.dart';
import 'package:e_commerce/linkapi.dart';

class PaymentMethodViewData {
  Crud crud;

  PaymentMethodViewData(this.crud);

  viewData(String userId) async {
    var response = await crud.postData(AppLink.stripeView, {
      "userid": userId,
    });
    return response.fold(((l) => l), (r) => r);
  }
}
