import 'package:e_commerce/controller/product_details_controller.dart';
import 'package:e_commerce/core/constant/color.dart';
import 'package:e_commerce/data/model/productDetails_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CustomFeaturesSection extends StatefulWidget {
  final ProductDetailsControllerImp controller;
  final bool isDarkMode;

  const CustomFeaturesSection({
    super.key,
    required this.controller,
    required this.isDarkMode,
  });

  @override
  State<CustomFeaturesSection> createState() => _CustomFeaturesSectionState();
}

class _CustomFeaturesSectionState extends State<CustomFeaturesSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _rotateAnimation;
  late Animation<double> _heightAnimation;
  bool _isExpanded = true;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _rotateAnimation = Tween<double>(begin: 0, end: 0.5).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _heightAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    if (_isExpanded) {
      _animationController.value = 1.0;
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDarkMode;
    final accentColor = AppColor.hotRed;
    final selectedCount = widget.controller.getSelectedFeaturesCount();

    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Material(
        color: Colors.transparent,
        child: Column(
          children: [
            // ===== HEADER SECTION =====
            InkWell(
              onTap: _toggleExpand,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(24),
              ),
              splashColor: accentColor.withOpacity(0.1),
              highlightColor: accentColor.withOpacity(0.05),
              child: Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                child: Row(
                  children: [
                    // أيقونة رئيسية مع خلفية متدرجة
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [accentColor, accentColor.withOpacity(0.7)],
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Icon(
                        Iconsax.star5,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 14),

                    // العنوان والوصف
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Premium Features",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: isDark
                                      ? Colors.white
                                      : AppColor.textPrimary,
                                ),
                              ),
                              const SizedBox(width: 8),
                              // عرض السعر الكلي بشكل أنيق بجانب العنوان
                              if (selectedCount > 0)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.green.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: Colors.green.withOpacity(0.3),
                                      width: 1,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Iconsax.money,
                                        size: 10,
                                        color: Colors.green.shade700,
                                      ),
                                      const SizedBox(width: 2),
                                      Text(
                                        widget.controller
                                            .totalPriceFeaturesFormatted,
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green.shade700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text(
                            selectedCount > 0
                                ? "$selectedCount feature${selectedCount > 1 ? 's' : ''} selected"
                                : "Select features that matter to you",
                            style: TextStyle(
                              fontSize: 12,
                              color: isDark
                                  ? Colors.grey.shade400
                                  : Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // عداد المختارات
                    if (selectedCount > 0) ...[
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: accentColor.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          "$selectedCount",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: accentColor,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                    ],

                    // زر التوسيع/الطي
                    AnimatedBuilder(
                      animation: _rotateAnimation,
                      builder: (context, child) {
                        return Transform.rotate(
                          angle: _rotateAnimation.value * 3.14159,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? Colors.grey.shade800
                                  : Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              Iconsax.arrow_down_1,
                              size: 16,
                              color: isDark
                                  ? Colors.grey.shade400
                                  : Colors.grey.shade600,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            // ===== EXPANDABLE CONTENT =====
            AnimatedBuilder(
              animation: _heightAnimation,
              builder: (context, child) {
                return ClipRect(
                  child: Align(
                    heightFactor: _heightAnimation.value,
                    child: Opacity(
                      opacity: _heightAnimation.value,
                      child: child,
                    ),
                  ),
                );
              },
              child: Column(
                children: [
                  // خط فاصل أنيق
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Container(
                      height: 1,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            accentColor.withOpacity(0.2),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),

                  // محتوى الخصائص
                  Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      children: [
                        // شبكة الخصائص (3 أعمدة)
                        _buildFeaturesGrid(),

                        // عرض السعر الكلي بشكل أنيق داخل المحتوى
                        if (selectedCount > 0) ...[
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.green.shade50,
                                  Colors.green.shade100.withOpacity(0.3),
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.green.shade200,
                                width: 1,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: Colors.green.shade100,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Iconsax.money,
                                        size: 14,
                                        color: Colors.green.shade700,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      "Total Features Price:",
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: isDark
                                            ? Colors.grey.shade300
                                            : Colors.grey.shade700,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.green.withOpacity(0.2),
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    widget.controller
                                        .totalPriceFeaturesFormatted,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green.shade700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],

                        const SizedBox(height: 16),
                        // أزرار التحكم
                        _buildActionButtons(),
                      ],
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

  Widget _buildFeaturesGrid() {
    // ✅ التأكد من وجود بيانات
    if (widget.controller.dataDetails.isEmpty ||
        widget.controller.dataDetails.first.features == null ||
        widget.controller.dataDetails.first.features!.isEmpty) {
      return const SizedBox.shrink();
    }

    final featuresList = widget.controller.dataDetails.first.features!;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.9,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: featuresList.length,
      itemBuilder: (context, index) {
        // ✅ الحصول على عنصر واحد من القائمة باستخدام index
        final Features feature = featuresList[index];

        // ✅ التحقق من أن feature ليس null
        if (feature.idFeatures == null) {
          return const SizedBox.shrink();
        }

        bool isSelected = widget.controller.isFeatureSelected(
          feature.idFeatures.toString(),
        );

        return _buildFeatureCard(feature, isSelected);
      },
    );
  }

  Widget _buildFeatureCard(Features feature, bool isSelected) {
    final isDark = widget.isDarkMode;
    final Color featureOriginalColor = AppColor.hotRed;
    final bool isPaid = feature.price != null && feature.price! > 0;
    final String priceText = isPaid ? "\$${feature.price!}" : "FREE";

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => widget.controller.toggleFeature(feature.idFeatures!),
          borderRadius: BorderRadius.circular(14),
          splashColor: featureOriginalColor.withOpacity(0.2),
          highlightColor: featureOriginalColor.withOpacity(0.1),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isDark ? Colors.grey.shade800 : Colors.grey.shade50,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: isSelected
                    ? AppColor.hotRed
                    : (isDark ? Colors.grey.shade700 : Colors.grey.shade200),
                width: isSelected ? 1.5 : 1,
              ),
            ),
            child: Stack(
              children: [
                if (isSelected)
                  Positioned(
                    top: -2,
                    right: -2,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: AppColor.hotRed,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 1.5),
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 8,
                      ),
                    ),
                  ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? featureOriginalColor.withOpacity(0.15)
                            : (isDark
                            ? Colors.grey.shade700
                            : Colors.grey.shade200),
                        borderRadius: BorderRadius.circular(10),
                      ),
                        child: Icon(
                          IconData(
                            int.parse(feature.iconFeatures!),
                            fontFamily: 'MaterialIcons',
                          ),
                          size: 16,
                        )
                    ),
                    const SizedBox(height: 6),
                    Text(
                      feature.nameFeatures ?? '',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.w500,
                        color: isSelected
                            ? (isDark ? Colors.white : AppColor.textPrimary)
                            : (isDark
                            ? Colors.grey.shade400
                            : Colors.grey.shade700),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 3),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: isPaid
                            ? (isSelected
                            ? featureOriginalColor.withOpacity(0.15)
                            : (isDark
                            ? Colors.grey.shade700
                            : Colors.grey.shade200))
                            : Colors.green.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        priceText,
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          color: isPaid
                              ? (isSelected
                              ? featureOriginalColor
                              : (isDark
                              ? Colors.grey.shade300
                              : Colors.grey.shade700))
                              : Colors.green.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    final isDark = widget.isDarkMode;
    final selectedCount = widget.controller.getSelectedFeaturesCount();

    return Row(
      children: [
        // زر Clear All
        Expanded(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: selectedCount > 0
                  ? widget.controller.clearAllFeatures
                  : null,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey.shade800 : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Iconsax.trash,
                      size: 14,
                      color: selectedCount > 0
                          ? AppColor.hotRed
                          : (isDark
                          ? Colors.grey.shade600
                          : Colors.grey.shade400),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      "Clear",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: selectedCount > 0
                            ? AppColor.hotRed
                            : (isDark
                            ? Colors.grey.shade600
                            : Colors.grey.shade400),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),

        // زر View Selected
        Expanded(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: selectedCount > 0 ? _showSelectedFeaturesDialog : null,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  gradient: selectedCount > 0
                      ? LinearGradient(
                    colors: [
                      AppColor.hotRed,
                      AppColor.hotRed.withOpacity(0.8),
                    ],
                  )
                      : null,
                  color: selectedCount > 0
                      ? null
                      : (isDark ? Colors.grey.shade800 : Colors.grey.shade100),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Iconsax.eye,
                      size: 14,
                      color: selectedCount > 0
                          ? Colors.white
                          : (isDark
                          ? Colors.grey.shade600
                          : Colors.grey.shade400),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      "View",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: selectedCount > 0
                            ? Colors.white
                            : (isDark
                            ? Colors.grey.shade600
                            : Colors.grey.shade400),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showSelectedFeaturesDialog() {
    final isDark = widget.isDarkMode;
    final selectedIds = widget.controller.selectedFeatures;

    // ✅ التأكد من وجود البيانات
    if (widget.controller.dataDetails.isEmpty ||
        widget.controller.dataDetails.first.features == null) {
      return;
    }

    final selectedFeaturesList = widget.controller.dataDetails.first.features!
        .where((f) => selectedIds.contains(f.idFeatures.toString()))
        .toList();

    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          width: double.infinity,
          constraints: const BoxConstraints(maxWidth: 350),
          decoration: BoxDecoration(
            color: isDark ? Colors.grey.shade900 : Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColor.hotRed, AppColor.hotRed.withOpacity(0.7)],
                  ),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(Iconsax.star5, color: Colors.white, size: 20),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Selected Features",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "${selectedFeaturesList.length} features",
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 18,
                      ),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
              ),

              // Features List
              if (selectedFeaturesList.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    children: [
                      Icon(Iconsax.box, size: 50, color: Colors.grey.shade400),
                      const SizedBox(height: 12),
                      Text(
                        "No features selected",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                )
              else
                ListView.separated(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(16),
                  itemCount: selectedFeaturesList.length,
                  separatorBuilder: (context, index) =>
                  const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final feature = selectedFeaturesList[index];
                    final bool isPaid = feature.price != null && feature.price! > 0;

                    return Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: AppColor.hotRed.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                              child: Icon(
                                IconData(
                                  int.parse(feature.iconFeatures!),
                                  fontFamily: 'MaterialIcons',
                                ),
                                size: 16,
                              )
                          ),
                          const SizedBox(width: 12),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  feature.nameFeatures ?? '',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: isDark
                                        ? Colors.white
                                        : AppColor.textPrimary,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 1,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isPaid
                                        ? AppColor.hotRed.withOpacity(0.1)
                                        : Colors.green.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    isPaid ? "\$${feature.price}" : "FREE",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: isPaid
                                          ? AppColor.hotRed
                                          : Colors.green.shade700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          IconButton(
                            onPressed: () {
                              widget.controller
                                  .toggleFeature(feature.idFeatures!);
                              Get.back();
                              _showSelectedFeaturesDialog();
                            },
                            icon: Icon(
                              Iconsax.trash,
                              size: 16,
                              color: AppColor.hotRed.withOpacity(0.7),
                            ),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ],
                      ),
                    );
                  },
                ),

              // Footer
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Get.back(),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          side: BorderSide(color: AppColor.hotRed),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          "Close",
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColor.hotRed,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}