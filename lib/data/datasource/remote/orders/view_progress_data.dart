import 'package:e_commerce/core/class/crud.dart';
import 'package:e_commerce/linkapi.dart';

class OrdersViewProgressData {
  Crud crud;

  OrdersViewProgressData(this.crud);

  getData(String usersId) async {
    var response = await crud.postData(AppLink.ordersViewProgress, {
      "usersId": usersId,
    });
    return response.fold((l) => l, (r) => r);
  }
}
