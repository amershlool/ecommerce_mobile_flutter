import 'package:e_commerce/core/class/crud.dart';
import 'package:e_commerce/linkapi.dart';

class CheckOutData{
  Crud crud ;
  CheckOutData(this.crud);
  setCheckOutData(Map data)async{
    var  response = await crud.postData(AppLink.checkOut, data);
    return response.fold((l)=>l, (r)=>r);
  }

}