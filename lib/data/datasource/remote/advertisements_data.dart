import 'package:e_commerce/core/class/crud.dart';
import 'package:e_commerce/linkapi.dart';

class AdvertisementsData{
  Crud crud ;
  AdvertisementsData(this.crud);
  getData()async{
    var response = await crud.postData(AppLink.marketingView, {});
    return response.fold(((l)=>l), (r)=>r);
  }
}