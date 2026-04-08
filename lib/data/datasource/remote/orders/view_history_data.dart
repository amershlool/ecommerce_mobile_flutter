import 'package:e_commerce/core/class/crud.dart';
import 'package:e_commerce/linkapi.dart';

class OrdersViewHistoryData {
  Crud crud;

  OrdersViewHistoryData(this.crud);

  getData(String usersId) async {
    var response = await crud.postData(AppLink.ordersViewHistory, {
      "usersId": usersId,
    });
    return response.fold((l) => l, (r) => r);
  }
}
