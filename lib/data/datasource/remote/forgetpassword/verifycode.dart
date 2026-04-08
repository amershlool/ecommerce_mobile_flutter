import 'package:e_commerce/core/class/crud.dart';
import 'package:e_commerce/linkapi.dart';

class VerifyCodeForGetPasswordData{
  Crud crud ;
  VerifyCodeForGetPasswordData( this.crud);
  Future<Object> postData(String email,String verfiycode )async{
    var response = await crud.postData(AppLink.verifyCodeForgetPassword, {
      "email": email,
      "verfiycode": verfiycode,
    });
    return response.fold((l)=>l, (r)=>r);
  }
}