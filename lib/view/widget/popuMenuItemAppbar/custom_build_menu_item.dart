import 'package:e_commerce/core/constant/color.dart';
import 'package:flutter/material.dart';

class CustomBuildMenuItem extends StatelessWidget {
  final void Function()? onTap;

  final IconData icon;

  final String text;

  final int badgeCount;

  const CustomBuildMenuItem({
    super.key,
    required this.onTap,
    required this.icon,
    required this.text,
    required this.badgeCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(18.0),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18.0),
          splashColor: AppColor.hotRed.withOpacity(0.1),
          highlightColor: AppColor.hotRed.withOpacity(0.05),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            child: Row(
              children: [
                Icon(icon, color: AppColor.hotRed, size: 25.0),

                const SizedBox(width: 16.0),

                // النص
                Expanded(
                  child: Text(
                    text,
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 14.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                ),

                if (badgeCount > 0) ...[
                  Container(
                    padding: const EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.red.withOpacity(0.4),
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                    child: Text(
                      badgeCount > 9 ? "9+" : badgeCount.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ] ,

                const SizedBox(width: 8.0),
                Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: Colors.grey.shade400,
                  size: 16.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
