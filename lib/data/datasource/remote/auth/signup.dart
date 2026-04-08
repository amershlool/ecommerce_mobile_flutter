import 'package:e_commerce/core/class/crud.dart';
import 'package:e_commerce/linkapi.dart';

class SignupData{
  Crud crud ;
  SignupData( this.crud);
  Future<Object> getDataSignUp(String userName,String email,String password,String phone )async{
    var response = await crud.postData(AppLink.signUp, {
      "username": userName ,
      "email": email,
      "password": password,
      "phone": phone,
    });
    return response.fold((l)=>l, (r)=>r);
  }
}