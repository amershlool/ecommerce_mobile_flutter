import 'package:flutter/material.dart';

class AppColor {
  // الألوان الأساسية من الكود الأصلي
  static const Color grey = Color(0xff808080);
  static const Color darkGray = Color(0xff505050);
  static const Color hotRed = Color(0xFFCC0000);
  static const Color hotRed2 = Color(0xFF990000);
  static const Color coldOrange = Color(0xFFFFCCCC);
  static const Color coldOrange2 = Color(0xFFF3B9A8);
  static const Color black = Color(0xff000000);
  static const Color background = Color(0xffF8F9FD);
  static const Color background2 = Color(0xFFFFF8F3);
  static const Color notifications = Colors.pinkAccent;

  // ==== الألوان المعدلة مع الأحمر كلون رئيسي ====
  static const Color primaryColor = hotRed; // الأحمر كلون رئيسي
  static const Color primaryDark = hotRed2; // الأحمر الداكن
  static const Color primaryLight = Color(0xFFFF6666); // الأحمر الفاتح
  static const Color secondaryColor = Color(0xFF333333); // رمادي داكن كلون ثانوي
  static const Color accentColor = coldOrange2; // البرتقالي كلون مميز

  // ألوان الخلفيات
  static const Color backgroundGrey = Color(0xFFF8F8F8);
  static const Color lightGray = Color(0xFFF0F0F0);
  static const Color cardBackground = Color(0xFFFFFFFF);

  // ألوان النصوص
  static const Color textPrimary = Color(0xFF222222);
  static const Color textSecondary = Color(0xFF555555);
  static const Color textLight = Color(0xFF888888);
  static const Color textOnRed = Color(0xFFFFFFFF); // نص على خلفية حمراء

  // ألوان الحالة (Status Colors)
  static const Color successGreen = Color(0xFF34C759); // أخضر نيوني
  static const Color warningYellow = Color(0xFFFF9500); // برتقالي فاتح
  static const Color errorRed = Color(0xFFFF3B30); // أحمر فاتح للخطأ
  static const Color infoBlue = Color(0xFF007AFF); // أزرق فاتح

  // ألوان التدرجات (Gradients) - أحمر
  static const Color darkRed = Color(0xFF990000);
  static const Color mediumRed = Color(0xFFCC0000);
  static const Color lightRed = Color(0xFFFF6666);

  // ألوان إضافية للتصميم
  static const Color shadowColor = Color(0x1A000000);
  static const Color dividerColor = Color(0xFFE0E0E0);
  static const Color overlayColor = Color(0x66000000);
  static const Color shimmerColor = Color(0xFFEEEEEE);
  static const Color shimmerHighlight = Color(0xFFF5F5F5);

  // ألوان خاصة بالسلة
  static const Color cartPrimary = hotRed;
  static const Color cartSecondary = Color(0xFF333333);
  static const Color cartAccent = coldOrange2;
  static const Color cartBackground = Color(0xFFF8F8F8);

  // ========== تدرجات لونية حمراء ==========
  static const Gradient primaryGradient = LinearGradient(
    colors: [darkRed, mediumRed],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient redGradient = LinearGradient(
    colors: [hotRed, hotRed2],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient orangeGradient = LinearGradient(
    colors: [coldOrange, coldOrange2],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient cardGradient = LinearGradient(
    colors: [Colors.white, Color(0xFFF8F8F8)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const Gradient appBarGradient = LinearGradient(
    colors: [hotRed, hotRed2],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const Gradient buttonGradient = LinearGradient(
    colors: [hotRed, Color(0xFFDD3333)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // ========== BoxDecorations ==========
  static const BoxDecoration boxDecoration = BoxDecoration(
    gradient: LinearGradient(
      colors: [hotRed, grey],
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
    ),
  );

  static const BoxDecoration modernBoxDecoration = BoxDecoration(
    gradient: LinearGradient(
      colors: [darkRed, mediumRed, hotRed],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.all(Radius.circular(12)),
    boxShadow: [
      BoxShadow(
        color: shadowColor,
        blurRadius: 10,
        offset: Offset(0, 4),
      ),
    ],
  );

  static BoxDecoration cardDecoration = BoxDecoration(
    color: cardBackground,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: shadowColor,
        blurRadius: 8,
        offset: const Offset(0, 2),
      ),
    ],
    border: Border.all(
      color: lightGray,
      width: 1,
    ),
  );

  static BoxDecoration redCardDecoration = BoxDecoration(
    gradient: redGradient,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: hotRed.withOpacity(0.3),
        blurRadius: 8,
        offset: const Offset(0, 4),
      ),
    ],
  );

  static BoxDecoration buttonDecoration = BoxDecoration(
    gradient: buttonGradient,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: hotRed.withOpacity(0.3),
        blurRadius: 8,
        offset: const Offset(0, 4),
      ),
    ],
  );

  static BoxDecoration outlinedButtonDecoration = BoxDecoration(
    color: Colors.transparent,
    borderRadius: BorderRadius.circular(12),
    border: Border.all(
      color: hotRed,
      width: 2,
    ),
  );

  static BoxDecoration floatingDecoration = BoxDecoration(
    gradient: redGradient,
    borderRadius: BorderRadius.circular(24),
    boxShadow: [
      BoxShadow(
        color: hotRed.withOpacity(0.4),
        blurRadius: 15,
        offset: const Offset(0, 8),
      ),
    ],
  );

  // ========== دوال مساعدة ==========
  static Color getDiscountColor(double discountPercentage) {
    if (discountPercentage >= 50) {
      return hotRed; // أحمر للخصومات الكبيرة
    } else if (discountPercentage >= 30) {
      return Color(0xFFFF9500); // برتقالي للخصومات المتوسطة
    } else if (discountPercentage >= 10) {
      return Color(0xFF34C759); // أخضر للخصومات الصغيرة
    } else {
      return grey;
    }
  }

  static Color getProductStatusColor(int status) {
    switch (status) {
      case 1: // متوفر
        return Color(0xFF34C759); // أخضر
      case 2: // محدود
        return Color(0xFFFF9500); // برتقالي
      case 3: // غير متوفر
        return hotRed; // أحمر
      default:
        return grey;
    }
  }

  static Color getLightRedColor([double opacity = 0.1]) {
    return hotRed.withOpacity(opacity);
  }

  static Color getMediumRedColor([double opacity = 0.7]) {
    return hotRed.withOpacity(opacity);
  }

  static Color getDarkRedColor([double opacity = 0.9]) {
    return hotRed2.withOpacity(opacity);
  }

  static Color getTextColorForBackground(Color backgroundColor) {
    final brightness = ThemeData.estimateBrightnessForColor(backgroundColor);
    return brightness == Brightness.dark ? Colors.white : Colors.black;
  }

  static Color getTextColorForRedBackground() {
    return Colors.white; // نص أبيض على خلفية حمراء
  }

  static Color getTextColorForLightBackground() {
    return textPrimary; // نص داكن على خلفية فاتحة
  }

  // ========== ثيمات جاهزة ==========
  static ThemeData getRedTheme() {
    return ThemeData(
      primaryColor: hotRed,
      primaryColorDark: hotRed2,
      primaryColorLight: Color(0xFFFF6666),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: hotRed,
        secondary: coldOrange2,
      ),
      scaffoldBackgroundColor: backgroundGrey,
      appBarTheme: AppBarTheme(
        backgroundColor: hotRed,
        foregroundColor: Colors.white,
        elevation: 4,
        shadowColor: hotRed.withOpacity(0.3),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: hotRed,
        foregroundColor: Colors.white,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: hotRed,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  // ========== أنماط نص جاهزة ==========
  static TextStyle getRedTitleStyle() {
    return const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: hotRed,
      fontFamily: 'PlayfairDisplay',
    );
  }

  static TextStyle getRedSubtitleStyle() {
    return const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: hotRed2,
      fontFamily: 'Roboto',
    );
  }

  static TextStyle getWhiteTextOnRedStyle() {
    return const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle getPriceStyle({bool isDiscounted = false}) {
    return TextStyle(
      fontSize: isDiscounted ? 14 : 18,
      fontWeight: isDiscounted ? FontWeight.normal : FontWeight.bold,
      color: isDiscounted ? textLight : hotRed,
      decoration: isDiscounted ? TextDecoration.lineThrough : TextDecoration.none,
    );
  }

  static TextStyle getDiscountBadgeStyle() {
    return const TextStyle(
      color: Colors.white,
      fontSize: 12,
      fontWeight: FontWeight.bold,
    );
  }
}