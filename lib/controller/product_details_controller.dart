import 'package:e_commerce/controller/cart_controller.dart';
import 'package:e_commerce/core/class/statusRequest.dart';
import 'package:e_commerce/core/constant/routesname.dart';
import 'package:e_commerce/core/function/handlingdatacontroller.dart';
import 'package:e_commerce/core/serveces/services.dart';
import 'package:e_commerce/data/datasource/remote/cart_data.dart';
import 'package:e_commerce/data/datasource/remote/missing_item_data.dart';
import 'package:e_commerce/data/datasource/remote/product_details_data.dart';
import 'package:e_commerce/data/model/productDetails_model.dart';
import 'package:e_commerce/view/widget/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class ProductDetailsController extends GetxController {
  void saveCartQuantity();
  void addToCart(String itemsId);
  void viewProductDetails(String itemId);
  void changeCurrentImage(int index);
  void selectColor(String colorCode);
  void selectSize(String sizeName);
  void checkProductAvailability();
  void requestProductWithColorAndSize();
  void findAndSwitchToMatchingImage();
  Map<String, dynamic> getStockStatusWithDetails(int stockQuantity);
  void toggleFeature(int featureId);
  void clearAllFeatures();
  bool isFeatureSelected(String featureId);
  int getSelectedFeaturesCount();
  Color parseColor(String colorString);
  String normalizeColorCode(String colorString);
  List<String> getAvailableSizesForColor(String colorCode);
  List<String> getAvailableColorsForSize(String sizeName);
  bool isCombinationAvailable(String colorCode, String sizeName);
}

class ProductDetailsControllerImp extends ProductDetailsController {
  // ==================== المتغيرات الأساسية ====================
  List<ProductDetailsModel> dataDetails = [];
  final ProductDetailsData productDetailsData = ProductDetailsData(Get.find());
  final MissingItemData missingItemData = MissingItemData(Get.find());
  final MyServices myServices = Get.find();
  final CartData cartData = CartData(Get.find());
  final CartControllerImp cartControllerImp = Get.find();

  late StatusRequest statusRequest;
  late PageController pageController;

  String? itemId;
  int quantity = 1;
  int countItems = 0;
  int currentImageIndex = 0;

  String? selectedColorCode;
  String? selectedSizeName;

  // بيانات المنتج الرئيسي
  String? mainProductColorCode;
  String? mainProductColorName;
  String? mainProductSizeName;

  // قوائم الخيارات المتاحة
  List<String> availableColors = [];
  List<String> availableSizes = [];

  // حالة المنتج
  bool isProductAvailable = true;
  String availabilityMessage = "";
  bool showRequestButton = false;

  // الخصائص الإضافية
  Set<String> selectedFeatures = {};

  // ==================== الخصائص المحسوبة (Getters) ====================

  double get totalPriceFeatures {
    if (dataDetails.isEmpty || dataDetails.first.features == null) return 0.0;

    double total = 0.0;
    for (var featureId in selectedFeatures) {
      try {
        final feature = dataDetails.first.features!.firstWhere(
              (f) => f.idFeatures.toString() == featureId,
          orElse: () => Features(),
        );
        if (feature.price != null) total += feature.price!.toDouble();
      } catch (e) {
        print('خطأ في معالجة الخاصية $featureId: $e');
      }
    }
    return total;
  }

  String get totalPriceFeaturesFormatted => "\$${totalPriceFeatures.toStringAsFixed(2)}";

  // ==================== دورة حياة الـ Controller ====================

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: currentImageIndex);
    itemId = Get.arguments['itemsId']?.toString() ?? "";
    if (itemId != null && itemId!.isNotEmpty) {
      viewProductDetails(itemId!);
    }
  }

  @override
  void onClose() {
    pageController.dispose();
    itemId = null;
    super.onClose();
  }

  // ==================== دوال جلب البيانات ====================

  @override
  void viewProductDetails(String itemId) async {
    statusRequest = StatusRequest.loading;
    update();

    try {
      var response = await productDetailsData.getData(itemId);

      if (response != null && response['status'] == "success") {
        _processProductData(response['data']);

        // التأكد من أن الصورة الرئيسية هي أول صورة تظهر
        currentImageIndex = 0;
        if (pageController.hasClients) {
          pageController.jumpToPage(0);
        }

        statusRequest = StatusRequest.success;
      } else {
        statusRequest = StatusRequest.failure;
      }
    } catch (e) {
      print('خطأ في جلب بيانات المنتج: $e');
      statusRequest = StatusRequest.serverFailure;
    }

    update();
  }

  void _processProductData(Map<String, dynamic> productData) {
    // تنظيف البيانات السابقة
    dataDetails.clear();
    availableColors.clear();
    availableSizes.clear();
    selectedFeatures.clear();

    // إضافة البيانات الجديدة
    dataDetails.add(ProductDetailsModel.fromJson(productData));

    // تعيين بيانات المنتج الرئيسي
    mainProductColorCode = dataDetails.first.itemsColorCode;
    mainProductColorName = dataDetails.first.itemsColorName;
    mainProductSizeName = dataDetails.first.itemsSizeName;

    // تعيين القيم الافتراضية
    selectedColorCode = mainProductColorCode;
    selectedSizeName = mainProductSizeName;

    // جمع الخيارات المتاحة
    _collectAvailableOptions();

    // إعادة تهيئة PageController
    pageController = PageController(initialPage: currentImageIndex);

    // التحقق من التوفر
    checkProductAvailability();
  }

  void _collectAvailableOptions() {
    _collectAvailableColors();
    _collectAvailableSizes();
  }

  void _collectAvailableColors() {
    Set<String> colorSet = {};

    if (mainProductColorCode != null && mainProductColorCode!.isNotEmpty) {
      colorSet.add(mainProductColorCode!);
    }

    if (dataDetails.first.images != null) {
      for (var image in dataDetails.first.images!) {
        if (image.imageColor != null && image.imageColor!.isNotEmpty) {
          colorSet.add(image.imageColor!);
        }
      }
    }

    availableColors = colorSet.toList();
    print('الألوان المتاحة: $availableColors');
  }

  void _collectAvailableSizes() {
    Set<String> sizeSet = {};

    if (mainProductSizeName != null && mainProductSizeName!.isNotEmpty) {
      sizeSet.add(mainProductSizeName!);
    }

    if (dataDetails.first.images != null) {
      for (var image in dataDetails.first.images!) {
        if (image.imageSize != null && image.imageSize!.isNotEmpty) {
          sizeSet.add(image.imageSize!);
        }
      }
    }

    availableSizes = sizeSet.toList();
    print('الأحجام المتاحة: $availableSizes');
  }

  // ==================== دوال معالجة الألوان ====================

  @override
  Color parseColor(String colorString) {
    if (colorString.isEmpty) return Colors.grey;

    try {
      String hexValue = colorString.trim();

      // إزالة البادئات إن وجدت
      if (hexValue.startsWith('0x') || hexValue.startsWith('0X')) {
        hexValue = hexValue.substring(2);
      } else if (hexValue.startsWith('#')) {
        hexValue = hexValue.substring(1);
      }

      // التأكد من الطول الصحيح
      if (hexValue.length == 6) {
        hexValue = 'FF$hexValue';
      } else if (hexValue.length != 8) {
        return Colors.grey;
      }

      return Color(int.parse(hexValue, radix: 16));
    } catch (e) {
      print('خطأ في تحويل اللون $colorString: $e');
      return Colors.grey;
    }
  }

  @override
  String normalizeColorCode(String colorString) {
    if (colorString.isEmpty) return '';

    try {
      Color color = parseColor(colorString);
      String hex = color.value.toRadixString(16).toUpperCase();
      while (hex.length < 8) hex = '0$hex';
      return hex;
    } catch (e) {
      print('خطأ في توحيد صيغة اللون $colorString: $e');
      return colorString;
    }
  }

  String _getColorNameFromHex(String hexColor) {
    try {
      Color color = parseColor(hexColor);

      if (color.red > 200 && color.green < 100 && color.blue < 100) return "Red";
      if (color.green > 200 && color.red < 100 && color.blue < 100) return "Green";
      if (color.blue > 200 && color.red < 100 && color.green < 100) return "Blue";
      if (color.red > 200 && color.green > 200 && color.blue < 100) return "Yellow";
      if (color.red < 100 && color.green < 100 && color.blue < 100) return "Black";
      if (color.red > 200 && color.green > 200 && color.blue > 200) return "White";
      if (color.red > 150 && color.green < 100 && color.blue > 150) return "Purple";
      if (color.red > 200 && color.green > 100 && color.blue < 100) return "Orange";
      if (color.red > 200 && color.green > 150 && color.blue > 150) return "Pink";
      if (color.red > 150 && color.green > 100 && color.blue < 100) return "Brown";

      return "Custom Color";
    } catch (e) {
      return "Color";
    }
  }

  // ==================== دوال التحقق من التوفر ====================

  @override
  List<String> getAvailableSizesForColor(String colorCode) {
    if (dataDetails.isEmpty) return [];

    Set<String> sizesForColor = {};
    String normalizedColor = normalizeColorCode(colorCode);

    // التحقق من المنتج الرئيسي
    if (mainProductColorCode != null) {
      String normalizedMainColor = normalizeColorCode(mainProductColorCode!);
      if (normalizedMainColor == normalizedColor && mainProductSizeName != null) {
        sizesForColor.add(mainProductSizeName!);
      }
    }

    // التحقق من الصور الفرعية
    if (dataDetails.first.images != null) {
      for (var image in dataDetails.first.images!) {
        String normalizedImageColor = normalizeColorCode(image.imageColor ?? '');
        if (normalizedImageColor == normalizedColor && image.imageSize != null) {
          sizesForColor.add(image.imageSize!);
        }
      }
    }

    return sizesForColor.toList();
  }

  @override
  List<String> getAvailableColorsForSize(String sizeName) {
    if (dataDetails.isEmpty) return [];

    Set<String> colorsForSize = {};

    // التحقق من المنتج الرئيسي
    if (mainProductSizeName == sizeName && mainProductColorCode != null) {
      colorsForSize.add(mainProductColorCode!);
    }

    // التحقق من الصور الفرعية
    if (dataDetails.first.images != null) {
      for (var image in dataDetails.first.images!) {
        if (image.imageSize == sizeName && image.imageColor != null) {
          colorsForSize.add(image.imageColor!);
        }
      }
    }

    return colorsForSize.toList();
  }

  @override
  bool isCombinationAvailable(String colorCode, String sizeName) {
    String normalizedColor = normalizeColorCode(colorCode);

    // التحقق من المنتج الرئيسي
    if (mainProductColorCode != null && mainProductSizeName != null) {
      String normalizedMainColor = normalizeColorCode(mainProductColorCode!);
      if (normalizedMainColor == normalizedColor && mainProductSizeName == sizeName) {
        return true;
      }
    }

    // التحقق من الصور الفرعية
    if (dataDetails.first.images != null) {
      for (var image in dataDetails.first.images!) {
        String normalizedImageColor = normalizeColorCode(image.imageColor ?? '');
        if (normalizedImageColor == normalizedColor && image.imageSize == sizeName) {
          return true;
        }
      }
    }

    return false;
  }



// ==================== دوال اختيار اللون والحجم ====================

  @override
  void selectColor(String colorCode) {
    // حفظ اللون المختار
    selectedColorCode = colorCode;

    // البحث عن صورة تطابق اللون الجديد مع الحجم الحالي
    bool foundMatchingImage = _findAndSwitchToMatchingImage();

    // إذا لم يتم العثور على صورة مطابقة، تحقق من التوفر
    if (!foundMatchingImage) {
      checkProductAvailability();
    }

    print('تم اختيار لون: $colorCode، الحجم الحالي: $selectedSizeName');
    update();
  }

  @override
  void selectSize(String sizeName) {
    // حفظ الحجم المختار
    selectedSizeName = sizeName;

    // البحث عن صورة تطابق الحجم الجديد مع اللون الحالي
    bool foundMatchingImage = _findAndSwitchToMatchingImage();

    // إذا لم يتم العثور على صورة مطابقة، تحقق من التوفر
    if (!foundMatchingImage) {
      checkProductAvailability();
    }

    print('تم اختيار حجم: $sizeName، اللون الحالي: $selectedColorCode');
    update();
  }
  // ==================== دوال الصور ====================

  @override
  void changeCurrentImage(int index) {
    if (dataDetails.isEmpty) return;

    currentImageIndex = index;

    // تحديث اللون والحجم بناءً على الصورة الجديدة
    _updateSelectionFromCurrentImage();

    // التحقق من التوفر (سيكون متوفراً بالتأكيد لأن الصورة موجودة)
    isProductAvailable = true;
    availabilityMessage = "Product is available".tr;
    showRequestButton = false;

    update();
  }
  void _updateSelectionFromCurrentImage() {
    if (currentImageIndex == 0) {
      // الصورة الرئيسية
      selectedColorCode = mainProductColorCode;
      selectedSizeName = mainProductSizeName;
    } else if (dataDetails.first.images != null &&
        (currentImageIndex - 1) < dataDetails.first.images!.length) {
      // صورة فرعية
      var image = dataDetails.first.images![currentImageIndex - 1];
      selectedColorCode = image.imageColor;
      selectedSizeName = image.imageSize;
    }
  }


  void _updateColorAndSizeFromImage(int imageIndex) {
    if (imageIndex == 0) {
      selectedColorCode = mainProductColorCode;
      selectedSizeName = mainProductSizeName;
    } else if (dataDetails.first.images != null &&
        imageIndex < dataDetails.first.images!.length) {
      var image = dataDetails.first.images![imageIndex];
      selectedColorCode = image.imageColor ?? selectedColorCode;
      selectedSizeName = image.imageSize ?? selectedSizeName;
    }
  }
  @override
  void findAndSwitchToMatchingImage() => _findAndSwitchToMatchingImage();

  bool _findAndSwitchToMatchingImage() {
    if (selectedColorCode == null || selectedSizeName == null) {
      return false;
    }

    String normalizedSelectedColor = normalizeColorCode(selectedColorCode!);

    // البحث في الصورة الرئيسية
    if (_tryMainImage(normalizedSelectedColor)) return true;

    // البحث في الصور الفرعية
    return _trySubImages(normalizedSelectedColor);
  }

  bool _tryMainImage(String normalizedSelectedColor) {
    if (mainProductColorCode != null && mainProductSizeName != null) {
      String normalizedMainColor = normalizeColorCode(mainProductColorCode!);
      if (normalizedMainColor == normalizedSelectedColor &&
          mainProductSizeName == selectedSizeName) {
        _changeToImage(0);
        return true;
      }
    }
    return false;
  }

  bool _trySubImages(String normalizedSelectedColor) {
    if (dataDetails.isEmpty || dataDetails.first.images == null) {
      return false;
    }

    for (int i = 0; i < dataDetails.first.images!.length; i++) {
      final image = dataDetails.first.images![i];
      String normalizedImageColor = normalizeColorCode(image.imageColor ?? '');

      if (normalizedImageColor == normalizedSelectedColor &&
          image.imageSize == selectedSizeName) {
        _changeToImage(i + 1);
        return true;
      }
    }

    return false;
  }


  void _changeToImage(int newIndex) {
    if (currentImageIndex != newIndex) {
      currentImageIndex = newIndex;
      _animateToPage(currentImageIndex);

      // ✅ مهم: لا نغير اللون والحجم هنا لأنهما محددان من قبل المستخدم
      // فقط نغير الصورة

      isProductAvailable = true;
      availabilityMessage = "Product is available".tr;
      showRequestButton = false;
      update();
    }
  }


  void _animateToPage(int pageIndex) {
    if (pageController.hasClients) {
      pageController.animateToPage(
        pageIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  // ==================== دوال التحقق من التوفر ====================

  @override
  void checkProductAvailability() {
    if (selectedColorCode == null || selectedSizeName == null) {
      _setUnavailable("Please select color and size".tr);
      return;
    }

    // التحقق من وجود المجموعة في أي صورة
    bool available = isCombinationAvailable(selectedColorCode!, selectedSizeName!);

    if (available) {
      isProductAvailable = true;
      availabilityMessage = "Product is available".tr;
      showRequestButton = false;
    } else {
      _setUnavailable(
          "This product is not available in the selected color and size".tr
      );
    }

    update();
  }

  void _setUnavailable(String message) {
    isProductAvailable = false;
    availabilityMessage = message;
    showRequestButton = true;
  }

  @override
  Map<String, dynamic> getStockStatusWithDetails(int stockQuantity) {
    if (stockQuantity <= 0) {
      return {
        'message': 'Out of Stock',
        'color': Colors.red,
        'icon': Icons.error_outline,
        'bgColor': Colors.red.shade50,
      };
    } else if (stockQuantity <= 5) {
      return {
        'message': 'ONLY $stockQuantity LEFT',
        'color': Colors.orange,
        'icon': Icons.warning_amber_rounded,
        'bgColor': Colors.orange.shade50,
      };
    } else if (stockQuantity <= 20) {
      return {
        'message': 'ALMOST SOLD OUT',
        'color': Colors.amber,
        'icon': Icons.timelapse,
        'bgColor': Colors.amber.shade50,
      };
    } else {
      return {
        'message': 'In Stock',
        'color': Colors.green,
        'icon': Icons.check_circle_outline,
        'bgColor': Colors.green.shade50,
      };
    }
  }

  // ==================== دوال طلب المنتج ====================

  @override
  void requestProductWithColorAndSize() {
    Get.defaultDialog(
      title: "Request Product".tr,
      middleText:
      "Do you want to notify the admin that you want this product with color: $selectedColorCode and size: $selectedSizeName?"
          .tr,
      textConfirm: "Yes".tr,
      textCancel: "Cancel".tr,
      onConfirm: () {
        _sendRequestToAdmin();
        Get.back();
      },
    );
  }

  void _sendRequestToAdmin() async {
    var response = await missingItemData.postData(
      myServices.sharedPref.getString("userid")!,
      dataDetails.first.itemsId.toString(),
      selectedColorCode.toString(),
      selectedSizeName.toString(),
    );

    if (response['status'] == 'success') {
      customShowTopSnackBar(
        "Request Sent",
        "Your request has been sent to the admin.",
        "OK",
        Icons.notifications,
            () {},
      );
    } else {
      customShowTopSnackBar(
        "Request Failed",
        "Failed to send your request. Please try again later.",
        "OK",
        Icons.error,
            () {},
      );
    }
  }

  // ==================== دوال السلة ====================

  @override
  Future<void> addToCart(String itemsId) async {
    if (!isProductAvailable) {
      _showNotAvailableSnackBar();
      return;
    }

    statusRequest = StatusRequest.loading;
    update();

    var response = await cartData.addCart(
      myServices.sharedPref.getString("userid")!,
      itemsId,
    );

    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest && response['status'] == "success") {
      await cartControllerImp.viewCart();
      _showAddToCartSuccessSnackBar();
    } else {
      statusRequest = StatusRequest.failure;
    }

    update();
  }

  Future<void> setCartQuantity(String itemsId, String quantity) async {
    if (!isProductAvailable) {
      _showNotAvailableSnackBar();
      return;
    }

    String mainItemsId = dataDetails.first.itemsId?.toString() ?? itemsId;
    String supItemsId = getCurrentSubImageId();

    var response = await cartData.setCartQuantity(
      myServices.sharedPref.getString("userid")!,
      mainItemsId,
      quantity,
      supItemsId,
    );

    if (response['status'] == 'success') {
      _showAddToCartSuccessSnackBar();
    }

    cartControllerImp.viewCart().then((_) {
      countItems = 0;
      update();
    });
  }

  String getCurrentSubImageId() {
    if (currentImageIndex == 0) return "0";

    if (dataDetails.isNotEmpty &&
        dataDetails.first.images != null &&
        (currentImageIndex - 1) < dataDetails.first.images!.length) {
      return dataDetails.first.images![currentImageIndex - 1].imageId?.toString() ?? "0";
    }

    return "0";
  }

  void _showNotAvailableSnackBar() {
    customShowTopSnackBar(
      "Product Not Available".tr,
      availabilityMessage,
      "OK".tr,
      Icons.error,
          () {},
    );
  }

  void _showAddToCartSuccessSnackBar() {
    customShowTopSnackBar(
      "AddToCart".tr,
      "${"TheProductHasBeenAddedToTheCart".tr} $countItems",
      "Cart".tr,
      Icons.shopping_cart_outlined,
          () => Get.toNamed(AppRoutes.cart),
    );
  }

  @override
  void saveCartQuantity() {
    // يمكن تنفيذها لاحقاً إذا لزم الأمر
  }

  // ==================== دوال الأسعار ====================

  double getCurrentPrice() {
    if (dataDetails.isEmpty) return 0.0;

    if (currentImageIndex == 0) {
      double price = double.tryParse(dataDetails.first.itemsPrice ?? "0") ?? 0.0;
      int discount = dataDetails.first.itemsDiscount ?? 0;
      return discount > 0 ? price * (1 - discount / 100) : price;
    }

    if (dataDetails.first.images != null &&
        (currentImageIndex - 1) < dataDetails.first.images!.length) {
      var image = dataDetails.first.images![currentImageIndex - 1];
      double price = double.tryParse(image.imagePrice ?? "0") ?? 0.0;
      int discount = image.imageDiscount ?? 0;
      return discount > 0 ? price * (1 - discount / 100) : price;
    }

    return 0.0;
  }

  double getOriginalPrice() {
    if (dataDetails.isEmpty) return 0.0;

    if (currentImageIndex == 0) {
      return double.tryParse(dataDetails.first.itemsPrice ?? "0") ?? 0.0;
    }

    if (dataDetails.first.images != null &&
        (currentImageIndex - 1) < dataDetails.first.images!.length) {
      return double.tryParse(
          dataDetails.first.images![currentImageIndex - 1].imagePrice ?? "0"
      ) ?? 0.0;
    }

    return 0.0;
  }

  int getCurrentDiscount() {
    if (dataDetails.isEmpty) return 0;

    try {
      if (currentImageIndex == 0) {
        return dataDetails.first.itemsDiscount ?? 0;
      }

      if (dataDetails.first.images != null &&
          (currentImageIndex - 1) < dataDetails.first.images!.length) {
        return dataDetails.first.images![currentImageIndex - 1].imageDiscount ?? 0;
      }
    } catch (e) {
      print("Error in getCurrentDiscount: $e");
    }

    return 0;
  }

  double getSavedAmount() => getOriginalPrice() - getCurrentPrice();
  bool hasDiscount() => getCurrentDiscount() > 0;

  String getPriceLabel() {
    if (currentImageIndex == 0) return "Main Product Price";

    if (dataDetails.first.images != null &&
        (currentImageIndex - 1) < dataDetails.first.images!.length) {
      return dataDetails.first.images![currentImageIndex - 1].imageNameEn ?? "Special Price";
    }

    return "Price";
  }

  // ==================== دوال الخصائص الإضافية ====================

  @override
  void toggleFeature(int featureId) {
    String featureIdStr = featureId.toString();

    if (selectedFeatures.contains(featureIdStr)) {
      selectedFeatures.remove(featureIdStr);
    } else {
      selectedFeatures.add(featureIdStr);
    }

    _printSelectedFeatures();
    update();
  }

  @override
  void clearAllFeatures() {
    selectedFeatures.clear();
    print("🗑️ تم حذف جميع الخصائص المختارة");
    update();
  }

  @override
  bool isFeatureSelected(String featureId) => selectedFeatures.contains(featureId);

  @override
  int getSelectedFeaturesCount() => selectedFeatures.length;

  String _getFeatureNameById(int featureId) {
    if (dataDetails.isEmpty || dataDetails.first.features == null) {
      return "Unknown Feature";
    }

    try {
      final feature = dataDetails.first.features!.firstWhere(
            (f) => f.idFeatures == featureId,
        orElse: () => Features(),
      );
      return feature.nameFeatures ?? "Unknown Feature";
    } catch (e) {
      return "Unknown Feature";
    }
  }

  void _printSelectedFeatures() {
    print("\n" + "=" * 50);
    print("📋 الخصائص الإضافية المختارة (${selectedFeatures.length}):");

    if (selectedFeatures.isEmpty) {
      print("   لا توجد خصائص مختارة");
    } else {
      for (int i = 0; i < selectedFeatures.length; i++) {
        final featureId = selectedFeatures.elementAt(i);
        try {
          int id = int.parse(featureId);
          final feature = dataDetails.first.features!.firstWhere(
                (f) => f.idFeatures == id,
            orElse: () => Features(),
          );
          print("   ${i + 1}. ${feature.nameFeatures ?? 'Unknown'} - \$${feature.price ?? 0}");
        } catch (e) {
          print("   ${i + 1}. Unknown Feature ($featureId)");
        }
      }
    }
    print("=" * 50 + "\n");
  }

  // ==================== دوال العرض المساعدة ====================

  Color getCurrentColor() {
    if (selectedColorCode != null && selectedColorCode!.isNotEmpty) {
      try {
        return parseColor(selectedColorCode!);
      } catch (e) {
        print("Error parsing color: $e");
      }
    }
    return Colors.grey;
  }

  String getCurrentColorName() {
    if (selectedColorCode != null) {
      if (selectedColorCode!.contains('0x') || selectedColorCode!.contains('#')) {
        return _getColorNameFromHex(selectedColorCode!);
      }
      return selectedColorCode!;
    }

    if (currentImageIndex == 0) {
      return mainProductColorName ?? "Default Color";
    }

    return "Color ${currentImageIndex + 1}";
  }

  String getCurrentSize() => selectedSizeName ?? "Default Size";
}