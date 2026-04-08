import 'dart:async';
import 'package:e_commerce/core/class/statusRequest.dart';
import 'package:e_commerce/core/constant/routesname.dart';
import 'package:e_commerce/core/function/handlingdatacontroller.dart';
import 'package:e_commerce/core/serveces/services.dart';
import 'package:e_commerce/data/datasource/remote/cart_data.dart';
import 'package:e_commerce/data/model/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class CartController extends GetxController {
  // Basic Operations
  Future<void> removeFromCart(String itemsId, String supItemId);


  Future<void> viewCart();

  // Search & Filter
  void searchItems(String query);

  void filterByCategory(int categoryId);

  void filterByPriceRange(double min, double max);

  // Analytics
  Map<String, dynamic> getCartAnalytics();

  double getTotalSavings();

  // Navigation
  void goToShopping();

  void goToPageCheckOut();

  // UI State
  void toggleItemSelection(String itemsId);

  void selectAllItems(bool select);
}

class CartControllerImp extends CartController {
  final CartData _cartData = CartData(Get.find());
  final MyServices _myServices = Get.find();

  // Cart State
  StatusRequest _statusRequest = StatusRequest.loading;

  StatusRequest get statusRequest => _statusRequest;

  final List<CartModel> data = [];

  List<CartModel> get cartItems => data;

  double _totalPrice = 0.0;

  double get totalPrice => _totalPrice;

  int _totalCountItems = 0;

  int get totalCountItems => _totalCountItems;

  double _totalDiscount = 0.0;

  double get totalDiscount => _totalDiscount;

  // Search & Filter State
  final List<CartModel> _searchResults = [];

  List<CartModel> get searchResults => _searchResults;

  String _currentSearchQuery = '';

  String get currentSearchQuery => _currentSearchQuery;

  bool _isSearching = false;

  bool get isSearching => _isSearching;

  // Selection State
  final Set<String> _selectedItems = {};

  Set<String> get selectedItems => _selectedItems;

  bool get allItemsSelected => _selectedItems.length == data.length;

  double get selectedItemsTotal {
    return data
        .where((item) => _selectedItems.contains(item.cartItemsId.toString()))
        .fold(0.0, (sum, item) => sum + item.sumPriceItems);
  }

  // Analytics
  final Map<String, int> _categoryDistribution = {};

  Map<String, int> get categoryDistribution => _categoryDistribution;

  // Timer for auto-save
  Timer? _autoSaveTimer;
  final Duration _autoSaveDelay = const Duration(seconds: 2);

  // Error Handling
  final _errorStreamController = StreamController<String>.broadcast();

  Stream<String> get errorStream => _errorStreamController.stream;

  @override
  void onInit() {
    super.onInit();
    _initializeCart();
  }

  @override
  void onClose() {
    _autoSaveTimer?.cancel();
    _errorStreamController.close();
    super.onClose();
  }

  Future<void> _initializeCart() async {
    try {
      await viewCart();
    } catch (e) {
      _handleError('Failed to initialize cart: $e');
    }
  }

  void _handleError(String message) {
    _errorStreamController.add(message);
    debugPrint('Cart Error: $message');
  }

  void _scheduleAutoSave() {
    _autoSaveTimer?.cancel();
    _autoSaveTimer = Timer(_autoSaveDelay, () async {});
  }

  // ============= Basic Operations =============

  Future<void> addToCart(
    String itemsId,
    String supItemId,
  ) async {
    try {
      _setStatus(StatusRequest.loading);

      final response = await _cartData.setCartQuantity(
        _myServices.sharedPref.getString("userid")!,
        itemsId,
        "1",
        supItemId,
      );

      _setStatus(handlingData(response));

      if (_statusRequest == StatusRequest.success) {
        if (response['status'] == "success") {
          await viewCart();
          _showSuccessSnackbar(
            title: 'add_to_cart'.tr,
            message: 'product_added_successfully'.tr,
          );

          // Schedule auto-save
          _scheduleAutoSave();
        } else {
          _setStatus(StatusRequest.failure);
          _showErrorSnackbar(
            message: response['message'] ?? 'failed_to_add_product'.tr,
          );
        }
      }
    } catch (e) {
      _setStatus(StatusRequest.serverFailure);
      _handleError('Add to cart error: $e');
    }
  }

  @override
  Future<void> removeFromCart(String itemsId, String supItemId) async {
    try {
      _setStatus(StatusRequest.loading);

      final response = await _cartData.removeCart(
        _myServices.sharedPref.getString("userid")!,
        itemsId,
        supItemId,
      );

      _setStatus(handlingData(response));

      if (_statusRequest == StatusRequest.success) {
        if (response['status'] == "success") {
          await viewCart();

          // Remove from selection
          _selectedItems.remove(itemsId);

          _showSuccessSnackbar(
            title: 'removed'.tr,
            message: 'product_removed_from_cart'.tr,
          );

          _scheduleAutoSave();
        } else {
          _setStatus(StatusRequest.failure);
        }
      }
    } catch (e) {
      _setStatus(StatusRequest.serverFailure);
      _handleError('Remove from cart error: $e');
    }
  }


  @override
  Future<void> viewCart() async {
    try {
      _setStatus(StatusRequest.loading);

      final response = await _cartData.viewCart(
        _myServices.sharedPref.getString("userid")!,
      );

      _setStatus(handlingData(response));

      if (_statusRequest == StatusRequest.success) {
        if (response['status'] == "successEmpty") {
          _clearCartData();
        } else if (response['status'] == "success") {
          _updateCartData(response);
          _calculateAnalytics();
        } else {
          _setStatus(StatusRequest.failure);
        }
      }
    } catch (e) {
      _setStatus(StatusRequest.serverFailure);
      _handleError('View cart error: $e');
    }
  }

  void _updateCartData(Map<String, dynamic> response) {
    final List dataResponse = response['data'];

    data.clear();
    data.addAll(dataResponse.map((e) => CartModel.fromJson(e)));

    _totalPrice = (response['totalPriceInCart'] ?? 0).toDouble();
    _totalCountItems = response['totalCountItemsInCart'] ?? 0;

    // Calculate total discount
    _totalDiscount = data.fold(0.0, (sum, item) {
      final originalPrice = item.price * item.countItems;
      final finalPrice = item.sumPriceItems;
      return sum + (originalPrice - finalPrice);
    });

    // Clear selection if items changed
    _selectedItems.removeWhere(
      (id) => !data.any((item) => item.cartItemsId.toString() == id),
    );
  }

  void _clearCartData() {
    data.clear();
    _totalPrice = 0.0;
    _totalCountItems = 0;
    _totalDiscount = 0.0;
    _selectedItems.clear();
    _categoryDistribution.clear();
  }

  // ============= Search & Filter =============

  @override
  void searchItems(String query) {
    _currentSearchQuery = query.toLowerCase();
    _isSearching = query.isNotEmpty;

    if (query.isEmpty) {
      _searchResults.clear();
    } else {
      _searchResults.clear();
      _searchResults.addAll(
        data.where((item) {
          return item.nameEn.toLowerCase().contains(query) ||
              item.nameAr.contains(query) ||
              item.itemBrand.toLowerCase().contains(query) ||
              item.descriptionEn.toLowerCase().contains(query);
        }),
      );
    }

    update();
  }

  @override
  void filterByCategory(int categoryId) {
    _searchResults.clear();
    _searchResults.addAll(
      data.where((item) => item.itemsCategories == categoryId),
    );
    _isSearching = true;
    update();
  }

  @override
  void filterByPriceRange(double min, double max) {
    _searchResults.clear();
    _searchResults.addAll(
      data.where((item) => item.finalPrice >= min && item.finalPrice <= max),
    );
    _isSearching = true;
    update();
  }

  // ============= Analytics =============

  @override
  Map<String, dynamic> getCartAnalytics() {
    return {
      'totalItems': _totalCountItems,
      'totalPrice': _totalPrice,
      'totalSavings': getTotalSavings(),
      'averageItemPrice': _totalCountItems > 0
          ? _totalPrice / _totalCountItems
          : 0,
      'categoryDistribution': _categoryDistribution,
      'mostExpensiveItem': _getMostExpensiveItem(),
      'leastExpensiveItem': _getLeastExpensiveItem(),
    };
  }

  @override
  double getTotalSavings() {
    return data.fold(0.0, (savings, item) {
      if (item.discount > 0) {
        final originalTotal = item.price * item.countItems;
        final discountedTotal = item.finalPrice * item.countItems;
        return savings + (originalTotal - discountedTotal);
      }
      return savings;
    });
  }

  void _calculateAnalytics() {
    _categoryDistribution.clear();

    for (final item in data) {
      final category = item.itemsCategories.toString();
      _categoryDistribution.update(
        category,
        (value) => value + item.countItems,
        ifAbsent: () => item.countItems,
      );
    }
  }

  CartModel? _getMostExpensiveItem() {
    if (data.isEmpty) return null;
    return data.reduce((a, b) => a.finalPrice > b.finalPrice ? a : b);
  }

  CartModel? _getLeastExpensiveItem() {
    if (data.isEmpty) return null;
    return data.reduce((a, b) => a.finalPrice < b.finalPrice ? a : b);
  }

  // ============= Selection Management =============

  @override
  void toggleItemSelection(String itemsId) {
    if (_selectedItems.contains(itemsId)) {
      _selectedItems.remove(itemsId);
    } else {
      _selectedItems.add(itemsId);
    }
    update();
  }

  @override
  void selectAllItems(bool select) {
    if (select) {
      _selectedItems.addAll(data.map((item) => item.cartItemsId.toString()));
    } else {
      _selectedItems.clear();
    }
    update();
  }

  // ============= Navigation =============

  @override
  void goToShopping() {
    Get.toNamed(AppRoutes.categories);
  }

  @override
  void goToPageCheckOut() {
    if (data.isEmpty) {
      _showErrorSnackbar(message: 'cart_is_empty'.tr);
      return;
    }

    Get.toNamed(
      AppRoutes.checkOut,
      arguments: {
        'cartItems': data,
        'totalPrice': _totalPrice,
        'totalItems': _totalCountItems,
        'selectedItems': _selectedItems.isNotEmpty
            ? data
                  .where(
                    (item) =>
                        _selectedItems.contains(item.cartItemsId.toString()),
                  )
                  .toList()
            : data,
      },
    );
  }

  // ============= Helper Methods =============

  void _setStatus(StatusRequest status) {
    _statusRequest = status;
    update();
  }

  void _showSuccessSnackbar({required String title, required String message}) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  void _showErrorSnackbar({required String message}) {
    Get.snackbar(
      'error'.tr,
      message,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
    );
  }

  // ============= Getters for UI =============

  List<CartModel> get displayItems {
    return _isSearching ? _searchResults : data;
  }

  bool get hasItems => data.isNotEmpty;

  double get averageItemPrice {
    if (data.isEmpty) return 0.0;
    return _totalPrice / _totalCountItems;
  }

  Map<String, double> get priceRange {
    if (data.isEmpty) return {'min': 0.0, 'max': 0.0};

    final prices = data.map((item) => item.finalPrice);
    return {
      'min': prices.reduce((a, b) => a < b ? a : b),
      'max': prices.reduce((a, b) => a > b ? a : b),
    };
  }
}
