import 'package:e_commerce/core/class/crud.dart';
import 'package:e_commerce/linkapi.dart';

class CartData {
  Crud crud;

  CartData(this.crud);

  addCart(String usersId, String itemsId, ) async {
    var response = await crud.postData(AppLink.addCarr, {
      "usersId": usersId,
      "itemsId": itemsId,
    });
    return response.fold((l) => l, (r) => r);
  }

  removeCart(String usersId, String itemsId,String supItemId) async {
    var response = await crud.postData(AppLink.removeCart, {
      "usersId": usersId,
      "itemsId": itemsId,
      "supItemsId":supItemId

    });
    return response.fold((l) => l, (r) => r);
  }


  setCartQuantity(String usersId, String itemsId, String quantity,String supItemsId) async {
    var response = await crud.postData(AppLink.setCartQuantity, {
      "usersId": usersId,
      "itemsId": itemsId,
      "quantity": quantity,
      "supItemsId":supItemsId
    });
    return response.fold((l) => l, (r) => r);
  }
  viewCart(String usersId)async{
    var response = await crud.postData(AppLink.viewCart, {"usersId": usersId});
    return response.fold((l)=>l, (r)=>r);

  }

}
