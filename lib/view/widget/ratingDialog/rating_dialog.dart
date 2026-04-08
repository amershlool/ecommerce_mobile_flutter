import 'dart:math';
import 'package:e_commerce/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingDialog extends StatefulWidget {
  final String itemId;
  final String itemName;
  final String? itemImage;
  final Function(double rating) onRatingSubmitted;
  final Function() onSkipRating;
  final bool isSkippable;

  const RatingDialog({
    Key? key,
    required this.itemId,
    required this.itemName,
    this.itemImage,
    required this.onRatingSubmitted,
    required this.onSkipRating,
    this.isSkippable = true,
  }) : super(key: key);

  @override
  _RatingDialogState createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  double _rating = 0;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    Future.delayed(const Duration(milliseconds: 100), () {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submitRating() async {
    if (_rating == 0) {
      Get.snackbar(
        'Rating Required',
        'Please select a rating before submitting',
        backgroundColor: AppColor.hotRed.withOpacity(0.9),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      // التصحيح هنا: استدعاء الدالة وانتظار النتيجة
      bool success = await widget.onRatingSubmitted(_rating);

      if (success) {
        _controller.reverse();
        await Future.delayed(const Duration(milliseconds: 300));
        Get.back(result: {'rating': _rating, 'success': true});
      } else {
        // إذا فشل الإرسال، أعد تعيين حالة الإرسال
        setState(() => _isSubmitting = false);
        Get.snackbar(
          'Submission Failed',
          'Please try again',
          backgroundColor: AppColor.hotRed,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      setState(() => _isSubmitting = false);
      Get.snackbar(
        'Error',
        'Failed to submit rating: $e',
        backgroundColor: AppColor.hotRed,
        colorText: Colors.white,
      );
    }
  }

  void _skipRating() async {
    final shouldSkip = await _showSkipConfirmation();
    if (shouldSkip) {
      // استدعاء دالة التخطي أولاً
      widget.onSkipRating();
      // ثم إغلاق الدايلوج مع علامة التخطي
      _controller.reverse();
      await Future.delayed(const Duration(milliseconds: 300));
      Get.back(result: {'skipped': true});
    }
  }

  Future<bool> _showSkipConfirmation() async {
    return await showDialog(
      context: Get.context!,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(
          'Skip Rating?',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColor.hotRed,
          ),
        ),
        content: Text(
          'This item will be rated as 3 stars.',
          style: TextStyle(
            fontSize: 14,
            height: 1.5,
            color: AppColor.textSecondary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: Text(
              'CANCEL',
              style: TextStyle(
                color: AppColor.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: Text(
              'SKIP',
              style: TextStyle(
                color: AppColor.hotRed,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    ) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Container(
              decoration: BoxDecoration(
                // الحفاظ على Gradient كما هو
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white,
                    AppColor.coldOrange.withOpacity(0.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 25,
                    spreadRadius: 5,
                    offset: const Offset(0, 10),
                  ),
                  BoxShadow(
                    color: AppColor.hotRed.withOpacity(0.1),
                    blurRadius: 15,
                    spreadRadius: 3,
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: -50,
                    right: -50,
                    child: Transform.rotate(
                      angle: pi / 4,
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          // الحفاظ على Gradient كما هو
                          gradient: LinearGradient(
                            colors: [
                              AppColor.hotRed.withOpacity(0.08),
                              AppColor.coldOrange.withOpacity(0.04),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: -40,
                    left: -40,
                    child: Transform.rotate(
                      angle: -pi / 3,
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          // الحفاظ على Gradient كما هو
                          gradient: LinearGradient(
                            colors: [
                              AppColor.coldOrange2.withOpacity(0.05),
                              AppColor.hotRed.withOpacity(0.05),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            // الحفاظ على Gradient كما هو
                            gradient: AppColor.redGradient,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppColor.hotRed.withOpacity(0.3),
                                blurRadius: 20,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.star_rate_rounded,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),

                        const SizedBox(height: 20),

                        Text(
                          'Rate Your Purchase',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            // الحفاظ على اللون كما هو
                            color: AppColor.textPrimary,
                            height: 1.3,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 10),

                        Text(
                          widget.itemName,
                          style: TextStyle(
                            fontSize: 16,
                            // الحفاظ على اللون كما هو
                            color: AppColor.hotRed,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),

                        const SizedBox(height: 30),

                        RatingBar.builder(
                          initialRating: 0,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: false,
                          itemCount: 5,
                          itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            // الحفاظ على اللون كما هو
                            color: AppColor.hotRed,
                            size: 40,
                          ),
                          unratedColor: AppColor.lightGray,
                          onRatingUpdate: (rating) {
                            setState(() => _rating = rating);
                          },
                        ),

                        const SizedBox(height: 20),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Poor',
                              style: TextStyle(
                                // الحفاظ على اللون كما هو
                                color: AppColor.textSecondary,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              'Excellent',
                              style: TextStyle(
                                // الحفاظ على اللون كما هو
                                color: AppColor.hotRed,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 30),

                        Row(
                          children: [
                            if (widget.isSkippable) ...[
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: _isSubmitting ? null : _skipRating,
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    side: BorderSide(
                                      // الحفاظ على اللون كما هو
                                      color: AppColor.textSecondary.withOpacity(0.3),
                                      width: 2,
                                    ),
                                  ),
                                  child: Text(
                                    'SKIP',
                                    style: TextStyle(
                                      // الحفاظ على اللون كما هو
                                      color: AppColor.textSecondary,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15),
                            ],
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  // الحفاظ على Gradient كما هو
                                  gradient: AppColor.buttonGradient,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColor.hotRed.withOpacity(0.3),
                                      blurRadius: 8,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: ElevatedButton(
                                  onPressed: _isSubmitting ? null : _submitRating,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    elevation: 0,
                                  ),
                                  child: _isSubmitting
                                      ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                      : Text(
                                    'SUBMIT RATING',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),

                        if (widget.isSkippable)
                          Text(
                            'Main product only',
                            style: TextStyle(
                              fontSize: 12,
                              // الحفاظ على اللون كما هو
                              color: AppColor.hotRed,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}