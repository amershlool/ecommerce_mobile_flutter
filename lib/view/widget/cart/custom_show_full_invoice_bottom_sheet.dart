import 'package:e_commerce/linkapi.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/core/constant/color.dart';
import 'package:e_commerce/data/model/cart_model.dart';

class ProfessionalCartInvoice extends StatelessWidget {
  final List<CartModel> cartItems;
  final double subtotal;
  final double discountAmount;
  final double shippingCost;
  final double taxAmount;
  final double totalAmount;
  final String userName;
  final String userEmail;
  final String? couponCode;
  final double couponDiscount;
  final VoidCallback onProceedToCheckout;
  final VoidCallback onContinueShopping;
  final bool isLoading;

  const ProfessionalCartInvoice({
    Key? key,
    required this.cartItems,
    required this.subtotal,
    required this.discountAmount,
    required this.shippingCost,
    required this.taxAmount,
    required this.totalAmount,
    required this.userName,
    required this.userEmail,
    this.couponCode,
    this.couponDiscount = 0.0,
    required this.onProceedToCheckout,
    required this.onContinueShopping,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final totalItems = cartItems.fold(0, (sum, item) => sum + item.countItems);
    final totalSavings = cartItems.fold(0.0, (sum, item) {
      final originalPrice = item.price * item.countItems;
      final discountedPrice = item.finalPrice * item.countItems;
      return sum + (originalPrice - discountedPrice);
    });

    final totalProductDiscount = cartItems.fold(0.0, (sum, item) {
      if (item.discount > 0) {
        final discountPerItem = item.price - item.finalPrice;
        return sum + (discountPerItem * item.countItems);
      }
      return sum;
    });

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 25,
            offset: const Offset(0, -10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildInvoiceHeader(context),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCustomerInfo(),
                  const SizedBox(height: 20),
                  _buildInvoiceSummary(totalItems, totalSavings, totalProductDiscount),
                  const SizedBox(height: 20),
                  _buildItemsList(),
                  const SizedBox(height: 20),
                  _buildPricingBreakdown(),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),

          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildInvoiceHeader(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 5,
          margin: const EdgeInsets.only(top: 10, bottom: 5),
          decoration: BoxDecoration(
            color: AppColor.lightGray,
            borderRadius: BorderRadius.circular(10),
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order Summary',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColor.textPrimary,
                      fontFamily: 'PlayfairDisplay',
                    ),
                  ),
                  Text(
                    '${cartItems.length} items • ${DateFormat('MMM dd, yyyy').format(DateTime.now())}',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColor.textLight,
                    ),
                  ),
                ],
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColor.lightGray,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Icon(
                    Icons.close_rounded,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ),

        Divider(height: 1, color: AppColor.dividerColor),
      ],
    );
  }

  Widget _buildCustomerInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.backgroundGrey,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColor.dividerColor),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColor.primaryColor,
              borderRadius: BorderRadius.circular(22),
            ),
            child: const Icon(
              Icons.person_outline,
              color: Colors.white,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColor.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  userEmail,
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.textSecondary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.shopping_cart_outlined,
                      size: 14,
                      color: AppColor.textLight,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Cart #${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColor.textLight,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInvoiceSummary(int totalItems, double totalSavings, double totalProductDiscount) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColor.primaryColor.withOpacity(0.05),
            AppColor.primaryLight.withOpacity(0.02),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColor.primaryColor.withOpacity(0.1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildSummaryItem(
            icon: Icons.shopping_bag_outlined,
            label: 'Total Items',
            value: totalItems.toString(),
            color: AppColor.infoBlue,
          ),
          _buildSummaryItem(
            icon: Icons.discount_outlined,
            label: 'Product Savings',
            value: '\$${totalSavings.toStringAsFixed(2)}',
            color: AppColor.successGreen,
          ),
          _buildSummaryItem(
            icon: Icons.percent_outlined,
            label: 'Best Discount',
            value: '${_getMaxDiscount()}%',
            color: AppColor.hotRed,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: color.withOpacity(0.2)),
          ),
          child: Icon(icon, size: 20, color: color),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColor.textPrimary,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: AppColor.textLight,
          ),
        ),
      ],
    );
  }

  int _getMaxDiscount() {
    if (cartItems.isEmpty) return 0;
    return cartItems.map((item) => item.discount).reduce((a, b) => a > b ? a : b);
  }

  Widget _buildItemsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Items in Cart',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColor.textPrimary,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColor.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                '${cartItems.length} products',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColor.primaryColor,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        ...cartItems.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          return _buildInvoiceItemCard(item, index + 1);
        }).toList(),
      ],
    );
  }

  Widget _buildInvoiceItemCard(CartModel item, int index) {
    final totalItemPrice = item.finalPrice * item.countItems;
    final originalTotalPrice = item.price * item.countItems;
    final itemDiscount = originalTotalPrice - totalItemPrice;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: AppColor.lightGray),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppColor.backgroundGrey,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: AppColor.primaryColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      index.toString(),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.nameEn,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColor.textPrimary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        item.itemBrand,
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColor.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                if (item.discount > 0)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColor.hotRed,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      '${item.discount}% OFF',
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: CachedNetworkImageProvider("${AppLink.imageItems}/${item.imageUrl}"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (item.colorName != null || item.itemSize != null)
                        Row(
                          children: [
                            if (item.colorName != null)
                              Row(
                                children: [
                                  Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      color: item.colorHex != null
                                          ? _parseColorHex(item.colorHex!) ?? AppColor.textSecondary
                                          : AppColor.textSecondary,
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(color: AppColor.dividerColor),
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    item.colorName!,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppColor.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            if (item.colorName != null && item.itemSize != null)
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: Container(
                                  width: 1,
                                  height: 12,
                                  color: AppColor.dividerColor,
                                ),
                              ),
                            if (item.itemSize != null)
                              Text(
                                'Size: ${item.itemSize}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColor.textSecondary,
                                ),
                              ),
                          ],
                        ),

                      const SizedBox(height: 8),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Quantity',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: AppColor.textLight,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppColor.primaryColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  '×${item.countItems}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '\$${item.finalPrice.toStringAsFixed(2)}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.primaryColor,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    'each',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: AppColor.textLight,
                                    ),
                                  ),
                                ],
                              ),
                              if (item.discount > 0)
                                Text(
                                  '\$${item.price.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColor.textLight,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: item.discount > 0
                              ? AppColor.successGreen.withOpacity(0.05)
                              : AppColor.backgroundGrey,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: item.discount > 0
                                ? AppColor.successGreen.withOpacity(0.2)
                                : AppColor.dividerColor,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Item Total',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColor.textSecondary,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '\$${totalItemPrice.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.textPrimary,
                                  ),
                                ),
                              ],
                            ),

                            if (item.discount > 0)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'You Saved',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppColor.successGreen,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    '\$${itemDiscount.toStringAsFixed(2)}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.successGreen,
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppColor.backgroundGrey,
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.inventory_outlined,
                      size: 14,
                      color: item.itemsActive == 1 ? AppColor.successGreen : AppColor.errorRed,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      item.itemsActive == 1 ? 'In Stock' : 'Out of Stock',
                      style: TextStyle(
                        fontSize: 12,
                        color: item.itemsActive == 1 ? AppColor.successGreen : AppColor.errorRed,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Text(
                  'Added on ${DateFormat('MMM dd').format(DateTime.parse(item.itemsCreateAt))}',
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColor.textLight,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPricingBreakdown() {
    final finalDiscount = discountAmount + couponDiscount;
    final finalSubtotal = subtotal;
    final finalTotal = totalAmount;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColor.dividerColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pricing Breakdown',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColor.textPrimary,
            ),
          ),
          const SizedBox(height: 16),

          _buildPriceRow(
            label: 'Products Total',
            value: '\$${subtotal.toStringAsFixed(2)}',
            isHighlighted: false,
          ),

          if (discountAmount > 0)
            _buildPriceRow(
              label: 'Product Discounts',
              value: '-\$${discountAmount.toStringAsFixed(2)}',
              isHighlighted: true,
              color: AppColor.successGreen,
              icon: Icons.discount_outlined,
            ),

          _buildPriceRow(
            label: 'Subtotal',
            value: '\$${finalSubtotal.toStringAsFixed(2)}',
            isHighlighted: true,
            isBold: true,
            showDivider: true,
          ),

          _buildPriceRow(
            label: 'Shipping & Handling',
            value: '\$${shippingCost.toStringAsFixed(2)}',
            icon: Icons.local_shipping_outlined,
          ),

          if (taxAmount > 0)
            _buildPriceRow(
              label: 'Taxes & Fees',
              value: '\$${taxAmount.toStringAsFixed(2)}',
              icon: Icons.receipt_outlined,
            ),

          if (couponDiscount > 0)
            _buildPriceRow(
              label: couponCode != null ? 'Coupon Discount ($couponCode)' : 'Additional Discount',
              value: '-\$${couponDiscount.toStringAsFixed(2)}',
              isHighlighted: true,
              color: AppColor.successGreen,
              icon: Icons.percent_outlined,
              showDivider: true,
            ),

          _buildPriceRow(
            label: 'Total Amount',
            value: '\$${finalTotal.toStringAsFixed(2)}',
            isHighlighted: true,
            isBold: true,
            isLarge: true,
            color: AppColor.primaryColor,
            icon: Icons.payments_outlined,
          ),

          const SizedBox(height: 8),

          Row(
            children: [
              Icon(
                Icons.credit_card_outlined,
                size: 16,
                color: AppColor.textSecondary,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Visa • MasterCard • Apple Pay • PayPal',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColor.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow({
    required String label,
    required String value,
    IconData? icon,
    bool isHighlighted = false,
    bool isBold = false,
    bool isLarge = false,
    bool showDivider = false,
    Color? color,
  }) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              if (icon != null)
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Icon(
                    icon,
                    size: 16,
                    color: color ?? AppColor.textSecondary,
                  ),
                ),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: isLarge ? 15 : 14,
                    fontWeight: isBold ? FontWeight.w600 : FontWeight.normal,
                    color: color ?? (isHighlighted ? AppColor.textPrimary : AppColor.textSecondary),
                  ),
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: isLarge ? 20 : (isBold ? 16 : 14),
                  fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
                  color: color ?? (isHighlighted ? AppColor.primaryColor : AppColor.textPrimary),
                  fontFamily: isLarge ? 'Roboto' : null,
                ),
              ),
            ],
          ),
        ),
        if (showDivider)
          Divider(height: 1, color: AppColor.dividerColor),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: AppColor.dividerColor),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.lock_outlined,
                size: 14,
                color: AppColor.successGreen,
              ),
              const SizedBox(width: 6),
              Text(
                'Secure checkout • 256-bit encryption • No card data stored',
                style: TextStyle(
                  fontSize: 11,
                  color: AppColor.textLight,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: onContinueShopping,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    side: BorderSide(color: AppColor.primaryColor),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.arrow_back_rounded,
                        size: 20,
                        color: AppColor.primaryColor,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Continue Shopping',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppColor.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Container(
                  height: 56,
                  decoration: BoxDecoration(
                    gradient: AppColor.buttonGradient,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.primaryColor.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: isLoading ? null : onProceedToCheckout,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Pay Now',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  '\$${totalAmount.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white.withOpacity(0.9),
                                  ),
                                ),
                              ],
                            ),
                            isLoading
                                ? SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                                : Icon(
                              Icons.arrow_forward_rounded,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          Text(
            'By proceeding, you agree to our Terms of Service and Privacy Policy',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              color: AppColor.textLight,
            ),
          ),
        ],
      ),
    );
  }
  Color? _parseColorHex(String? colorHex) {
    if (colorHex == null || colorHex.isEmpty) return null;

    try {
      // إزالة علامة # إذا كانت موجودة
      String hex = colorHex.replaceFirst('#', '');

      // إذا كان الكود مسبوق بـ 0xFF بالفعل، أزل التكرار
      if (hex.startsWith('0xFF')) {
        hex = hex.substring(4);
      }

      // التحقق من التكرار المضاعف
      if (hex.startsWith('0xFF')) {
        hex = hex.substring(4);
      }

      // أضف 0xFF في البداية إذا كان طول الكود 6 (RGB بدون ألفا)
      if (hex.length == 6) {
        hex = 'FF$hex';
      }

      // تحقق من أن الكود صالح
      final hexPattern = RegExp(r'^[0-9A-Fa-f]+$');
      if (!hexPattern.hasMatch(hex)) {
        debugPrint('Invalid hex color in invoice: $colorHex');
        return null;
      }

      // تحويل إلى عدد صحيح
      final colorValue = int.parse(hex, radix: 16);
      return Color(colorValue);
    } catch (e) {
      debugPrint('Error parsing color hex in invoice: $colorHex - $e');
      return null;
    }
  }

}