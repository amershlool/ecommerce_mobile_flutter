import 'package:e_commerce/core/class/crud.dart';
import 'package:e_commerce/linkapi.dart';

class OrdersViewAllData {
  Crud crud;

  OrdersViewAllData(this.crud);

  getData(String usersId) async {
    var response = await crud.postData(AppLink.ordersViewAll, {
      "usersId": usersId,
    });
    return response.fold((l) => l, (r) => r);
  }
}
