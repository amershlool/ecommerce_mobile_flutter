import 'package:e_commerce/core/class/crud.dart';
import 'package:e_commerce/linkapi.dart';

class ViewOrderDetailsData {
  Crud crud;

  ViewOrderDetailsData(this.crud);

  getData(String ordersId) async {
    var response = await crud.postData(AppLink.ordersViewDetails, {
      "ordersId": ordersId,
    });
    return response.fold((l) => l, (r) => r);
  }
}
