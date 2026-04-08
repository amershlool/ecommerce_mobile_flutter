import 'package:e_commerce/core/class/crud.dart';
import 'package:e_commerce/linkapi.dart';

class TokenData{
  Crud crud ;
  TokenData(this.crud);
  removeToken(String tokenUsersId) async {
    var response = await crud.postData(AppLink.tokenRemove, {
      "usersId": tokenUsersId,
    });
    return response.fold((l) => l, (r) => r);
  }
  saveToken(String usersId,String token,String deviceInfo) async {
    var response = await crud.postData(AppLink.tokenSave, {
      "usersId": usersId,
      "token": token,
      "deviceInfo": deviceInfo,
    });
    return response.fold((l) => l, (r) => r);
  }


}