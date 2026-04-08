import 'package:e_commerce/core/class/crud.dart';
import 'package:e_commerce/linkapi.dart';

class ProductDetailsData{
  Crud crud ;
  ProductDetailsData(this.crud);
  getData(String itemId)async{
    var response = await crud.postData(AppLink.productDetails, {
      "itemId":itemId
    });
    return response.fold((l) => l, (r) => r);

  }
}