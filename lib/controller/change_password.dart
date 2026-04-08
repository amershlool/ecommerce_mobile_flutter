import 'package:e_commerce/core/class/statusRequest.dart';
import 'package:e_commerce/core/constant/color.dart';
import 'package:e_commerce/core/constant/routesname.dart';
import 'package:e_commerce/core/function/handlingdatacontroller.dart';
import 'package:e_commerce/data/datasource/remote/forgetpassword/checkemail.dart';
import 'package:e_commerce/data/datasource/remote/forgetpassword/resetpassword.dart';
import 'package:e_commerce/data/datasource/remote/forgetpassword/verifycode.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class ChangePasswordController extends GetxController {
  checkEmail();
  verifyCode();
  resetPassword();
  void resetController(); // دالة جديدة لإعادة تعيين كل شيء
}

class ChangePasswordControllerImp extends ChangePasswordController {
  // البيانات
  late CheckemailData checkemailData;
  late VerifyCodeForGetPasswordData verifyCodeForGetPasswordData;
  late ResetPasswordData resetPasswordData;

  // حالة الطلب
  StatusRequest statusRequest = StatusRequest.none;

  // متغيرات واجهة المستخدم
  int currentStep = 1; // 1: البريد, 2: الرمز, 3: كلمة المرور
  bool isLoading = false;
  bool isEmailVerified = false;
  bool isCodeVerified = false;
  String? errorMessage;

  // متغيرات الإدخال
  TextEditingController emailController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  // متغيرات التحقق
  GlobalKey<FormState> emailFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> codeFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> passwordFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    // أولاً: إعادة تعيين كل شيء
    resetController();

    // ثانياً: تهيئة الـ dependencies
    checkemailData = CheckemailData(Get.find());
    verifyCodeForGetPasswordData = VerifyCodeForGetPasswordData(Get.find());
    resetPasswordData = ResetPasswordData(Get.find());

    super.onInit();
  }

  @override
  void onClose() {
    // تنظيف الموارد عند إغلاق الـ controller
    resetController();
    super.onClose();
  }

  // دالة لإعادة تعيين كل شيء
  @override
  void resetController() {
    // 1. تنظيف جميع النصوص
    emailController.clear();
    codeController.clear();
    passwordController.clear();
    confirmPasswordController.clear();

    // 2. إعادة تعيين جميع المتغيرات إلى القيم الافتراضية
    currentStep = 1;
    isLoading = false;
    isEmailVerified = false;
    isCodeVerified = false;
    errorMessage = null;
    statusRequest = StatusRequest.none;

    // 3. إعادة إنشاء Form Keys لضمان بداية جديدة
    emailFormKey = GlobalKey<FormState>();
    codeFormKey = GlobalKey<FormState>();
    passwordFormKey = GlobalKey<FormState>();

    // 4. تحديث الواجهة إذا كان الـ controller مسجلاً
    if (Get.isRegistered<ChangePasswordControllerImp>()) {
      update();
    }
  }

  @override
  checkEmail() async {
    // إعادة تعيين رسالة الخطأ
    errorMessage = null;

    if (!emailFormKey.currentState!.validate()) return;

    isLoading = true;
    statusRequest = StatusRequest.loading;
    update();

    try {
      var response = await checkemailData.postData(emailController.text.trim());

      statusRequest = handlingData(response);

      if (statusRequest == StatusRequest.success) {
        Map<String, dynamic> responseData = response as Map<String, dynamic>;

        if (responseData['status'] == 'success') {
          // حالة النجاح
          errorMessage = null;
          currentStep = 2;
          isEmailVerified = true;

          // إيقاف التحميل أولاً
          isLoading = false;
          update();

          // ثم إظهار رسالة النجاح
          Get.snackbar(
            'تم الإرسال',
            'تم إرسال رمز التحقق إلى بريدك الإلكتروني',
            backgroundColor: AppColor.successGreen,
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
            duration: const Duration(seconds: 3),
          );
        } else {
          // حالة الفشل - البريد غير موجود
          errorMessage = 'البريد الإلكتروني غير مسجل في النظام. الرجاء التأكد من صحة البريد';

          // إيقاف التحميل أولاً
          isLoading = false;
          update();

          // ثم إظهار رسالة الخطأ
          Get.snackbar(
            'خطأ',
            errorMessage!,
            backgroundColor: AppColor.errorRed,
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
            duration: const Duration(seconds: 3),
          );
        }
      } else {
        // حالة فشل الاتصال
        errorMessage = 'حدث خطأ في الاتصال بالخادم. الرجاء التحقق من اتصال الإنترنت';
        statusRequest = StatusRequest.failure;

        // إيقاف التحميل
        isLoading = false;
        update();

        Get.snackbar(
          'خطأ',
          errorMessage!,
          backgroundColor: AppColor.errorRed,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      // حالة الخطأ غير المتوقع
      errorMessage = 'حدث خطأ غير متوقع';

      // إيقاف التحميل
      isLoading = false;
      update();

      Get.snackbar(
        'خطأ',
        errorMessage!,
        backgroundColor: AppColor.errorRed,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
      );
    }
  }

  @override
  verifyCode() async {
    if (!codeFormKey.currentState!.validate()) return;

    isLoading = true;
    statusRequest = StatusRequest.loading;
    update();

    try {
      var response = await verifyCodeForGetPasswordData.postData(
          emailController.text.trim(),
          codeController.text.trim());

      statusRequest = handlingData(response);

      if (statusRequest == StatusRequest.success) {
        if ((response as Map<String, dynamic>)['status'] == 'success') {
          errorMessage = null;
          currentStep = 3;
          isCodeVerified = true;

          // إيقاف التحميل أولاً
          isLoading = false;
          update();

          Get.snackbar(
            'تم التحقق',
            'تم التحقق من الرمز بنجاح',
            backgroundColor: AppColor.successGreen,
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
          );
        } else {
          errorMessage = response['message'] ?? 'الرمز غير صحيح';

          // إيقاف التحميل أولاً
          isLoading = false;
          update();

          Get.snackbar(
            'خطأ',
            errorMessage!,
            backgroundColor: AppColor.errorRed,
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
          );
        }
      } else {
        errorMessage = 'حدث خطأ في الاتصال';
        statusRequest = StatusRequest.failure;

        // إيقاف التحميل
        isLoading = false;
        update();

        Get.snackbar(
          'خطأ',
          errorMessage!,
          backgroundColor: AppColor.errorRed,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      errorMessage = 'حدث خطأ غير متوقع';

      // إيقاف التحميل
      isLoading = false;
      update();

      Get.snackbar(
        'خطأ',
        errorMessage!,
        backgroundColor: AppColor.errorRed,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  @override
  resetPassword() async {
    if (!passwordFormKey.currentState!.validate()) return;

    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar(
        'خطأ',
        'كلمات المرور غير متطابقة',
        backgroundColor: AppColor.errorRed,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    isLoading = true;
    statusRequest = StatusRequest.loading;
    update();

    try {
      var response = await resetPasswordData.postData(
          emailController.text.trim(),
          passwordController.text.trim());

      statusRequest = handlingData(response);

      if (statusRequest == StatusRequest.success) {
        if ((response as Map<String, dynamic>)['status'] == 'success') {
          errorMessage = null;

          isLoading = false;
          update();

          Get.snackbar(
            'تم التغيير',
            'تم تغيير كلمة المرور بنجاح',
            backgroundColor: AppColor.successGreen,
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
          );

          await Future.delayed(const Duration(milliseconds: 300));

          resetController();

          // الذهاب إلى الصفحة الرئيسية
          Get.offAllNamed(AppRoutes.homepage);

        } else {
          errorMessage = response['message'] ?? 'فشل تغيير كلمة المرور';

          // إيقاف التحميل
          isLoading = false;
          update();

          Get.snackbar(
            'خطأ',
            errorMessage!,
            backgroundColor: AppColor.errorRed,
            colorText: Colors.white,
          );
        }
      } else {
        errorMessage = 'حدث خطأ في الاتصال';
        statusRequest = StatusRequest.failure;

        // إيقاف التحميل
        isLoading = false;
        update();

        Get.snackbar(
          'خطأ',
          errorMessage!,
          backgroundColor: AppColor.errorRed,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      errorMessage = 'حدث خطأ غير متوقع';

      // إيقاف التحميل
      isLoading = false;
      update();

      Get.snackbar(
        'خطأ',
        errorMessage!,
        backgroundColor: AppColor.errorRed,
        colorText: Colors.white,
      );
    }
  }

  void goBack() {
    if (currentStep > 1) {
      currentStep--;
      update();
    } else {
      Get.back();
    }
  }

  void clearAll() {
    resetController();
  }
}