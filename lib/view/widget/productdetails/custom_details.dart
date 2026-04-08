import 'package:e_commerce/core/constant/color.dart';
import 'package:flutter/material.dart';

class CustomProductDetails extends StatefulWidget {
  final Map<String, dynamic> details;
  final String title;
  final double maxHeight;
  final bool initiallyExpanded;
  final VoidCallback? onExpandChanged;
  final Color? accentColor;

  const CustomProductDetails({
    super.key,
    required this.details,
    this.title = "Product Details",
    this.maxHeight = 300,
    this.initiallyExpanded = false,
    this.onExpandChanged,
    this.accentColor,
  });

  @override
  State<CustomProductDetails> createState() => _CustomProductDetailsState();
}

class _CustomProductDetailsState extends State<CustomProductDetails>
    with SingleTickerProviderStateMixin {
  late bool _isExpanded;
  late AnimationController _animationController;
  late Animation<double> _rotateAnimation;
  late Animation<double> _heightFactorAnimation;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _rotateAnimation = Tween<double>(begin: 0, end: 0.5).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _heightFactorAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
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
      widget.onExpandChanged?.call();
    });
  }

  // دالة مساعدة لبناء صف التفاصيل بشكل أنيق
  Widget _buildDetailRow(String label, String value, ) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
           Container(height: 20, width: 2, color: AppColor.hotRed),

          const SizedBox(width: 10),

          // Label
          Expanded(
            flex: 4,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: isDarkMode
                    ? Colors.grey.shade400
                    : AppColor.textSecondary,
                letterSpacing: 0.3,
              ),
            ),
          ),

          // Value
          Expanded(
            flex: 6,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: isDarkMode
                    ? Colors.grey.shade800.withOpacity(0.5)
                    : Colors.grey.shade50,
                border: Border.all(
                  color: isDarkMode
                      ? Colors.grey.shade700
                      : AppColor.hotRed.withValues(alpha: 0.1),
                  width: 1,
                ),
              ),
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: isDarkMode ? Colors.white : AppColor.textPrimary,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final accentColor = widget.accentColor ?? AppColor.hotRed;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: _toggleExpand,
            borderRadius: BorderRadius.circular(16),
            splashColor: accentColor.withOpacity(0.2),
            highlightColor: accentColor.withOpacity(0.1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Section
                Row(
                  children: [
                    // Icon with gradient background
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [accentColor, accentColor.withOpacity(0.7)],
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Icon(
                        Icons.inventory_2_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 20),

                    // Title
                    Expanded(
                      child: Text(
                        widget.title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: isDarkMode
                              ? Colors.white
                              : AppColor.darkGray,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),

                    // Badge for number of details

                    // Expand/Collapse Button with Animation
                    AnimatedBuilder(
                      animation: _rotateAnimation,
                      builder: (context, child) {
                        return Transform.rotate(
                          angle: _rotateAnimation.value * 3.14159,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: _isExpanded
                                  ? accentColor.withOpacity(0.1)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: _isExpanded
                                  ? accentColor
                                  : (isDarkMode
                                        ? Colors.grey.shade400
                                        : AppColor.textSecondary),
                              size: 28,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),

                // Details Section with Animation
                AnimatedBuilder(
                  animation: _heightFactorAnimation,
                  builder: (context, child) {
                    return ClipRect(
                      child: Align(
                        heightFactor: _heightFactorAnimation.value,
                        child: Opacity(
                          opacity: _heightFactorAnimation.value,
                          child: child,
                        ),
                      ),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),

                      // Gradient Divider
                      Container(
                        height: 2,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              accentColor,
                              accentColor.withOpacity(0.5),
                              Colors.transparent,
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Details Grid/List
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isDarkMode
                              ? Colors.grey.shade900.withOpacity(0.5)
                              : Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isDarkMode
                                ? Colors.grey.shade800
                                : Colors.grey.shade200,
                            width: 1,
                          ),
                        ),
                        child: Column(
                          children: [
                            // Regular details rows
                            ...widget.details.entries.map((entry) {
                              // Skip feature progress bars or special handling
                              if (entry.key.startsWith('progress_')) {
                                return const SizedBox.shrink();
                              }

                              // Assign icons based on key
                              return _buildDetailRow(
                                entry.key,
                                entry.value.toString(),
                              );
                            }).toList(),
                          ],
                        ),
                      ),

                      // Additional Info Footer
                      if (widget.details.isNotEmpty) ...[
                        const SizedBox(height: 16),

                        // Quick Stats Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildQuickStat(
                              'In Stock',
                              widget.details['stock']?.toString() ?? '0',
                              Icons.check_circle_rounded,
                              accentColor,
                            ),
                            Container(
                              height: 30,
                              width: 1,
                              color: isDarkMode
                                  ? Colors.grey.shade700
                                  : Colors.grey.shade300,
                            ),
                            _buildQuickStat(
                              'Discount',
                              widget.details['discount']?.toString() ?? '0%',
                              Icons.percent_rounded,
                              accentColor,
                            ),
                            Container(
                              height: 30,
                              width: 1,
                              color: isDarkMode
                                  ? Colors.grey.shade700
                                  : Colors.grey.shade300,
                            ),
                            _buildQuickStat(
                              'Rating',
                              widget.details['rating']?.toString() ?? '4.5',
                              Icons.star_rounded,
                              accentColor,
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuickStat(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : AppColor.textPrimary,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: isDarkMode ? Colors.grey.shade500 : Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}
