import 'package:flutter/material.dart';

class CustomMenuItem extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconData icon;
  final void Function()? onTap;

  final Color color;

  const CustomMenuItem({
    super.key,
    required this.title,
    required this.subTitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 50,
        height: 50,

        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withAlpha(20), color.withAlpha(10)],
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Icon(icon, color: color, size: 24),
      ),

      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontFamily: 'Cairo',
        ),
      ),
      subtitle: Text(
        subTitle,
        style: TextStyle(
          color: Colors.white60,
          fontSize: 12,
          fontFamily: 'Cairo',
        ),
      ),
      trailing: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          Icons.arrow_forward_ios_rounded,
          color: Colors.white54,
          size: 16,
        ),
      ),
      onTap: onTap
    );
  }
}
