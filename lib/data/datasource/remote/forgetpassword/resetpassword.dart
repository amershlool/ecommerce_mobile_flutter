import 'package:e_commerce/core/class/crud.dart';
import 'package:e_commerce/linkapi.dart';

class ResetPasswordData{
  Crud crud ;
  ResetPasswordData( this.crud);
  Future<Object> postData(String email,String password )async{
    var response = await crud.postData(AppLink.resetPassword, {
      "email": email,
      "password": password,
    });
    return response.fold((l)=>l, (r)=>r);
  }
}