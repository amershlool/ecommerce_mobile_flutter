class OrderViewAwaitApproveModel {
  int? ordersId;
  int? ordersUsersid;
  double? ordersPrice;
  int? ordersStatus;
  String? orderDatetime;
  String? couponName;
  int? itemsCount;

  OrderViewAwaitApproveModel(
      {this.ordersId,
        this.ordersUsersid,
        this.ordersPrice,
        this.ordersStatus,
        this.orderDatetime,
        this.couponName,
        this.itemsCount});

  OrderViewAwaitApproveModel.fromJson(Map<String, dynamic> json) {
    ordersId = json['orders_id'];
    ordersUsersid = json['orders_usersid'];
    ordersPrice = json['orders_price'] != null
        ? (json['orders_price'] as num).toDouble()
        : null;
    ordersStatus = json['orders_status'];
    orderDatetime = json['order_datetime'];
    couponName = json['coupon_name'];
    itemsCount = json['items_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orders_id'] = this.ordersId;
    data['orders_usersid'] = this.ordersUsersid;
    data['orders_price'] = this.ordersPrice;
    data['orders_status'] = this.ordersStatus;
    data['order_datetime'] = this.orderDatetime;
    data['coupon_name'] = this.couponName;
    data['items_count'] = this.itemsCount;
    return data;
  }
}
