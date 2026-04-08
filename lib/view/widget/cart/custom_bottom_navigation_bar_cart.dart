import 'package:e_commerce/controller/checkout_controller.dart';
import 'package:e_commerce/core/class/statusRequest.dart';
import 'package:e_commerce/view/widget/cart/custom_botton_coupon.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/core/constant/color.dart';
import 'package:get/get.dart';

class CustomBottomNavigationBarCart extends StatelessWidget {
  final String price;
  final String discount;
  final String totalPrice;
  final String shipping;
  final VoidCallback onCheckout;
  final VoidCallback onViewInvoice;
  final bool isLoading;
  final String? errorMessage;

  const CustomBottomNavigationBarCart({
    Key? key,
    required this.price,
    required this.discount,
    required this.totalPrice,
    required this.shipping,
    required this.onCheckout,
    required this.onViewInvoice,
    this.isLoading = false,
    this.errorMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CheckoutControllerImp checkoutControllerImp = Get.find();
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
        border: Border.all(
          color: AppColor.lightGray.withOpacity(0.3),
          width: 1,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomButtonCoupon(
            couponController: checkoutControllerImp.couponController!,
            onPressed: () {
              checkoutControllerImp.checkCoupon();
            },
            onRemove: () {
              checkoutControllerImp.onRemove();
            },
            appliedCoupon: checkoutControllerImp.couponModel,
            isLoading: checkoutControllerImp.statusRequest == StatusRequest.loading,
          ),
          SizedBox(height: 10),
          // معلومات الطلب
          _buildOrderSummary(),

          const SizedBox(height: 16),

          // زر عرض الفاتورة
          _buildViewInvoiceButton(),

          const SizedBox(height: 12),

          // زر الدفع
          _buildCheckoutButton(),

          // رسالة الخطأ (إذا وجدت)
          if (errorMessage != null && errorMessage!.isNotEmpty) ...[
            const SizedBox(height: 8),
            _buildErrorMessage(),
          ],
        ],
      ),
    );
  }

  Widget _buildOrderSummary() {
    final double discountAmount =
        double.tryParse(discount.replaceAll('%', '')) ?? 0.0;
    final double subtotal = double.tryParse(price) ?? 0.0;
    final double shippingAmount = double.tryParse(shipping) ?? 0.0;
    final double calculatedTotal = double.tryParse(totalPrice) ?? 0.0;

    return Column(
      children: [
        // السعر الأصلي
        _buildSummaryRow(
          label: 'Subtotal',
          value: '\$$price',
          icon: Icons.shopping_bag_outlined,
          iconColor: AppColor.textSecondary,
        ),

        // الخصم
        if (discountAmount > 0) ...[
          const SizedBox(height: 8),
          _buildSummaryRow(
            label: 'Discount',
            value: '-$discount',
            icon: Icons.discount_outlined,
            iconColor: AppColor.successGreen,
            valueColor: AppColor.successGreen,
            isDiscount: true,
          ),
        ],

        // الشحن
        const SizedBox(height: 8),
        _buildSummaryRow(
          label: 'Shipping',
          value: '\$$shipping',
          icon: Icons.local_shipping_outlined,
          iconColor: AppColor.infoBlue,
        ),

        // الخط الفاصل
        Container(
          margin: const EdgeInsets.symmetric(vertical: 12),
          height: 1,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
                AppColor.lightGray,
                Colors.transparent,
              ],
              stops: const [0.0, 0.5, 1.0],
            ),
          ),
        ),

        // السعر الإجمالي
        _buildTotalRow(),
      ],
    );
  }

  Widget _buildSummaryRow({
    required String label,
    required String value,
    required IconData icon,
    required Color iconColor,
    Color? valueColor,
    bool isDiscount = false,
  }) {
    return Row(
      children: [
        // الأيقونة
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 16, color: iconColor),
        ),

        const SizedBox(width: 12),

        // النص
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: AppColor.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        // القيمة
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: valueColor ?? AppColor.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildTotalRow() {
    return Row(
      children: [
        // أيقونة الإجمالي
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColor.primaryColor, AppColor.primaryDark],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: AppColor.primaryColor.withOpacity(0.2),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: const Icon(
            Icons.payments_outlined,
            size: 20,
            color: Colors.white,
          ),
        ),

        const SizedBox(width: 12),

        // النص
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total Amount',
                style: TextStyle(fontSize: 12, color: AppColor.textLight),
              ),
              const SizedBox(height: 2),
              Text(
                'Includes all taxes',
                style: TextStyle(fontSize: 10, color: AppColor.textLight),
              ),
            ],
          ),
        ),

        // السعر الإجمالي
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '\$$totalPrice',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColor.textPrimary,
                fontFamily: 'Roboto',
              ),
            ),
            Text(
              'USD',
              style: TextStyle(fontSize: 10, color: AppColor.textLight),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildViewInvoiceButton() {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: onViewInvoice,
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          side: BorderSide(color: AppColor.primaryColor),
        ),
        icon: Icon(
          Icons.receipt_long_outlined,
          color: AppColor.primaryColor,
          size: 20,
        ),
        label: Text(
          'View Full Invoice',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: AppColor.primaryColor,
          ),
        ),
      ),
    );
  }

  Widget _buildCheckoutButton() {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        gradient: AppColor.buttonGradient,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: AppColor.primaryColor.withOpacity(0.4),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: isLoading ? null : onCheckout,
          splashColor: Colors.white.withOpacity(0.2),
          highlightColor: Colors.white.withOpacity(0.1),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // الجزء الأيسر
                Row(
                  children: [
                    Icon(
                      Icons.lock_outlined,
                      color: Colors.white.withOpacity(0.9),
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Secure Checkout',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '100% Safe & Encrypted',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                // الجزء الأيمن
                Row(
                  children: [
                    if (isLoading)
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    else ...[
                      Text(
                        'Place Order',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.arrow_forward_rounded,
                        color: Colors.white.withOpacity(0.9),
                        size: 20,
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildErrorMessage() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColor.errorRed.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColor.errorRed.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline_rounded, size: 16, color: AppColor.errorRed),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              errorMessage!,
              style: TextStyle(fontSize: 12, color: AppColor.errorRed),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
