import 'package:e_commerce/core/class/crud.dart';
import 'package:e_commerce/linkapi.dart';

class FeaturedProductsData {
  Crud crud;

  FeaturedProductsData(this.crud);

  getData() async {
    var response = await crud.postData(AppLink.featuredProducts, {});
    return response.fold((l) => l, (r) => r);
  }
}
