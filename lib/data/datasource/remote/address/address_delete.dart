import 'package:e_commerce/core/class/crud.dart';
import 'package:e_commerce/linkapi.dart';

class AddressDelete {
  Crud crud;

  AddressDelete(this.crud);

  deleteData(String addressId) async {
    var response = await crud.postData(AppLink.deleteAddress,{
      "addressId": addressId,
    });
    return response.fold((l) => l, (r) => r);
  }
}
