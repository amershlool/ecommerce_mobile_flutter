import 'package:e_commerce/core/class/crud.dart';
import 'package:e_commerce/core/serveces/services.dart';
import 'package:e_commerce/linkapi.dart';

class RatingData{
  Crud crud ;
  RatingData( this.crud);
   postData(String itemId,String rating ,String userId )async{
    var response = await crud.postData(AppLink.rating, {
      "itemId": itemId,
      "rating": rating,
      "userId": userId,
    });
    return response.fold((l) => l, (r) => r);
  }
}