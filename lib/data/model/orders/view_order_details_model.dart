class OrdersDetailsModel {
  int? ordersId;
  int? ordersUsersid;
  int? ordersAddress;
  int? ordersType;
  int? ordersPriceDelivery;
  double? ordersPrice;
  int? ordersCoupon;
  int? ordersPaymentMethod;
  int? ordersStatus;
  String? orderNotes;
  int? orderDeliveryDate;
  String? orderDatetime;
  String? usersName;
  int? addressPhone;
  String? addressStreet;
  String? addressCity;
  String? couponName;
  int? couponDiscount;
  int? cartItemsid;
  String? itemsNameAr;
  String? itemsNameEn;
  String? itemsDescriptionAr;
  String? itemsDescriptionEn;
  String? itemsImageURl;
  String? itemsPrice;
  int? quantityItems;
  String? priceAfterDiscount;

  String? totalPriceSingleItem;
  String? totalPriceItems;

  OrdersDetailsModel({
    this.ordersId,
    this.ordersUsersid,
    this.ordersAddress,
    this.ordersType,
    this.ordersPriceDelivery,
    this.ordersPrice,
    this.ordersCoupon,
    this.ordersPaymentMethod,
    this.ordersStatus,
    this.orderNotes,
    this.orderDeliveryDate,
    this.orderDatetime,
    this.usersName,
    this.addressPhone,
    this.addressStreet,
    this.addressCity,
    this.couponName,
    this.couponDiscount,
    this.cartItemsid,
    this.itemsNameAr,
    this.itemsNameEn,
    this.itemsDescriptionAr,
    this.itemsDescriptionEn,
    this.itemsImageURl,
    this.itemsPrice,
    this.quantityItems,
    this.priceAfterDiscount,
    this.totalPriceSingleItem,
    this.totalPriceItems,
  });

  OrdersDetailsModel.fromJson(Map<String, dynamic> json) {
    ordersId = json['orders_id'];
    ordersUsersid = json['orders_usersid'];
    ordersAddress = json['orders_address'];
    ordersType = json['orders_type'];
    ordersPriceDelivery = json['orders_pricedelivrey'];
    ordersPrice = (json['orders_price'] is int)
        ? (json['orders_price'] as int).toDouble()
        : (json['orders_price'] as num?)?.toDouble();
    ordersCoupon = json['orders_coupon'];
    ordersPaymentMethod = json['orders_paymentmethod'];
    ordersStatus = json['orders_status'];
    orderNotes = json['order_notes'];
    orderDeliveryDate = json['order_delivery_date'];
    orderDatetime = json['order_datetime'];
    usersName = json['users_name'];
    addressPhone = json['address_phone'];
    addressStreet = json['address_street'];
    addressCity = json['address_city'];
    couponName = json['coupon_name'];
    couponDiscount = json['coupon_discount'];
    cartItemsid = json['cart_itemsid'];
    itemsNameAr = json['items_name_ar'];
    itemsNameEn = json['items_name_en'];
    itemsDescriptionAr = json['items_description_ar'];
    itemsDescriptionEn = json['items_description_en'];
    itemsImageURl = json['items_imageURl'];
    itemsPrice = json['items_price'];
    quantityItems = json['quantity_items'];
    priceAfterDiscount = json['price_after_discount'];

    // الإضافات الجديدة
    totalPriceSingleItem = json['totalPriceSingleItem'];
    totalPriceItems = json['totalPriceItems'] ;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['orders_id'] = ordersId;
    data['orders_usersid'] = ordersUsersid;
    data['orders_address'] = ordersAddress;
    data['orders_type'] = ordersType;
    data['orders_pricedelivrey'] = ordersPriceDelivery;
    data['orders_price'] = ordersPrice;
    data['orders_coupon'] = ordersCoupon;
    data['orders_paymentmethod'] = ordersPaymentMethod;
    data['orders_status'] = ordersStatus;
    data['order_notes'] = orderNotes;
    data['order_delivery_date'] = orderDeliveryDate;
    data['order_datetime'] = orderDatetime;
    data['users_name'] = usersName;
    data['address_phone'] = addressPhone;
    data['address_street'] = addressStreet;
    data['address_city'] = addressCity;
    data['coupon_name'] = couponName;
    data['coupon_discount'] = couponDiscount;
    data['cart_itemsid'] = cartItemsid;
    data['items_name_ar'] = itemsNameAr;
    data['items_name_en'] = itemsNameEn;
    data['items_description_ar'] = itemsDescriptionAr;
    data['items_description_en'] = itemsDescriptionEn;
    data['items_imageURl'] = itemsImageURl;
    data['items_price'] = itemsPrice;
    data['quantity_items'] = quantityItems;
    data['price_after_discount'] = priceAfterDiscount;
    data['totalPriceSingleItem'] = totalPriceSingleItem;
    data['totalPriceItems'] = totalPriceItems;

    return data;
  }
}
