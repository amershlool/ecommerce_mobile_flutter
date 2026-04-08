import 'package:e_commerce/core/class/crud.dart';
import 'package:e_commerce/linkapi.dart';

class RemoveOrdersData {
  Crud crud;

  RemoveOrdersData(this.crud);

  removeData(String ordersId) async {
    var response = await crud.postData(AppLink.ordersRemove, {
      "ordersId": ordersId,
    });
    return response.fold((l) => l, (r) => r);
  }
}
