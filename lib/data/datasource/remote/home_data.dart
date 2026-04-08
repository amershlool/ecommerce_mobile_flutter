import 'package:e_commerce/core/class/crud.dart';
import 'package:e_commerce/linkapi.dart';

class HomeData{

  Crud crud ;
  HomeData( this.crud);
  Future<Object> getData()async{
    var response = await crud.postData(AppLink.homePage, {});
    return response.fold((l)=>l, (r)=>r);
  }
   searchItems(String search)async{
    var response = await crud.postData(AppLink.searchItems, {"search":search});
    return response.fold((l)=>l, (r)=>r);
  }
  getCountItems()async{
    var response =await crud.postData(AppLink.countItemsInCategories, {});
    return response.fold((l)=>l, (r)=>r);
  }
  directAdvertising()async{
    var response =await crud.postData(AppLink.directAdvertising, {});
    return response.fold((l)=>l, (r)=>r);
  }
}