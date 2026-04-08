import 'package:e_commerce/controller/change_password.dart';
import 'package:e_commerce/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background2,
      body: GetBuilder<ChangePasswordControllerImp>(
        builder: (controller) => Stack(
          children: [
            // خلفية متدرجة
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColor.background,
                      AppColor.background2,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),

            // المحتوى الرئيسي
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // زر الرجوع
                    _buildBackButton(controller),
                    const SizedBox(height: 30),

                    // العنوان
                    _buildTitle(),
                    const SizedBox(height: 10),

                    // وصف العملية
                    _buildDescription(),
                    const SizedBox(height: 40),

                    // مؤشر الخطوات
                    _buildStepIndicator(controller),
                    const SizedBox(height: 40),

                    // المحتوى الديناميكي حسب الخطوة
                    _buildStepContent(controller),

                    const SizedBox(height: 30),

                    // زر الإجراء
                    _buildActionButton(controller),
                  ],
                ),
              ),
            ),

            // مؤشر التحميل
            if (controller.isLoading)
              Container(
                color: Colors.black.withOpacity(0.5),
                child: const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(AppColor.primaryColor),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackButton(ChangePasswordControllerImp controller) {
    return IconButton(
      onPressed: () => controller.goBack(),
      icon: Container(
        decoration: AppColor.cardDecoration,
        padding: const EdgeInsets.all(8),
        child: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: AppColor.primaryColor,
          size: 20,
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      'تغيير كلمة المرور',
      style: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: AppColor.textPrimary,
        fontFamily: 'Tajawal',
      ),
    );
  }

  Widget _buildDescription() {
    return Text(
      'أدخل بريدك الإلكتروني للحصول على رمز التحقق',
      style: TextStyle(
        fontSize: 16,
        color: AppColor.textSecondary,
        fontFamily: 'Tajawal',
      ),
    );
  }

  Widget _buildStepIndicator(ChangePasswordControllerImp controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildStepCircle(1, 'البريد', controller.currentStep >= 1),
        _buildStepDivider(controller.currentStep >= 2),
        _buildStepCircle(2, 'الرمز', controller.currentStep >= 2),
        _buildStepDivider(controller.currentStep >= 3),
        _buildStepCircle(3, 'كلمة المرور', controller.currentStep >= 3),
      ],
    );
  }

  Widget _buildStepCircle(int step, String label, bool isActive) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: isActive
                ? const LinearGradient(
              colors: [AppColor.primaryColor, AppColor.primaryDark],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )
                : null,
            color: isActive ? null : AppColor.lightGray,
            border: Border.all(
              color: isActive ? AppColor.primaryColor : AppColor.dividerColor,
              width: 2,
            ),
          ),
          child: Center(
            child: Text(
              '$step',
              style: TextStyle(
                color: isActive ? Colors.white : AppColor.textLight,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: isActive ? AppColor.primaryColor : AppColor.textLight,
            fontSize: 12,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildStepDivider(bool isActive) {
    return Container(
      width: 40,
      height: 2,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        gradient: isActive
            ? const LinearGradient(
          colors: [AppColor.primaryColor, AppColor.primaryDark],
        )
            : null,
        color: isActive ? null : AppColor.lightGray,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildStepContent(ChangePasswordControllerImp controller) {
    switch (controller.currentStep) {
      case 1:
        return _buildEmailStep(controller);
      case 2:
        return _buildCodeStep(controller);
      case 3:
        return _buildPasswordStep(controller);
      default:
        return Container();
    }
  }

  Widget _buildEmailStep(ChangePasswordControllerImp controller) {
    return Container(
      decoration: AppColor.cardDecoration,
      padding: const EdgeInsets.all(24),
      child: Form(
        key: controller.emailFormKey,
        child: Column(
          children: [
            // أيقونة البريد
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [AppColor.coldOrange, AppColor.coldOrange2],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.accentColor.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                Icons.email_outlined,
                size: 40,
                color: AppColor.primaryColor,
              ),
            ),
            const SizedBox(height: 30),

            // حقل الإيميل
            CustomTextFormAuth(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              mycontroller: controller.emailController,
              valid: (val) {
                if (val!.isEmpty) {
                  return "البريد الإلكتروني مطلوب";
                } else if (!val.contains('@') || !val.contains('.')) {
                  return "البريد الإلكتروني غير صالح";
                }
                return null;
              },
              hinttext: "أدخل بريدك الإلكتروني",
              iconData: Icons.email_rounded,
              labeltext: "البريد الإلكتروني",
              obscureText: false,
              prefixIconColor: AppColor.primaryColor,
              borderColor: AppColor.dividerColor,
              focusedBorderColor: AppColor.primaryColor,
              enabledBorderColor: AppColor.dividerColor,
            ),
            const SizedBox(height: 20),

            // رسالة إرشادية
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColor.coldOrange.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColor.coldOrange),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    color: AppColor.primaryColor,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'سيتم إرسال رمز التحقق إلى بريدك الإلكتروني',
                      style: TextStyle(
                        color: AppColor.textSecondary,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCodeStep(ChangePasswordControllerImp controller) {
    return Container(
      decoration: AppColor.cardDecoration,
      padding: const EdgeInsets.all(24),
      child: Form(
        key: controller.codeFormKey,
        child: Column(
          children: [
            // أيقونة التحقق
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [AppColor.infoBlue, Color(0xFF66A3FF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.infoBlue.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                Icons.verified_user_outlined,
                size: 40,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 30),

            // عنوان الخطوة
            Text(
              'أدخل رمز التحقق',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColor.textPrimary,
              ),
            ),
            const SizedBox(height: 8),

            Text(
              'تم إرسال رمز مكون من 5 أرقام إلى',
              style: TextStyle(
                fontSize: 14,
                color: AppColor.textSecondary,
              ),
            ),

            Text(
              controller.emailController.text,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColor.primaryColor,
              ),
            ),
            const SizedBox(height: 30),

            // حقل إدخال الرمز
            Directionality(
              textDirection: TextDirection.ltr,
              child: Pinput(
                length: 5,
                controller: controller.codeController,
                defaultPinTheme: PinTheme(
                  width: 56,
                  height: 56,
                  textStyle: TextStyle(
                    fontSize: 20,
                    color: AppColor.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: AppColor.dividerColor),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                ),
                focusedPinTheme: PinTheme(
                  width: 56,
                  height: 56,
                  textStyle: TextStyle(
                    fontSize: 20,
                    color: AppColor.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: AppColor.primaryColor, width: 2),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.primaryColor.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                ),
                errorPinTheme: PinTheme(
                  width: 56,
                  height: 56,
                  textStyle: TextStyle(
                    fontSize: 20,
                    color: AppColor.errorRed,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: AppColor.errorRed),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.length != 5) {
                    return 'الرجاء إدخال رمز مكون من 6 أرقام';
                  }
                  return null;
                },
                onCompleted: (value) {
                  controller.codeController.text = value;
                },
              ),
            ),
            const SizedBox(height: 20),

            // زر إعادة الإرسال
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'لم تستلم الرمز؟',
                  style: TextStyle(
                    color: AppColor.textLight,
                    fontSize: 14,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    controller.checkEmail();
                  },
                  child: Text(
                    'إعادة الإرسال',
                    style: TextStyle(
                      color: AppColor.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordStep(ChangePasswordControllerImp controller) {
    return Container(
      decoration: AppColor.cardDecoration,
      padding: const EdgeInsets.all(24),
      child: Form(
        key: controller.passwordFormKey,
        child: Column(
          children: [
            // أيقونة كلمة المرور
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [AppColor.successGreen, Color(0xFF66D9A8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.successGreen.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                Icons.lock_reset_outlined,
                size: 40,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 30),

            // عنوان الخطوة
            Text(
              'إنشاء كلمة مرور جديدة',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColor.textPrimary,
              ),
            ),
            const SizedBox(height: 8),

            Text(
              'أدخل كلمة مرور قوية لحسابك',
              style: TextStyle(
                fontSize: 14,
                color: AppColor.textSecondary,
              ),
            ),
            const SizedBox(height: 30),

            // حقل كلمة المرور الجديدة
            CustomTextFormAuth(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.visiblePassword,
              mycontroller: controller.passwordController,
              valid: (val) {
                if (val!.isEmpty) {
                  return "كلمة المرور مطلوبة";
                } else if (val.length < 8) {
                  return "كلمة المرور يجب أن تكون 8 أحرف على الأقل";
                }
                return null;
              },
              hinttext: "أدخل كلمة المرور الجديدة",
              iconData: Icons.lock_outline_rounded,
              labeltext: "كلمة المرور الجديدة",
              obscureText: true,
              prefixIconColor: AppColor.primaryColor,
              borderColor: AppColor.dividerColor,
              focusedBorderColor: AppColor.primaryColor,
              enabledBorderColor: AppColor.dividerColor,
            ),
            const SizedBox(height: 20),

            // حقل تأكيد كلمة المرور
            CustomTextFormAuth(
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.visiblePassword,
              mycontroller: controller.confirmPasswordController,
              valid: (val) {
                if (val!.isEmpty) {
                  return "تأكيد كلمة المرور مطلوب";
                } else if (val.length < 8) {
                  return "كلمة المرور يجب أن تكون 8 أحرف على الأقل";
                }
                return null;
              },
              hinttext: "أعد إدخال كلمة المرور الجديدة",
              iconData: Icons.lock_reset_rounded,
              labeltext: "تأكيد كلمة المرور",
              obscureText: true,
              prefixIconColor: AppColor.primaryColor,
              borderColor: AppColor.dividerColor,
              focusedBorderColor: AppColor.primaryColor,
              enabledBorderColor: AppColor.dividerColor,
            ),
            const SizedBox(height: 20),

            // مؤشر قوة كلمة المرور
            _buildPasswordStrengthIndicator(controller.passwordController.text),
            const SizedBox(height: 10),

            // نصائح لكلمة المرور
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColor.lightGray.withOpacity(0.5),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColor.dividerColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'نصائح لكلمة مرور قوية:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColor.textPrimary,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildPasswordTip('8 أحرف على الأقل'),
                  _buildPasswordTip('حرف كبير واحد على الأقل'),
                  _buildPasswordTip('رقم واحد على الأقل'),
                  _buildPasswordTip('رمز خاص واحد على الأقل'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordStrengthIndicator(String password) {
    int strength = 0;
    if (password.length >= 8) strength++;
    if (password.contains(RegExp(r'[A-Z]'))) strength++;
    if (password.contains(RegExp(r'[0-9]'))) strength++;
    if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) strength++;

    String text;
    Color color;

    switch (strength) {
      case 0:
        text = 'ضعيفة';
        color = AppColor.errorRed;
        break;
      case 1:
        text = 'ضعيفة';
        color = AppColor.errorRed;
        break;
      case 2:
        text = 'متوسطة';
        color = AppColor.warningYellow;
        break;
      case 3:
        text = 'جيدة';
        color = Color(0xFF4CD964);
        break;
      case 4:
        text = 'قوية جداً';
        color = AppColor.successGreen;
        break;
      default:
        text = 'ضعيفة';
        color = AppColor.errorRed;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'قوة كلمة المرور: $text',
          style: TextStyle(
            fontSize: 14,
            color: AppColor.textSecondary,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          height: 6,
          decoration: BoxDecoration(
            color: AppColor.lightGray,
            borderRadius: BorderRadius.circular(3),
          ),
          child: Row(
            children: [
              Expanded(
                flex: strength,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        color.withOpacity(0.7),
                        color,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
              Expanded(
                flex: 4 - strength,
                child: Container(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTip(String tip) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Icon(
            Icons.check_circle_outline_rounded,
            color: AppColor.successGreen,
            size: 16,
          ),
          const SizedBox(width: 8),
          Text(
            tip,
            style: TextStyle(
              color: AppColor.textSecondary,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(ChangePasswordControllerImp controller) {
    String buttonText;
    VoidCallback? onPressed;

    switch (controller.currentStep) {
      case 1:
        buttonText = 'إرسال رمز التحقق';
        onPressed = controller.checkEmail;
        break;
      case 2:
        buttonText = 'تحقق من الرمز';
        onPressed = controller.verifyCode;
        break;
      case 3:
        buttonText = 'تغيير كلمة المرور';
        onPressed = controller.resetPassword;
        break;
      default:
        buttonText = 'التالي';
    }

    return SizedBox(
      width: double.infinity,
      child: CustomButtonAuth(
        text: buttonText,
        onPressed: onPressed,
        backgroundColor: AppColor.primaryColor,
        foregroundColor: Colors.white,
        borderRadius: 12,
        elevation: 4,
        padding: const EdgeInsets.symmetric(vertical: 16),
        isLoading: controller.isLoading,
      ),
    );
  }
}

class CustomTextFormAuth extends StatelessWidget {
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final TextEditingController? mycontroller;
  final String? Function(String?)? valid;
  final String hinttext;
  final String labeltext;
  final IconData? iconData;
  final IconData? suffixIcon;
  final bool obscureText;
  final void Function()? onTapIcon;
  final Color? prefixIconColor;
  final Color? suffixIconColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? enabledBorderColor;
  final Color? errorBorderColor;
  final Color? fillColor;
  final bool filled;
  final EdgeInsetsGeometry? contentPadding;
  final double borderRadius;
  final bool readOnly;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final FocusNode? focusNode;
  final int? maxLines;
  final TextAlign textAlign;
  final String? helperText;

  const CustomTextFormAuth({
    Key? key,
    this.textInputAction,
    this.keyboardType,
    this.mycontroller,
    this.valid,
    required this.hinttext,
    required this.labeltext,
    this.iconData,
    this.suffixIcon,
    this.obscureText = false,
    this.onTapIcon,
    this.prefixIconColor,
    this.suffixIconColor,
    this.borderColor,
    this.focusedBorderColor,
    this.enabledBorderColor,
    this.errorBorderColor,
    this.fillColor,
    this.filled = true,
    this.contentPadding,
    this.borderRadius = 12,
    this.readOnly = false,
    this.onChanged,
    this.onTap,
    this.focusNode,
    this.maxLines = 1,
    this.textAlign = TextAlign.start,
    this.helperText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Padding(
          padding: const EdgeInsets.only(bottom: 8, right: 4),
          child: Text(
            labeltext,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColor.textPrimary,
              fontFamily: 'Tajawal',
            ),
          ),
        ),

        // Text Field
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: TextFormField(
            controller: mycontroller,
            validator: valid,
            obscureText: obscureText,
            textInputAction: textInputAction ?? TextInputAction.next,
            keyboardType: keyboardType,
            readOnly: readOnly,
            onChanged: onChanged,
            onTap: onTap,
            focusNode: focusNode,
            maxLines: maxLines,
            textAlign: textAlign,
            style: TextStyle(
              color: AppColor.textPrimary,
              fontSize: 16,
              fontFamily: 'Tajawal',
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              filled: filled,
              fillColor: fillColor ?? Colors.white,
              hintText: hinttext,
              hintStyle: TextStyle(
                color: AppColor.textLight.withOpacity(0.7),
                fontSize: 15,
                fontFamily: 'Tajawal',
              ),
              helperText: helperText,
              helperStyle: TextStyle(
                color: AppColor.textLight,
                fontSize: 12,
              ),
              prefixIcon: iconData != null
                  ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Icon(
                  iconData,
                  color: prefixIconColor ?? AppColor.primaryColor,
                  size: 22,
                ),
              )
                  : null,
              suffixIcon: suffixIcon != null
                  ? GestureDetector(
                onTap: onTapIcon,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Icon(
                    suffixIcon,
                    color: suffixIconColor ?? AppColor.textLight,
                    size: 22,
                  ),
                ),
              )
                  : null,
              contentPadding: contentPadding ??
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(
                  color: borderColor ?? AppColor.dividerColor,
                  width: 1.5,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(
                  color: enabledBorderColor ?? AppColor.dividerColor,
                  width: 1.5,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(
                  color: focusedBorderColor ?? AppColor.primaryColor,
                  width: 2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(
                  color: errorBorderColor ?? AppColor.errorRed,
                  width: 1.5,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(
                  color: errorBorderColor ?? AppColor.errorRed,
                  width: 2,
                ),
              ),
              errorStyle: TextStyle(
                color: AppColor.errorRed,
                fontSize: 12,
                fontFamily: 'Tajawal',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),

        // Spacing
        const SizedBox(height: 4),
      ],
    );
  }
}

// CustomButtonAuth Widget
class CustomButtonAuth extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color? borderColor;
  final double borderRadius;
  final double elevation;
  final EdgeInsetsGeometry padding;
  final double? width;
  final double? height;
  final bool isLoading;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Color? iconColor;
  final double fontSize;
  final FontWeight fontWeight;
  final Gradient? gradient;

  const CustomButtonAuth({
    Key? key,
    required this.text,
    this.onPressed,
    this.backgroundColor = AppColor.primaryColor,
    this.foregroundColor = Colors.white,
    this.borderColor,
    this.borderRadius = 12,
    this.elevation = 4,
    this.padding = const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
    this.width,
    this.height,
    this.isLoading = false,
    this.prefixIcon,
    this.suffixIcon,
    this.iconColor,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w600,
    this.gradient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          if (elevation > 0)
            BoxShadow(
              color: backgroundColor.withOpacity(0.3),
              blurRadius: elevation * 2,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          disabledBackgroundColor: backgroundColor.withOpacity(0.6),
          disabledForegroundColor: foregroundColor.withOpacity(0.8),
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: borderColor != null
                ? BorderSide(color: borderColor!, width: 2)
                : BorderSide.none,
          ),
          elevation: 0,
          shadowColor: Colors.transparent,
          textStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            fontFamily: 'Tajawal',
            letterSpacing: 0.5,
          ),
        ),
        child: isLoading
            ? SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            strokeWidth: 3,
            valueColor: AlwaysStoppedAnimation<Color>(foregroundColor),
          ),
        )
            : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (prefixIcon != null)
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Icon(
                  prefixIcon,
                  size: fontSize + 4,
                  color: iconColor ?? foregroundColor,
                ),
              ),
            Expanded(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                  color: foregroundColor,
                  fontFamily: 'Tajawal',
                ),
              ),
            ),
            if (suffixIcon != null)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Icon(
                  suffixIcon,
                  size: fontSize + 4,
                  color: iconColor ?? foregroundColor,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// Loading Overlay Widget
class LoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget child;
  final Color overlayColor;
  final String? message;

  const LoadingOverlay({
    Key? key,
    required this.isLoading,
    required this.child,
    this.overlayColor = const Color(0x80000000),
    this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Container(
            color: overlayColor,
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(
                      strokeWidth: 3,
                      valueColor: AlwaysStoppedAnimation<Color>(AppColor.primaryColor),
                    ),
                    if (message != null) ...[
                      const SizedBox(height: 16),
                      Text(
                        message!,
                        style: TextStyle(
                          color: AppColor.textPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}