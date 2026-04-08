import 'package:e_commerce/core/class/crud.dart';
import 'package:e_commerce/linkapi.dart';

class TestData{
  String linkUrl = "http://10.0.2.2/lux/test.php";

  Crud crud ;
  TestData( this.crud);
  Future<Object> getData()async{
    var response = await crud.postData(AppLink.test, {});
    return response.fold((l)=>l, (r)=>r);
  }
}