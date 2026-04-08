import 'package:e_commerce/core/class/statusRequest.dart';
import 'package:e_commerce/core/constant/color.dart';
import 'package:e_commerce/core/constant/routesname.dart';
import 'package:e_commerce/core/serveces/services.dart';
import 'package:e_commerce/data/datasource/remote/rating_data.dart';
import 'package:e_commerce/view/widget/ratingDialog/rating_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RatingController extends GetxController {
  StatusRequest statusRequest = StatusRequest.none;
  RatingData ratingData = RatingData(Get.find());
  MyServices myServices = Get.find();

  List<Map<String, dynamic>> itemsToRate = [];
  int currentIndex = 0;
  List<int> ratedItems = [];
  BuildContext? _currentContext;

  @override
  void onInit() {
    super.onInit();
    print('RatingController initialized');
  }

  void setItemsToRate(List<Map<String, dynamic>> products, BuildContext context) {
    print('Setting items to rate: ${products.length} products');
    itemsToRate = List.from(products);
    currentIndex = 0;
    ratedItems.clear();
    _currentContext = context;
    update();
  }

  Future<void> startRatingFlow(BuildContext context) async {
    print('Starting rating flow with ${itemsToRate.length} items');

    if (itemsToRate.isEmpty) {
      print('No items to rate, completing flow');
      await completeRating();
      return;
    }

    _currentContext = context;
    await _showRatingDialog();
  }

  Future<void> _showRatingDialog() async {
    // تأكد من وجود context
    if (_currentContext == null) {
      print('ERROR: No context available for showing rating dialog');
      return;
    }

    // تأكد من أن الدايلوج الحالي مغلق قبل عرض التالي
    if (Navigator.canPop(_currentContext!)) {
      Navigator.pop(_currentContext!);
      await Future.delayed(Duration(milliseconds: 300));
    }

    if (currentIndex >= itemsToRate.length) {
      print('All items rated, completing flow');
      await completeRating();
      return;
    }

    final product = itemsToRate[currentIndex];
    final productIdStr = product['id']?.toString() ?? '';
    final productId = int.tryParse(productIdStr) ?? 0;
    final productName = Get.locale?.languageCode == 'ar'
        ? product['nameAr']
        : product['nameEn'];


    showDialog(
      context: _currentContext!,
      barrierDismissible: false,
      builder: (context) => RatingDialog(
        itemId: productIdStr,
        itemName: productName ?? 'Product',
        itemImage: null,
        onRatingSubmitted: (rating) async {
          print('Rating submitted: $rating for product $productId');
          bool success = await _submitRating(productId, rating.toInt());
          if (success) {
            await nextProduct();
          }
          return success;
        },
        onSkipRating: () async {
          print('Rating skipped for product $productId');
          await _skipRating(productId);
          await nextProduct();
        },
        isSkippable: true,
      ),
    );
  }

  // أصلح الدالة لتأخذ int
  Future<bool> submitRatingToServer(int itemId, double rating, BuildContext context) async {
    try {
      print('تقييم المنتج $itemId بتقييم $rating');
      var response = await ratingData.postData(
        itemId.toString(), // تحويل int إلى String
        rating.toString(),
        myServices.sharedPref.getString("userid")!,
      );

      if (response['status'] == 'success') {
        ratedItems.add(itemId);
        return true;
      } else {
        Get.snackbar(
          'خطأ ❌',
          response['message'] ?? 'فشل إرسال التقييم',
          backgroundColor: AppColor.hotRed,
          colorText: Colors.white,
        );
        return false;
      }
    } catch (e) {
      print('خطأ في إرسال التقييم: $e');
      Get.snackbar(
        'خطأ ❌',
        'فشل في إرسال التقييم: $e',
        backgroundColor: AppColor.hotRed,
        colorText: Colors.white,
      );
      return false;
    }
  }

  Future<void> nextProduct() async {
    print('Moving to next product');

    currentIndex++;
    update();

    if (currentIndex < itemsToRate.length) {
      await Future.delayed(Duration(milliseconds: 500));
      await _showRatingDialog();
    } else {
      await completeRating();
    }
  }

  Future<bool> _submitRating(int productId, int rating) async {
    print('Submitting rating for product $productId: $rating stars');

    try {
      String userId = myServices.sharedPref.getString("userid") ?? '';

      if (userId.isEmpty) {
        print('ERROR: User ID is empty!');
        Get.snackbar(
          'Error ❌',
          'User not logged in',
          backgroundColor: AppColor.hotRed,
          colorText: Colors.white,
        );
        return false;
      }

      print('Calling ratingData.postData with: itemId=$productId, rating=$rating, userId=$userId');

      var response = await ratingData.postData(
        productId.toString(),
        rating.toString(),
        userId,
      );

      print('Server response: $response');

      if (response['status'] == 'success') {
        print('Rating submitted successfully');
        ratedItems.add(productId);
        return true;
      } else {
        print('Server returned error: ${response['message']}');
        Get.snackbar(
          'Error ❌',
          response['message'] ?? 'Failed to submit rating',
          backgroundColor: AppColor.hotRed,
          colorText: Colors.white,
        );
        return false;
      }
    } catch (e, stackTrace) {
      print('EXCEPTION in _submitRating: $e');
      print('Stack trace: $stackTrace');
      Get.snackbar(
        'Error ❌',
        'Failed to submit rating: $e',
        backgroundColor: AppColor.hotRed,
        colorText: Colors.white,
      );
      return false;
    }
  }

  Future<void> _skipRating(int productId) async {
    print('Auto-rating product $productId with 3 stars');

    try {
      String userId = myServices.sharedPref.getString("userid") ?? '';

      if (userId.isEmpty) {
        print('ERROR: User ID is empty for auto-rating!');
        return;
      }

      var response = await ratingData.postData(
        productId.toString(),
        '3',
        userId,
      );

      print('Auto-rating response: $response');

      if (response['status'] == 'success') {
        ratedItems.add(productId);
      } else {
        print('Auto-rating failed: ${response['message']}');
      }
    } catch (e) {
      print('Exception in auto-rating: $e');
    }
  }

  Future<void> completeRating() async {
    print('Rating completed. Total rated: ${ratedItems.length}');

    // أولاً، أغلق أي دايلوج مفتوح
    if (_currentContext != null && Navigator.canPop(_currentContext!)) {
      Navigator.pop(_currentContext!);
      await Future.delayed(Duration(milliseconds: 300));
    }

    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Icon(
          Icons.check_circle,
          color: Colors.green,
          size: 60,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'شكراً لك!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'تم تقييم ${ratedItems.length} منتج(ات)',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
        actions: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                Get.back();
                Get.offAllNamed(AppRoutes.homepage);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              ),
              child: Text(
                'متابعة التسوق',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  bool get hasItemsToRate => itemsToRate.isNotEmpty;
}