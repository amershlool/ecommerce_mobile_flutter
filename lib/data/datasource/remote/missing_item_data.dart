import 'package:e_commerce/core/class/crud.dart';
import 'package:e_commerce/core/serveces/services.dart';
import 'package:e_commerce/linkapi.dart';

class MissingItemData{
  Crud crud ;
  MissingItemData( this.crud);
  postData(String userId,String itemId ,String colorCode,String sizeName )async{
    var response = await crud.postData(AppLink.missingItem, {
      "user_id": userId,
      "item_id": itemId,
      "color_code": colorCode,
      "size_name": sizeName,
    });
    return response.fold((l) => l, (r) => r);
  }
}