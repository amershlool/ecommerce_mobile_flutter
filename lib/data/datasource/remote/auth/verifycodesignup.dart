import 'package:e_commerce/core/class/crud.dart';
import 'package:e_commerce/linkapi.dart';

class VerifyCodeSinUpData{
  Crud crud ;
  VerifyCodeSinUpData( this.crud);
  Future<Object> getDataSignUpVerifyCode(String email ,String verifyCode)async{
    var response = await crud.postData(AppLink.verifyCodeSignup, {
      "email": email,
      "verfiycode" :verifyCode ,

    });
    return response.fold((l)=>l, (r)=>r);
  }
  resendData(String email)async{
    var response = await crud.postData(AppLink.resend, {
      "email": email,
    });
    return response.fold((l)=>l, (r)=>r);


  }
}