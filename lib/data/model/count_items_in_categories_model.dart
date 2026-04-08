class CountItemsInCategoriesModel {
  int? categoriesId;
  int? totalItems;

  CountItemsInCategoriesModel({this.categoriesId, this.totalItems});

  CountItemsInCategoriesModel.fromJson(Map<String, dynamic> json) {
    categoriesId = json['categories_id'];
    totalItems = json['total_items'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categories_id'] = this.categoriesId;
    data['total_items'] = this.totalItems;
    return data;
  }
}
