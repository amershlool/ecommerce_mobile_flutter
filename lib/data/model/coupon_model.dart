class CouponModel {
  int? couponId;
  String? couponName;
  int? couponCount;
  int? couponUsedCount;
  int? couponDiscount;
  String? couponExpiredate;

  CouponModel(
      {this.couponId,
        this.couponName,
        this.couponCount,
        this.couponUsedCount,
        this.couponDiscount,
        this.couponExpiredate});

  CouponModel.fromJson(Map<String, dynamic> json) {
    couponId = json['coupon_id'];
    couponName = json['coupon_name'];
    couponCount = json['coupon_count'];
    couponUsedCount = json['coupon_used_count'];
    couponDiscount = json['coupon_discount'];
    couponExpiredate = json['coupon_expiredate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['coupon_id'] = this.couponId;
    data['coupon_name'] = this.couponName;
    data['coupon_count'] = this.couponCount;
    data['coupon_used_count'] = this.couponUsedCount;
    data['coupon_discount'] = this.couponDiscount;
    data['coupon_expiredate'] = this.couponExpiredate;
    return data;
  }
}
