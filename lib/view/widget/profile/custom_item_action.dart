import 'package:flutter/material.dart';

class CustomItemAction extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;

  const CustomItemAction({
    super.key,
    required this.icon,
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color.withOpacity(0.2), color.withOpacity(0.1)],
            ),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: color.withOpacity(0.3), width: 1),
          ),
          child: Icon(icon, color: color, size: 28),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            color: Colors.white70,
            fontSize: 12,
            fontFamily: 'Cairo',
          ),
        ),
      ],
    );
  }
}
