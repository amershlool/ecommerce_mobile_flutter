import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/controller/cart_controller.dart';
import 'package:e_commerce/controller/checkout_controller.dart';
import 'package:e_commerce/core/class/statusRequest.dart';
import 'package:e_commerce/core/constant/color.dart';
import 'package:e_commerce/core/constant/routesname.dart';
import 'package:e_commerce/data/model/cart_model.dart';
import 'package:e_commerce/linkapi.dart';
import 'package:e_commerce/view/widget/custom_appbar.dart';
import 'package:e_commerce/view/widget/custom_popupmenuitem_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    final CartControllerImp cartController = Get.find();
    TextEditingController textEditingController = TextEditingController();
    return Scaffold(
      drawer: CustomSideMenu(),
      backgroundColor: AppColor.background,
      body: SafeArea(
        child: Column(
          children: [
            // AppBar مخصص
            CustomAppbar(
              titleAppbar: "Cart",
              onPressedIconSearch: () {
                Get.toNamed(AppRoutes.notification);
              },
              onPressedIconAction: () {
                Get.toNamed(AppRoutes.myFavorite);
              },
              iconAction: Icons.favorite_border,
              onChanged: (String value) {},
              textEditingController: textEditingController,
              isSearch: false,
            ),

            // المحتوى الرئيسي
            Expanded(
              child: GetBuilder<CartControllerImp>(
                builder: (controller) {
                  if (controller.statusRequest == StatusRequest.loading) {
                    return _buildLoadingState();
                  }

                  if (controller.data.isEmpty) {
                    return CartEmptyState(
                      onShopNowPressed: () => controller.goToShopping(),
                    );
                  }

                  return _buildCartContent(controller, context);
                },
              ),
            ),

            // ملخص السلة
            if (cartController.data.isNotEmpty)
              CartSummaryCard(
                itemCount: cartController.totalCountItems,
                totalPrice: cartController.totalPrice,
                shippingFee: 15.0,
                discount: cartController.totalDiscount,
                onCheckout: () {
                  Get.put(CheckoutControllerImp());
                  _handleCheckout(cartController);
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 150,
            height: 150,
            child: Center(
              child: CircularProgressIndicator(
                strokeWidth: 6,          // سمك الخط
                color: Colors.redAccent, // لون المؤشر
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'loading_cart'.tr,
            style: const TextStyle(
              fontSize: 16,
              color: AppColor.darkGray,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartContent(CartControllerImp controller, BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => await controller.viewCart(),
      color: AppColor.primaryColor,
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: controller.data.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final item = controller.data[index];
          return CartItemCard(
            item: item,
            onIncrement: () =>
                controller.addToCart(item.cartItemsId.toString(),item.cartSupItemsId.toString(),),
            onDecrement: () =>
                controller.removeFromCart(item.cartItemsId.toString(),item.cartSupItemsId.toString()),
            onTap: () => _showItemDetails(context, item),
          );
        },
      ),
    );
  }

  void _showItemDetails(BuildContext context, CartModel item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CartItemDetailsSheet(item: item),
    );
  }




  void _handleCheckout(CartControllerImp controller) {
    if (controller.data.isEmpty) {
      Get.snackbar(
        'empty_cart'.tr,
        'add_items_before_checkout'.tr,
        backgroundColor: AppColor.warningYellow,
        colorText: Colors.white,
      );
      return;
    }

    Get.toNamed(
      AppRoutes.checkOut,
      arguments: {
        'cartItems': controller.data,
        'totalPrice': controller.totalPrice,
        'totalItems': controller.totalCountItems,
      },
    );
  }
}

// cart_app_bar.dart
class CartAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onFavoritePressed;
  final VoidCallback onSearchPressed;

  const CartAppBar({
    super.key,
    required this.title,
    required this.onFavoritePressed,
    required this.onSearchPressed,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.transparent),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
              onPressed: () => Get.back(),
              splashRadius: 20,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'PlayfairDisplay',
                  color: AppColor.darkRed,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.search_rounded),
              onPressed: onSearchPressed,
              splashRadius: 20,
              tooltip: 'search'.tr,
            ),
            IconButton(
              icon: const Icon(Icons.favorite_border_rounded),
              onPressed: onFavoritePressed,
              splashRadius: 20,
              tooltip: 'favorites'.tr,
            ),
          ],
        ),
      ),
    );
  }
}

// cart_summary_card.dart
class CartSummaryCard extends StatelessWidget {
  final int itemCount;
  final double totalPrice;
  final double shippingFee;
  final double discount;
  final VoidCallback onCheckout;

  const CartSummaryCard({
    super.key,
    required this.itemCount,
    required this.totalPrice,
    required this.shippingFee,
    required this.discount,
    required this.onCheckout,
  });

  @override
  Widget build(BuildContext context) {
    final double subtotal = totalPrice - discount;
    final double grandTotal = subtotal + shippingFee;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildSummaryRow('subtotal'.tr, '\$${subtotal.toStringAsFixed(2)}'),
          _buildSummaryRow(
            'discount'.tr,
            '-\$${discount.toStringAsFixed(2)}',
            valueColor: AppColor.successGreen,
          ),
          _buildSummaryRow(
            'shipping'.tr,
            '\$${shippingFee.toStringAsFixed(2)}',
          ),
          const Divider(height: 20),
          _buildSummaryRow(
            'total'.tr,
            '\$${grandTotal.toStringAsFixed(2)}',
            isBold: true,
            valueColor: AppColor.primaryColor,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              // زر صغير للمتابعة
              Container(
                width: 50,
                height: 50,
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColor.primaryColor, width: 1.5),
                ),
                child: IconButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.categories);
                  },
                  icon: const Icon(
                    Icons.shopping_cart,
                    color: AppColor.primaryColor,
                    size: 20,
                  ),
                  tooltip: 'Continue Shopping',
                ),
              ),

              // زر كبير للدفع
              Expanded(
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: AppColor.primaryGradient,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.primaryColor.withValues(alpha: 0.3),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: onCheckout,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Checkout Now',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Text(
                                  itemCount.toString(),
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.primaryColor,
                                  ),
                                ),
                              ),
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
          SizedBox(height: 15),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(
    String label,
    String value, {
    bool isBold = false,
    Color? valueColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: AppColor.darkGray,
              fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: valueColor ?? AppColor.darkGray,
              fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// cart_item_card.dart
class CartItemCard extends StatefulWidget {
  final CartModel item;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onTap;

  const CartItemCard({
    super.key,
    required this.item,
    required this.onIncrement,
    required this.onDecrement,
    required this.onTap,
  });

  @override
  State<CartItemCard> createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> {
  final bool _isRemoving = false;

  @override
  Widget build(BuildContext context) {
    final item = widget.item;

    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: _isRemoving ? 0 : 150,
        curve: Curves.easeInOut,
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              // صورة المنتج
              _buildProductImage(item),

              // تفاصيل المنتج
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // الاسم والعلامة التجارية
                      _buildProductInfo(item),

                      // السعر والكمية
                      _buildPriceAndQuantity(item),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductImage(CartModel item) {
    return Container(
      width: 100,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.horizontal(left: Radius.circular(16)),
        image: DecorationImage(
          image: CachedNetworkImageProvider(
            "${AppLink.imageItems}/${item.imageUrl}",
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          if (item.discount > 0)
            Positioned(
              top: 8,
              left: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColor.errorRed,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '-${item.discount}%',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // في دالة _buildProductInfo أو _buildVariantChip
  Widget _buildProductInfo(CartModel item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item.nameEn,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColor.darkRed,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 2),
        Text(
          item.itemBrand,
          style: const TextStyle(fontSize: 12, color: AppColor.darkGray),
        ),
        if (item.colorName != null || item.itemSize != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Wrap(
              spacing: 8,
              children: [
                if (item.colorName != null)
                  _buildVariantChip(
                    item.colorName!,
                    color: _parseColorHex(item.colorHex),
                  ),
                if (item.itemSize != null)
                  _buildVariantChip('Size: ${item.itemSize}'),
              ],
            ),
          ),
      ],
    );
  }

  // دالة جديدة لتحليل كود اللون بشكل آمن
  Color? _parseColorHex(String? colorHex) {
    if (colorHex == null || colorHex.isEmpty) return null;

    try {
      // إزالة علامة # إذا كانت موجودة
      String hex = colorHex.replaceFirst('#', '');

      // إذا كان الكود مسبوق بـ 0xFF بالفعل، أزل التكرار
      if (hex.startsWith('0xFF')) {
        hex = hex.substring(4);
      }

      // أضف 0xFF في البداية إذا كان طول الكود 6 (RGB بدون ألفا)
      if (hex.length == 6) {
        hex = 'FF$hex';
      }

      // تحقق من أن الكود صالح (يحتوي على أحرف hex فقط)
      final hexPattern = RegExp(r'^[0-9A-Fa-f]+$');
      if (!hexPattern.hasMatch(hex)) {
        debugPrint('Invalid hex color: $colorHex');
        return null;
      }

      // تحويل إلى عدد صحيح
      final colorValue = int.parse(hex, radix: 16);

      // التأكد من أن القيمة ضمن المدى الصحيح
      if (colorValue < 0 || colorValue > 0xFFFFFFFF) {
        debugPrint('Color value out of range: $colorValue');
        return null;
      }

      return Color(colorValue);
    } catch (e) {
      debugPrint('Error parsing color hex $colorHex: $e');
      return null;
    }
  }

  Widget _buildVariantChip(String text, {Color? color}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color?.withValues(alpha: 0.1) ?? AppColor.lightGray,
        borderRadius: BorderRadius.circular(6),
        border: color != null
            ? Border.all(color: color.withValues(alpha: 0.3))
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (color != null)
            Container(
              width: 10,
              height: 10,
              margin: const EdgeInsets.only(right: 4),
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
          Text(
            text,
            style: TextStyle(
              fontSize: 10,
              color: color ?? AppColor.darkGray,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceAndQuantity(CartModel item) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // السعر
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (item.discount > 0)
              Text(
                '\$${item.price.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColor.darkGray,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            Text(
              '\$${item.finalPrice.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColor.primaryColor,
              ),
            ),
          ],
        ),

        // عداد الكمية
        Container(
          decoration: BoxDecoration(
            color: AppColor.lightGray,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove, size: 18),
                onPressed: widget.onDecrement,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
              ),
              Container(
                width: 32,
                alignment: Alignment.center,
                child: Text(
                  item.countItems.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add, size: 18),
                onPressed: widget.onIncrement,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
              ),
            ],
          ),
        ),
      ],
    );
  }

}

// cart_item_details_sheet.dart
class CartItemDetailsSheet extends StatelessWidget {
  final CartModel item;

  const CartItemDetailsSheet({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverAppBar(
                expandedHeight: 300,
                flexibleSpace: FlexibleSpaceBar(
                  background: _buildImageGallery(),
                ),
                pinned: true,
                backgroundColor: Colors.transparent,
                leading: IconButton(
                  icon: const Icon(Icons.close_rounded),
                  onPressed: () => Navigator.pop(context),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.share_outlined),
                    onPressed: () => _shareProduct(item),
                  ),
                  IconButton(
                    icon: const Icon(Icons.favorite_border_rounded),
                    onPressed: () => _addToWishlist(item),
                  ),
                ],
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // معلومات المنتج الرئيسية
                      _buildProductHeader(),
                      const SizedBox(height: 20),

                      // الوصف
                      _buildDescriptionSection(),
                      const SizedBox(height: 20),

                      // المواصفات
                      _buildSpecificationsSection(),
                      const SizedBox(height: 20),

                      // تفاصيل الطلب
                      _buildOrderDetailsSection(),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildImageGallery() {
    return Stack(
      children: [
        // الصورة الرئيسية
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            image: DecorationImage(
              image: CachedNetworkImageProvider(
                "${AppLink.imageItems}/${item.imageUrl}",
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),

        // التدرج اللوني
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black.withValues(alpha: 0.3), Colors.transparent],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProductHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // العلامة التجارية
        Text(
          item.itemBrand.toUpperCase(),
          style: const TextStyle(
            fontSize: 14,
            color: AppColor.primaryColor,
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 8),

        // الاسم
        Text(
          item.nameEn,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColor.darkRed,
          ),
        ),
        const SizedBox(height: 12),

        // السعر
        Row(
          children: [
            Text(
              '\$${item.finalPrice.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColor.primaryColor,
              ),
            ),
            if (item.discount > 0) ...[
              const SizedBox(width: 12),
              Text(
                '\$${item.price.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 18,
                  color: AppColor.darkGray,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColor.errorRed,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '-${item.discount}%',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildDescriptionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Description',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColor.darkRed,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          item.descriptionEn.isNotEmpty
              ? item.descriptionEn
              : 'No description available',
          style: const TextStyle(
            fontSize: 14,
            color: AppColor.darkGray,
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildSpecificationsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Specifications',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColor.darkRed,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            if (item.colorName != null)
              _buildSpecificationChip(
                icon: Icons.palette_outlined,
                label: 'Color',
                value: item.colorName!,
                color: item.colorHex != null
                    ? _parseColorHexForDisplay(item.colorHex!)
                    : null,              ),
            if (item.itemSize != null)
              _buildSpecificationChip(
                icon: Icons.straighten_outlined,
                label: 'Size',
                value: item.itemSize!,
              ),
            _buildSpecificationChip(
              icon: Icons.category_outlined,
              label: 'Category',
              value: 'Category ${item.itemsCategories}',
            ),
            _buildSpecificationChip(
              icon: Icons.inventory_2_outlined,
              label: 'Status',
              value: item.itemsActive == 1 ? 'In Stock' : 'Out of Stock',
              valueColor: item.itemsActive == 1
                  ? AppColor.successGreen
                  : AppColor.errorRed,
            ),
          ],
        ),
      ],
    );
  }
  Color? _parseColorHexForDisplay(String colorHex) {
    try {
      // إزالة أي مسافات أو أحرف غير مرغوب فيها
      String cleanHex = colorHex.trim();

      // إذا كان الكود يحتوي على 0xFFx فهذا خطأ، يجب أن يكون 0xFF فقط
      if (cleanHex.startsWith('0xFFx')) {
        cleanHex = '0xFF' + cleanHex.substring(5);
      }
      // إذا كان الكود يحتوي على # في البداية
      else if (cleanHex.startsWith('#')) {
        if (cleanHex.length == 7) { // مثل #FF0000
          cleanHex = '0xFF' + cleanHex.substring(1);
        } else if (cleanHex.length == 9) { // مثل #FFFF0000
          cleanHex = '0x' + cleanHex.substring(1);
        }
      }
      // إذا كان الكود يبدأ بـ 0x مباشرة
      else if (cleanHex.startsWith('0x')) {
        // تأكد من أنه يحتوي على FF للألفا
        if (cleanHex.length == 8) { // مثل 0xFF0000
          cleanHex = '0xFF' + cleanHex.substring(2);
        }
      }
      // إذا كان الكود بدون بادئة
      else if (RegExp(r'^[0-9A-Fa-f]+$').hasMatch(cleanHex)) {
        if (cleanHex.length == 6) { // مثل FF0000
          cleanHex = '0xFF' + cleanHex;
        } else if (cleanHex.length == 8) { // مثل FFFF0000
          cleanHex = '0x' + cleanHex;
        }
      }

      // تحقق من التنسيق النهائي
      if (!cleanHex.startsWith('0x') || cleanHex.length < 8) {
        debugPrint('Invalid color format after cleaning: $colorHex -> $cleanHex');
        return null;
      }

      // التحويل إلى عدد صحيح
      final colorValue = int.parse(cleanHex, radix: 16);
      return Color(colorValue);

    } catch (e) {
      debugPrint('Error parsing color hex $colorHex: $e');
      return null;
    }
  }
  Widget _buildSpecificationChip({
    required IconData icon,
    required String label,
    required String value,
    Color? color,
    Color? valueColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColor.lightGray,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: AppColor.darkGray),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 12, color: AppColor.darkGray),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: valueColor ?? AppColor.darkRed,
                ),
              ),
            ],
          ),
          if (color != null) ...[
            const SizedBox(width: 8),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 4,
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildOrderDetailsSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.primaryColor.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColor.primaryColor.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Order Details',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColor.darkRed,
            ),
          ),
          const SizedBox(height: 12),
          _buildDetailRow('Quantity:', item.countItems.toString()),
          _buildDetailRow(
            'Unit Price:',
            '\$${item.finalPrice.toStringAsFixed(2)}',
          ),
          const Divider(height: 16),
          _buildDetailRow(
            'Subtotal:',
            '\$${item.sumPriceItems.toStringAsFixed(2)}',
            isBold: true,
            valueColor: AppColor.primaryColor,
          ),
          _buildDetailRow(
            'Savings:',
            '\$${(item.price * item.countItems - item.sumPriceItems).toStringAsFixed(2)}',
            valueColor: AppColor.successGreen,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    String label,
    String value, {
    bool isBold = false,
    Color? valueColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: AppColor.darkGray,
              fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: valueColor ?? AppColor.darkRed,
              fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  void _shareProduct(CartModel item) {
    // تنفيذ مشاركة المنتج
  }

  void _addToWishlist(CartModel item) {
    // تنفيذ الإضافة للمفضلة
  }
}

// cart_empty_state.dart
class CartEmptyState extends StatelessWidget {
  final VoidCallback onShopNowPressed;

  const CartEmptyState({super.key, required this.onShopNowPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inbox_outlined ,size: 100,),
            const SizedBox(height: 20),
            Text(
              'your_cart_is_empty'.tr,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColor.darkRed,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'add_items_to_get_started'.tr,
              style: const TextStyle(fontSize: 16, color: AppColor.darkGray),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                onPressed: onShopNowPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  elevation: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.shopping_bag_outlined,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'shop_now'.tr,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () => Get.toNamed(AppRoutes.myFavorite),
              child: Text(
                'browse_favorites'.tr,
                style: const TextStyle(
                  color: AppColor.primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// cart_search_delegate.dart
class CartSearchDelegate extends SearchDelegate<String> {
  final CartControllerImp controller;

  CartSearchDelegate({required this.controller});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults();
  }

  Widget _buildSearchResults() {
    final results = controller.data.where((item) {
      return item.nameEn.toLowerCase().contains(query.toLowerCase()) ||
          item.nameAr.contains(query) ||
          item.itemBrand.toLowerCase().contains(query.toLowerCase());
    }).toList();

    if (results.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.search_off_rounded,
              size: 64,
              color: AppColor.lightGray,
            ),
            const SizedBox(height: 16),
            Text(
              'no_items_found'.tr,
              style: const TextStyle(fontSize: 16, color: AppColor.darkGray),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: results.length,
      itemBuilder: (context, index) {
        final item = results[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(item.imageUrl),
          ),
          title: Text(item.nameEn),
          subtitle: Text('\$${item.finalPrice.toStringAsFixed(2)}'),
          trailing: IconButton(
            icon: const Icon(Icons.remove_red_eye_outlined),
            onPressed: () {
              // عرض تفاصيل المنتج
            },
          ),
        );
      },
    );
  }
}
