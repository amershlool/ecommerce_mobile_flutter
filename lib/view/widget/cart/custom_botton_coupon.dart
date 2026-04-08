// custom_button_coupon.dart
import 'package:e_commerce/data/model/coupon_model.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/core/constant/color.dart';

class CustomButtonCoupon extends StatelessWidget {
  final TextEditingController couponController;
  final VoidCallback onPressed;
  final VoidCallback? onRemove;
  final CouponModel? appliedCoupon;
  final String? hintText;
  final bool isLoading;
  final String? errorMessage;

  const CustomButtonCoupon({
    Key? key,
    required this.couponController,
    required this.onPressed,
    this.onRemove,
    this.appliedCoupon,
    this.hintText = "Enter coupon code",
    this.isLoading = false,
    this.errorMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // الحاوية الرئيسية
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: appliedCoupon != null
                  ? AppColor.successGreen.withOpacity(0.3)
                  : AppColor.lightGray,
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              // الصف العلوي: حقل النص والزر
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    // أيقونة الكوبون
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: appliedCoupon != null
                            ? AppColor.successGreen.withOpacity(0.1)
                            : AppColor.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        appliedCoupon != null
                            ? Icons.local_offer_rounded
                            : Icons.confirmation_number_outlined,
                        color: appliedCoupon != null
                            ? AppColor.successGreen
                            : AppColor.primaryColor,
                        size: 20,
                      ),
                    ),

                    const SizedBox(width: 12),

                    // حقل النص
                    Expanded(
                      child: TextField(
                        controller: couponController,
                        enabled: appliedCoupon == null && !isLoading,
                        style: TextStyle(
                          fontSize: 14,
                          color: appliedCoupon != null
                              ? AppColor.successGreen
                              : AppColor.textPrimary,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                          hintText: hintText,
                          hintStyle: TextStyle(
                            color: AppColor.textLight,
                            fontSize: 14,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                          isDense: true,
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    // زر Apply
                    Container(
                      width: 80,
                      height: 36,
                      decoration: BoxDecoration(
                        gradient: appliedCoupon != null
                            ? LinearGradient(
                          colors: [
                            AppColor.successGreen,
                            Color(0xFF2E7D32),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                            : AppColor.buttonGradient,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: (appliedCoupon != null
                                ? AppColor.successGreen
                                : AppColor.primaryColor)
                                .withOpacity(0.3),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(8),
                          onTap: appliedCoupon != null || isLoading
                              ? null
                              : onPressed,
                          child: Center(
                            child: isLoading
                                ? SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                                : Text(
                              appliedCoupon != null ? "Applied" : "Apply",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // عرض تفاصيل الكوبون المطبق
              if (appliedCoupon != null) ...[
                Divider(
                  height: 1,
                  thickness: 0.5,
                  color: AppColor.lightGray,
                  indent: 12,
                  endIndent: 12,
                ),
                _buildCouponDetails(appliedCoupon!),
              ],
            ],
          ),
        ),

        // رسالة الخطأ (إذا كان هناك خطأ)
        if (errorMessage != null && errorMessage!.isNotEmpty) ...[
          const SizedBox(height: 8),
          _buildErrorMessage(),
        ],
      ],
    );
  }

  Widget _buildCouponDetails(CouponModel coupon) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          // رمز الخصم
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColor.successGreen.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: AppColor.successGreen.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Text(
              "${coupon.couponDiscount}" ,
              style: TextStyle(
                color: AppColor.successGreen,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(width: 12),

          // تفاصيل الكوبون
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  coupon.couponName ?? "Coupon",
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColor.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 12,
                      color: AppColor.textLight,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "Expires: ${coupon.couponExpiredate}",
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColor.textLight,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // زر الإزالة
          if (onRemove != null)
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppColor.errorRed.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Material(
                color: Colors.transparent,
                child: IconButton(
                  onPressed: onRemove,
                  icon: Icon(
                    Icons.close,
                    size: 16,
                    color: AppColor.errorRed,
                  ),
                  padding: EdgeInsets.zero,
                  splashRadius: 16,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildErrorMessage() {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: AppColor.errorRed.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            Icons.error_outline,
            size: 14,
            color: AppColor.errorRed,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            errorMessage!,
            style: TextStyle(
              color: AppColor.errorRed,
              fontSize: 12,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}