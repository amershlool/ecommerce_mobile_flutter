class TrendingNowModels {
  int? itemsId;
  String? itemsImageURl;
  int? isNew;
  int? inStock;
  int? itemsDiscount;
  String? itemsNameEn;
  String? itemsNameAr;
  String? itemBrand;
  double? rating;          // <-- double
  int? itemReviewCount;
  double? finalPrice;      // <-- double
  double? itemsPrice;      // <-- double

  TrendingNowModels({
    this.itemsId,
    this.itemsImageURl,
    this.isNew,
    this.inStock,
    this.itemsDiscount,
    this.itemsNameEn,
    this.itemsNameAr,
    this.itemBrand,
    this.rating,
    this.itemReviewCount,
    this.finalPrice,
    this.itemsPrice,
  });

  TrendingNowModels.fromJson(Map<String, dynamic> json) {
    itemsId = json['items_id'];
    itemsImageURl = json['items_imageURl'];
    isNew = json['isNew'];
    inStock = json['inStock'];
    itemsDiscount = json['items_discount'];
    itemsNameEn = json['items_name_en'];
    itemsNameAr = json['items_name_ar'];
    itemBrand = json['item_brand'];

    /// نحول إلى double بشكل آمن
    rating = json['Rating'] != null
        ? double.tryParse(json['Rating'].toString())
        : null;

    itemReviewCount = json['item_reviewCount'];

    finalPrice = json['final_price'] != null
        ? double.tryParse(json['final_price'].toString())
        : null;

    itemsPrice = json['items_price'] != null
        ? double.tryParse(json['items_price'].toString())
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['items_id'] = itemsId;
    data['items_imageURl'] = itemsImageURl;
    data['isNew'] = isNew;
    data['inStock'] = inStock;
    data['items_discount'] = itemsDiscount;
    data['items_name_en'] = itemsNameEn;
    data['items_name_ar'] = itemsNameAr;
    data['item_brand'] = itemBrand;
    data['Rating'] = rating;
    data['item_reviewCount'] = itemReviewCount;
    data['final_price'] = finalPrice;
    data['items_price'] = itemsPrice;
    return data;
  }
}
