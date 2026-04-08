import 'package:e_commerce/core/constant/color.dart';
import 'package:flutter/material.dart';

class CustomBanner extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onPressed;

  const CustomBanner({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: AppColor.hotRed.withOpacity(0.4),
            blurRadius: 32,
            spreadRadius: 2,
            offset: const Offset(0, 16),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          // الخلفية المتدرجة مع تأثيرات
          _buildBackground(),

          // المحتوى الرئيسي
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // القسم النصي
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // العنوان مع تأثير شفاف
                      _buildTitle(),

                      const SizedBox(height: 8),

                      // العنوان الفرعي مع دعم 3 أسطر
                      _buildSubtitle(),

                      const SizedBox(height: 16),

                      // زر النداء للعمل
                    ],
                  ),
                ),

                const SizedBox(width: 20),

                // العنصر البصري الجانبي
                _buildVisualElement(),
              ],
            ),
          ),

          // تأثيرات زخرفية
          _buildDecorativeElements(),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          colors: [
            AppColor.hotRed,
            AppColor.primaryDark,
            AppColor.darkRed,
          ],
          stops: [0.0, 0.6, 1.0],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(0.15),
                Colors.transparent,
                Colors.white.withOpacity(0.05),
              ],
              stops: const [0.0, 0.5, 1.0],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ShaderMask(
        shaderCallback: (bounds) {
          return LinearGradient(
            colors: [
              Colors.white,
              Colors.white.withOpacity(0.8),
            ],
            stops: const [0.0, 1.0],
          ).createShader(bounds);
        },
        child: Text(
          title.toUpperCase(),
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            fontFamily: 'Roboto',
            letterSpacing: 1.8,
            height: 1.2,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget _buildSubtitle() {
    return Text(
      subtitle,
      style: const TextStyle(
        fontSize: 16,
        fontFamily: 'Cairo',
        color: Colors.white70,
        height: 1.2,
        shadows: [
          Shadow(
            color: Colors.black45,
            blurRadius: 6,
            offset: Offset(1, 1),
          ),
        ],
      ),
      maxLines: 5,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildVisualElement() {
    return SizedBox(
      width: 100,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // خلفية دائرية متدرجة
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  Colors.white.withOpacity(0.2),
                  Colors.transparent,
                ],
                stops: const [0.1, 0.8],
              ),
            ),
          ),

          // أيقونة مركزية مع تأثير
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.12),
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.15),
                  blurRadius: 15,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: const Icon(
              Icons.flash_on_rounded,
              size: 40,
              color: Colors.white,
              shadows: [
                Shadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  offset: Offset(1, 1),
                ),
              ],
            ),
          ),

          // جزيئات زخرفية
          Positioned(
            top: 10,
            right: 5,
            child: Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.coldOrange.withOpacity(0.5),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.coldOrange.withOpacity(0.3),
                    blurRadius: 6,
                    spreadRadius: 1,
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            bottom: 20,
            left: 5,
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.3),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.2),
                    blurRadius: 4,
                    spreadRadius: 1,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDecorativeElements() {
    return Positioned.fill(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Stack(
          children: [
            // خطوط زخرفية
            Positioned(
              top: -40,
              right: -40,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.02),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.08),
                    width: 1,
                  ),
                ),
              ),
            ),

            Positioned(
              bottom: -20,
              left: -20,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.015),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.06),
                    width: 1,
                  ),
                ),
              ),
            ),

            // نقاط زخرفية
            Positioned(
              top: 25,
              left: 25,
              child: Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.25),
                ),
              ),
            ),

            Positioned(
              bottom: 35,
              right: 35,
              child: Container(
                width: 5,
                height: 5,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
