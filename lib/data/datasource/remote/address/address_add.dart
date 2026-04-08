import 'package:e_commerce/core/class/crud.dart';
import 'package:e_commerce/linkapi.dart';

class AddressAddData {
  Crud crud;

  AddressAddData(this.crud);

  setDataAddAddress(String addressUsersId,String addressName, String addressCity, String addressStreet,
      String addressDescription,String addressPhone,String latitude, String longitude ) async {
    var response = await crud.postData(AppLink.addAddress, {
      "addressUsersId": addressUsersId,
      "addressName": addressName,
      "addressStreet": addressStreet,
      "addressCity": addressCity,
      "addressDescription": addressDescription,
      "addressPhone": addressPhone,
      "latitude":latitude ,
      "longitude":longitude,
    });
    return response.fold((l) => l, (r) => r);
  }

}

