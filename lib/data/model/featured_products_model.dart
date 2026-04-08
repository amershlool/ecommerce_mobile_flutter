class FeaturedProductsModel {
  int? itemsId;
  String? itemsImageURl;
  int? isNew;
  int? inStock;
  int? itemsDiscount;
  String? itemsNameEn;
  String? itemsNameAr;
  String? itemBrand;
  double? rating;
  int? itemReviewCount;
  double? finalPrice;
  double? itemsPrice;

  FeaturedProductsModel(
      {this.itemsId,
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
        this.itemsPrice});

  FeaturedProductsModel.fromJson(Map<String, dynamic> json) {
    itemsId = json['items_id'];
    itemsImageURl = json['items_imageURl'];
    isNew = json['isNew'];
    inStock = json['inStock'];
    itemsDiscount = json['items_discount'];
    itemsNameEn = json['items_name_en'];
    itemsNameAr = json['items_name_ar'];
    itemBrand = json['item_brand'];


    rating = json['Rating'] != null ? double.tryParse(json['Rating'].toString()) : 0.0;
    finalPrice = json['final_price'] != null ? double.tryParse(json['final_price'].toString()) : 0.0;
    itemsPrice = json['items_price'] != null ? double.tryParse(json['items_price'].toString()) : 0.0;

    itemReviewCount = json['item_reviewCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['items_id'] = this.itemsId;
    data['items_imageURl'] = this.itemsImageURl;
    data['isNew'] = this.isNew;
    data['inStock'] = this.inStock;
    data['items_discount'] = this.itemsDiscount;
    data['items_name_en'] = this.itemsNameEn;
    data['items_name_ar'] = this.itemsNameAr;
    data['item_brand'] = this.itemBrand;
    data['Rating'] = this.rating;
    data['item_reviewCount'] = this.itemReviewCount;
    data['final_price'] = this.finalPrice;
    data['items_price'] = this.itemsPrice;
    return data;
  }
}
