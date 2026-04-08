class CategoriesModel {
  int? categoriesId;
  String? categoriesNameAr;
  String? categoriesNameEn;
  String? categoriesDescriptionAr;
  String? categoriesDescriptionEn;
  String? categoriesImageURL;
  String? categoriesCreatedAt;
  String? categoriesUpdatedAt;

  CategoriesModel(
      {this.categoriesId,
        this.categoriesNameAr,
        this.categoriesNameEn,
        this.categoriesDescriptionAr,
        this.categoriesDescriptionEn,
        this.categoriesImageURL,
        this.categoriesCreatedAt,
        this.categoriesUpdatedAt});

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    categoriesId = json['categories_id'];
    categoriesNameAr = json['categories_name_ar'];
    categoriesNameEn = json['categories_name_en'];
    categoriesDescriptionAr = json['categories_description_ar'];
    categoriesDescriptionEn = json['categories_description_en'];
    categoriesImageURL = json['categories_imageURL'];
    categoriesCreatedAt = json['categories_createdAt'];
    categoriesUpdatedAt = json['categories_updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['categories_id'] = categoriesId;
    data['categories_name_ar'] = categoriesNameAr;
    data['categories_name_en'] = categoriesNameEn;
    data['categories_description_ar'] = categoriesDescriptionAr;
    data['categories_description_en'] = categoriesDescriptionEn;
    data['categories_imageURL'] = categoriesImageURL;
    data['categories_createdAt'] = categoriesCreatedAt;
    data['categories_updatedAt'] = categoriesUpdatedAt;
    return data;
  }
}