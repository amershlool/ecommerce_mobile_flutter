import 'package:e_commerce/data/datasource/remote/rating_data.dart';

class ProductDetailsModel {
  int? itemsId;
  int? itemsCategories;
  String? itemBrand;
  String? itemsNameAr;
  String? itemsNameEn;
  String? itemsDescriptionAr;
  String? itemsDescriptionEn;
  String? itemsImageURl;
  int? itemsCount;
  int? itemsActive;
  String? itemsPrice;
  dynamic superPrice;
  int? countSuperPrice;
  int? itemsDiscount;
  String? itemsColorName;
  String? itemsColorCode;
  String? itemsSizeName;
  int? itemReviewCount;
  String? itemsCreateat;
  int? isNew;
  int? isFeatured;
  List<Images>? images;
  List<Features>? features;
  int? ratingCount;
  double? ratingAvg;

  ProductDetailsModel({
    this.itemsId,
    this.itemsCategories,
    this.itemBrand,
    this.itemsNameAr,
    this.itemsNameEn,
    this.itemsDescriptionAr,
    this.itemsDescriptionEn,
    this.itemsImageURl,
    this.itemsCount,
    this.itemsActive,
    this.itemsPrice,
    this.superPrice,
    this.countSuperPrice,
    this.itemsDiscount,
    this.itemsColorName,
    this.itemsColorCode,
    this.itemsSizeName,
    this.itemReviewCount,
    this.itemsCreateat,
    this.isNew,
    this.isFeatured,
    this.images,
    this.features,
    this.ratingCount,
    this.ratingAvg
  });

  ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    itemsId = json['items_id'];
    itemsCategories = json['items_categories'];
    itemBrand = json['item_brand'];
    itemsNameAr = json['items_name_ar'];
    itemsNameEn = json['items_name_en'];
    itemsDescriptionAr = json['items_description_ar'];
    itemsDescriptionEn = json['items_description_en'];
    itemsImageURl = json['items_imageURl'];
    itemsCount = json['items_count'];
    itemsActive = json['items_active'];
    itemsPrice = json['items_price'];

    // معالجة superPrice سواء كان int أو double
    superPrice = json['super_price'];
    if (superPrice is int) {
      superPrice = (superPrice as int).toDouble();
    }

    countSuperPrice = json['count_super_price'];
    itemsDiscount = json['items_discount'];
    itemsColorName = json['items_color_name'];
    itemsColorCode = json['items_color_code'];
    itemsSizeName = json['items_size_name'];
    itemReviewCount = json['item_reviewCount'];
    itemsCreateat = json['items_createat'];
    isNew = json['isNew'];
    isFeatured = json['isFeatured'];

    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
    ratingCount = json['rating_count'];
    var ratingAvgValue = json['rating_avg'];
    if (ratingAvgValue is int) {
      ratingAvg = ratingAvgValue.toDouble();
    } else if (ratingAvgValue is double) {
      ratingAvg = ratingAvgValue;
    } else {
      ratingAvg = null; // أو قيمة افتراضية
    }
    if (json['features'] != null) {
      features = <Features>[];
      json['features'].forEach((v) {
        features!.add(Features.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['items_id'] = this.itemsId;
    data['items_categories'] = this.itemsCategories;
    data['item_brand'] = this.itemBrand;
    data['items_name_ar'] = this.itemsNameAr;
    data['items_name_en'] = this.itemsNameEn;
    data['items_description_ar'] = this.itemsDescriptionAr;
    data['items_description_en'] = this.itemsDescriptionEn;
    data['items_imageURl'] = this.itemsImageURl;
    data['items_count'] = this.itemsCount;
    data['items_active'] = this.itemsActive;
    data['items_price'] = this.itemsPrice;
    data['super_price'] = this.superPrice;
    data['count_super_price'] = this.countSuperPrice;
    data['items_discount'] = this.itemsDiscount;
    data['items_color_name'] = this.itemsColorName;
    data['items_color_code'] = this.itemsColorCode;
    data['items_size_name'] = this.itemsSizeName;
    data['item_reviewCount'] = this.itemReviewCount;
    data['items_createat'] = this.itemsCreateat;
    data['isNew'] = this.isNew;
    data['isFeatured'] = this.isFeatured;
    data['rating_count'] = this.ratingCount;
    data['rating_avg'] = this.ratingAvg;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    if (this.features != null) {
      data['features'] = this.features!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Images {
  int? imageId;
  int? itemId;
  String? imageUrl;
  String? imageNameAr;
  String? imageNameEn;
  String? imageDescriptionAr;
  String? imageDescriptionEn;
  String? imagePrice;
  dynamic superPrice; // تغيير من double? إلى dynamic
  int? countSuperPrice;
  int? imageDiscount;
  String? imageColor;
  String? imageSize;
  int? imageCount;
  int? itemsActive;
  int? isNew;

  Images({
    this.imageId,
    this.itemId,
    this.imageUrl,
    this.imageNameAr,
    this.imageNameEn,
    this.imageDescriptionAr,
    this.imageDescriptionEn,
    this.imagePrice,
    this.superPrice,
    this.countSuperPrice,
    this.imageDiscount,
    this.imageColor,
    this.imageSize,
    this.imageCount,
    this.itemsActive,
    this.isNew,
  });

  Images.fromJson(Map<String, dynamic> json) {
    imageId = json['image_id'];
    itemId = json['item_id'];
    imageUrl = json['image_url'];
    imageNameAr = json['image_name_ar'];
    imageNameEn = json['image_name_en'];
    imageDescriptionAr = json['image_description_ar'];
    imageDescriptionEn = json['image_description_en'];
    imagePrice = json['image_price'];

    // معالجة superPrice سواء كان int أو double
    superPrice = json['super_price'];
    if (superPrice is int) {
      superPrice = (superPrice as int).toDouble();
    }

    countSuperPrice = json['count_super_price'];
    imageDiscount = json['image_discount'];
    imageColor = json['image_color'];
    imageSize = json['image_size'];
    imageCount = json['image_count'];
    itemsActive = json['items_active'];
    isNew = json['isNew'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image_id'] = imageId;
    data['item_id'] = itemId;
    data['image_url'] = imageUrl;
    data['image_name_ar'] = imageNameAr;
    data['image_name_en'] = imageNameEn;
    data['image_description_ar'] = imageDescriptionAr;
    data['image_description_en'] = imageDescriptionEn;
    data['image_price'] = imagePrice;
    data['super_price'] = superPrice;
    data['count_super_price'] = countSuperPrice;
    data['image_discount'] = imageDiscount;
    data['image_color'] = imageColor;
    data['image_size'] = imageSize;
    data['image_count'] = imageCount;
    data['items_active'] = itemsActive;
    data['isNew'] = isNew;
    return data;
  }
}
class Features {
  int? idFeatures;
  String? nameFeatures;
  String? iconFeatures; // سيخزن قيمة مثل "0xe798"
  double? price;

  Features({
    this.idFeatures,
    this.nameFeatures,
    this.iconFeatures,
    this.price,
  });

  Features.fromJson(Map<String, dynamic> json) {
    idFeatures = json['id_Features'];
    nameFeatures = json['name_Features'];
    iconFeatures = json['icon_Features'];

    // معالجة price سواء كان String أو int أو double
    var priceValue = json['price'];
    if (priceValue is String) {
      price = double.tryParse(priceValue) ?? 0.0;
    } else if (priceValue is int) {
      price = priceValue.toDouble();
    } else if (priceValue is double) {
      price = priceValue;
    } else {
      price = 0.0;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_Features'] = idFeatures;
    data['name_Features'] = nameFeatures;
    data['icon_Features'] = iconFeatures;
    data['price'] = price;
    return data;
  }
}