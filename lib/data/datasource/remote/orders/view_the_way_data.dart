import 'package:e_commerce/core/class/crud.dart';
import 'package:e_commerce/linkapi.dart';

class OrdersViewTheWayData {
  Crud crud;

  OrdersViewTheWayData(this.crud);

  getData(String usersId) async {
    var response = await crud.postData(AppLink.ordersViewInTheWay, {
      "usersId": usersId,
    });
    return response.fold((l) => l, (r) => r);
  }
}
