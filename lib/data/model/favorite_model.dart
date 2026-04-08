class FavoriteModel {
  int? favoriteId;
  int? favoriteUsersid;
  int? favoriteItemsid;
  int? itemsCategories;
  String? itemBrand;
  String? itemsNameAr;
  String? itemsNameEn;
  String? itemsDescriptionAr;
  String? itemsDescriptionEn;
  String? itemsImageURl;
  int? itemsDiscount;
  String? itemsPrice;
  String? finalPrice;
  String? rating;
  int? isNew;
  int? inStock;
  int? itemReviewCount;



  FavoriteModel(
      {this.favoriteId,
        this.favoriteUsersid,
        this.favoriteItemsid,
        this.itemsCategories,
        this.itemBrand,
        this.itemsNameAr,
        this.itemsNameEn,
        this.itemsDescriptionAr,
        this.itemsDescriptionEn,
        this.itemsImageURl,
        this.itemsDiscount,
        this.itemsPrice,
        this.finalPrice,
        this.rating,
        this.isNew,
        this.inStock,
        this.itemReviewCount,


      });

  FavoriteModel.fromJson(Map<String, dynamic> json) {
    favoriteId = json['favorite_id'];
    favoriteUsersid = json['favorite_usersid'];
    favoriteItemsid = json['favorite_itemsid'];
    itemsCategories = json['items_categories'];
    itemBrand = json['item_brand'];
    itemsNameAr = json['items_name_ar'];
    itemsNameEn = json['items_name_en'];
    itemsDescriptionAr = json['items_description_ar'];
    itemsDescriptionEn = json['items_description_en'];
    itemsImageURl = json['items_imageURl'];
    itemsDiscount = json['items_discount'];
    itemsPrice = json['items_price'];
    finalPrice = json['final_price'];
    rating = json['rating'];
    isNew = json['isNew'];
    inStock = json['inStock'];
    itemReviewCount = json['item_reviewCount'];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['favorite_id'] = this.favoriteId;
    data['favorite_usersid'] = this.favoriteUsersid;
    data['favorite_itemsid'] = this.favoriteItemsid;
    data['items_categories'] = this.itemsCategories;
    data['item_brand'] = this.itemBrand;
    data['items_name_ar'] = this.itemsNameAr;
    data['items_name_en'] = this.itemsNameEn;
    data['items_description_ar'] = this.itemsDescriptionAr;
    data['items_description_en'] = this.itemsDescriptionEn;
    data['items_imageURl'] = this.itemsImageURl;
    data['items_discount'] = this.itemsDiscount;
    data['items_price'] = this.itemsPrice;
    data['final_price'] = this.finalPrice;
    data['rating'] = this.rating;
    data['isNew'] = this.isNew;
    data['inStock'] = this.inStock;
    data['item_reviewCount'] = this.itemReviewCount;


    return data;
  }
}
