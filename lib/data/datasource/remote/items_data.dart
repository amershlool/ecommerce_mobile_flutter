import 'package:e_commerce/core/class/crud.dart';
import 'package:e_commerce/linkapi.dart';

class ItemsData {
  Crud crud;

  ItemsData(this.crud);

  Future<Object> getData(String categoryId ) async {
    var response = await crud.postData(AppLink.items, {
      "categoryId": categoryId.toString(),
    });
    return response.fold((l) => l, (r) => r);
  }
}
