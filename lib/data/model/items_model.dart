class ItemsModel {
  int? itemsId;
  int? itemsCategories;
  String? itemsNameAr;
  String? itemsNameEn;
  String? itemsDescriptionAr;
  String? itemsDescriptionEn;
  String? itemsImageURl;
  int? itemsCount;
  int? itemsActive;
  double? itemsPrice;
  int? itemsDiscount;
  String? itemsCreateat;
  int? categoriesId;
  String? categoriesNameAr;
  String? categoriesNameEn;
  String? categoriesDescriptionAr;
  String? categoriesDescriptionEn;
  String? categoriesImageURL;
  String? categoriesCreatedAt;
  String? categoriesUpdatedAt;
  int? favorite;
  String? finalPrice;


  ItemsModel({
    this.itemsId,
    this.itemsCategories,
    this.itemsNameAr,
    this.itemsNameEn,
    this.itemsDescriptionAr,
    this.itemsDescriptionEn,
    this.itemsImageURl,
    this.itemsCount,
    this.itemsActive,
    this.itemsPrice,
    this.itemsDiscount,
    this.itemsCreateat,
    this.categoriesId,
    this.categoriesNameAr,
    this.categoriesNameEn,
    this.categoriesDescriptionAr,
    this.categoriesDescriptionEn,
    this.categoriesImageURL,
    this.categoriesCreatedAt,
    this.categoriesUpdatedAt,
    this.favorite,
    this.finalPrice,
  });

  ItemsModel.fromJson(Map<String, dynamic> json) {
    itemsId = json['items_id'];
    itemsCategories = json['items_categories'];
    itemsNameAr = json['items_name_ar'];
    itemsNameEn = json['items_name_en'];
    itemsDescriptionAr = json['items_description_ar'];
    itemsDescriptionEn = json['items_description_en'];
    itemsImageURl = json['items_imageURl'];
    itemsCount = json['items_count'];
    itemsActive = json['items_active'];
    itemsPrice = double.parse(json['items_price'].toString());
    itemsDiscount = json['items_discount'];
    itemsCreateat = json['items_createat'];
    categoriesId = json['categories_id'];
    categoriesNameAr = json['categories_name_ar'];
    categoriesNameEn = json['categories_name_en'];
    categoriesDescriptionAr = json['categories_description_ar'];
    categoriesDescriptionEn = json['categories_description_en'];
    categoriesImageURL = json['categories_imageURL'];
    categoriesCreatedAt = json['categories_createdAt'];
    categoriesUpdatedAt = json['categories_updatedAt'];
    favorite = json['isFavorite'];
    finalPrice = json['final_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['items_id'] = this.itemsId;
    data['items_categories'] = this.itemsCategories;
    data['items_name_ar'] = this.itemsNameAr;
    data['items_name_en'] = this.itemsNameEn;
    data['items_description_ar'] = this.itemsDescriptionAr;
    data['items_description_en'] = this.itemsDescriptionEn;
    data['items_imageURl'] = this.itemsImageURl;
    data['items_count'] = this.itemsCount;
    data['items_active'] = this.itemsActive;
    data['items_price'] = this.itemsPrice;
    data['items_discount'] = this.itemsDiscount;
    data['items_createat'] = this.itemsCreateat;
    data['categories_id'] = this.categoriesId;
    data['categories_name_ar'] = this.categoriesNameAr;
    data['categories_name_en'] = this.categoriesNameEn;
    data['categories_description_ar'] = this.categoriesDescriptionAr;
    data['categories_description_en'] = this.categoriesDescriptionEn;
    data['categories_imageURL'] = this.categoriesImageURL;
    data['categories_createdAt'] = this.categoriesCreatedAt;
    data['categories_updatedAt'] = this.categoriesUpdatedAt;
    data['isFavorite'] = this.favorite;
    data['final_price'] = this.finalPrice;
    return data;
  }
}
