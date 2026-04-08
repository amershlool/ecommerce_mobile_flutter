import 'package:e_commerce/core/class/crud.dart';
import 'package:e_commerce/linkapi.dart';

class CouponData {
  Crud crud;

  CouponData(this.crud);

  checkCoupon(String couponName) async {
    var response = await crud.postData(AppLink.checkCoupon, {
      "couponName": couponName,
    });
    return response.fold((l) => l, (r) => r);
  }
}
