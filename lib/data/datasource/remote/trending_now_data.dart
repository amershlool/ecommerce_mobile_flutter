import 'package:e_commerce/core/class/crud.dart';
import 'package:e_commerce/linkapi.dart';

class TrendingNowData {
  Crud crud ;
  TrendingNowData(this.crud);
  getData()async{
    var response = await crud.postData(AppLink.trendingNow, {});
    return response.fold((l) => l, (r) => r);

  }
}