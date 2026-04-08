import 'package:e_commerce/core/class/crud.dart';
import 'package:e_commerce/linkapi.dart';

class AddressEdit {
  Crud crud;

  AddressEdit(this.crud);

  editData(String addressId, String addressName, String addressStreet,
      String addressCity, String addressDescription,
      String addressPhone) async {
    var response = await crud.postData(AppLink.editAddress, {
      "addressId": addressId,
      "addressName": addressName,
      "addressStreet": addressStreet,
      "addressCity": addressCity,
      "addressDescription": addressDescription,
      "addressPhone": addressPhone,
    });
    return response.fold((l) => l, (r) => r);
  }

}