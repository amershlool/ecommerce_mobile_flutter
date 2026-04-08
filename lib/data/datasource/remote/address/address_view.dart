import 'package:e_commerce/core/class/crud.dart';
import 'package:e_commerce/linkapi.dart';

class AddressView {
  Crud crud;

  AddressView(this.crud);

  getData(String userId) async {
    var response = await crud.postData(AppLink.viewAddress,{
      "addressUsersId": userId,
    });
    return response.fold((l) => l, (r) => r);
  }
}
