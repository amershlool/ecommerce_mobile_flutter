class CartModel {
  final int cartUsersId;
  final int cartItemsId;
  final int? cartSupItemsId;
  final int itemsCategories;
  final String itemBrand;
  final String nameAr;
  final String nameEn;
  final String descriptionAr;
  final String descriptionEn;
  final String imageUrl;
  final double price;
  final int discount;
  final double finalPrice;
  final String? colorName;
  final String? colorHex;
  final String? itemSize;
  final int itemsActive;
  final String itemsCreateAt;
  final int countItems;
  final double sumPriceItems;

  CartModel({
    required this.cartUsersId,
    required this.cartItemsId,
    required this.cartSupItemsId,
    required this.itemsCategories,
    required this.itemBrand,
    required this.nameAr,
    required this.nameEn,
    required this.descriptionAr,
    required this.descriptionEn,
    required this.imageUrl,
    required this.price,
    required this.discount,
    required this.finalPrice,
    required this.colorName,
    required this.colorHex,
    required this.itemSize,
    required this.itemsActive,
    required this.itemsCreateAt,
    required this.countItems,
    required this.sumPriceItems,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      cartUsersId: int.parse(json['cart_usersid'].toString()),
      cartItemsId: int.parse(json['cart_itemsid'].toString()),
      cartSupItemsId: json['cart_sup_itemsid'] == null
          ? null
          : int.parse(json['cart_sup_itemsid'].toString()),
      itemsCategories: int.parse(json['items_categories'].toString()),
      itemBrand: json['item_brand'] ?? '',
      nameAr: json['name_ar'] ?? '',
      nameEn: json['name_en'] ?? '',
      descriptionAr: json['description_ar'] ?? '',
      descriptionEn: json['description_en'] ?? '',
      imageUrl: json['image_url'] ?? '',
      price: double.parse(json['price'].toString()),
      discount: int.parse(json['discount'].toString()),
      finalPrice: double.parse(json['final_price'].toString()),
      colorName: json['color_name'],
      colorHex: json['color_hex'],
      itemSize: json['item_size'],
      itemsActive: int.parse(json['items_active'].toString()),
      itemsCreateAt: json['items_createat'] ?? '',
      countItems: int.parse(json['count_items'].toString()),
      sumPriceItems: double.parse(json['sumPrice_items'].toString()),
    );
  }

  // أضف هذه الدالة للتحويل إلى Map
  Map<String, dynamic> toJson() {
    return {
      'cart_usersid': cartUsersId,
      'cart_itemsid': cartItemsId,
      'cart_sup_itemsid': cartSupItemsId,
      'items_categories': itemsCategories,
      'item_brand': itemBrand,
      'name_ar': nameAr,
      'name_en': nameEn,
      'description_ar': descriptionAr,
      'description_en': descriptionEn,
      'image_url': imageUrl,
      'price': price,
      'discount': discount,
      'final_price': finalPrice,
      'color_name': colorName,
      'color_hex': colorHex,
      'item_size': itemSize,
      'items_active': itemsActive,
      'items_createat': itemsCreateAt,
      'count_items': countItems,
      'sumPrice_items': sumPriceItems,
    };
  }
}