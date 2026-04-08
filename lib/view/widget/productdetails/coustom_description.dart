import 'package:e_commerce/core/constant/color.dart';
import 'package:flutter/material.dart';

class CustomDescription extends StatefulWidget {
  final String description;
  final String title;
  final double maxHeight;
  final bool initiallyExpanded;
  final VoidCallback? onExpandChanged;
  final Color? accentColor;


  const CustomDescription({
    super.key,
    required this.description,
    this.title = "Description",
    this.maxHeight = 200,
    this.initiallyExpanded = false,
    this.onExpandChanged,
    this.accentColor,

  });

  @override
  State<CustomDescription> createState() => _CustomDescriptionState();
}

class _CustomDescriptionState extends State<CustomDescription>
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

    _rotateAnimation = Tween<double>(
      begin: 0,
      end: 0.5,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _heightFactorAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

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

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final accentColor = widget.accentColor ?? AppColor.hotRed;

    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _toggleExpand,
          borderRadius: BorderRadius.circular(16),
          splashColor: AppColor.getLightRedColor(0.2),
          highlightColor: AppColor.getLightRedColor(0.1),
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
                      Icons.description_rounded,
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
                                ? AppColor.getLightRedColor(0.1)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: _isExpanded
                                ? AppColor.hotRed
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

              // Description Section with Animation
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
                            AppColor.hotRed,
                            AppColor.coldOrange2,
                            Colors.transparent,
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Description Text with Highlight
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isDarkMode
                            ? AppColor.darkGray.withOpacity(0.3)
                            : AppColor.getLightRedColor(0.05),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isDarkMode
                              ? AppColor.darkGray
                              : AppColor.getLightRedColor(0.2),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Vertical Quote Line
                          Container(
                            width: 4,
                            height: 80,
                            decoration: BoxDecoration(
                              gradient: AppColor.redGradient,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          const SizedBox(width: 12),

                          // Description Text
                          Expanded(
                            child: Text(
                              widget.description.isEmpty
                                  ? "No description available"
                                  : widget.description,
                              style: TextStyle(
                                fontSize: 14,
                                height: 1.6,
                                color: isDarkMode
                                    ? Colors.grey.shade300
                                    : AppColor.textSecondary,
                                fontStyle: widget.description.isEmpty
                                    ? FontStyle.italic
                                    : FontStyle.normal,
                              ),
                              textAlign: TextAlign.justify,

                            ),
                          ),
                        ],
                      ),
                    ),

                    // Feature Indicators (if description exists)
                    if (widget.description.isNotEmpty) ...[
                      const SizedBox(height: 16),

                      // Read Time Indicator
                    ],
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