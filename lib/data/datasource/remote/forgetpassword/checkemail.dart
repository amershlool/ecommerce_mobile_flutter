import 'package:e_commerce/core/class/crud.dart';
import 'package:e_commerce/linkapi.dart';

class CheckemailData{
  Crud crud ;
  CheckemailData( this.crud);
  Future<Object> postData(String email )async{
    var response = await crud.postData(AppLink.checkEmail, {
      "email": email,
    });
    return response.fold((l)=>l, (r)=>r);
  }
}