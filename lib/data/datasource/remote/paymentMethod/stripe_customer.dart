import 'package:e_commerce/core/class/crud.dart';
import 'package:e_commerce/linkapi.dart';

class StripeCustomer {
  Crud crud;

  StripeCustomer(this.crud);

  getData(String email) async {
    var response = await crud.postData(AppLink.stripeCustomers, {
      "email": email,
    });
    return response.fold(((l) => l), (r) => r);
  }
}
