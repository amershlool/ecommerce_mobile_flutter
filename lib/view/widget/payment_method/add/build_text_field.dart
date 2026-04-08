import 'package:e_commerce/core/constant/color.dart';
import 'package:flutter/material.dart';

class BuildTextField extends StatelessWidget {
  final String label;
  VoidCallback? onFocus;
  VoidCallback? onUnfocus;
  final bool obscureText;
  final IconData icon;
 final int? maxLength ;
  final String hintText;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;

  BuildTextField({
    super.key,
    required this.label,
    this.onFocus,
    this.onUnfocus,
    required this.obscureText,
    required this.hintText,
    required this.icon,
    required this.onChanged,
    required this.validator,
     this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColor.hotRed,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              '*',
              style: TextStyle(
                color: AppColor.hotRed,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.red[300]!),
            color: Colors.grey[50],
          ),
          child: Focus(
            onFocusChange: (hasFocus) {
              if (hasFocus) {
                if (onFocus != null) onFocus!();
              } else {
                if (onUnfocus != null) onUnfocus!();
              }
            },
            child: TextFormField(
              maxLength: maxLength,
              obscureText: obscureText,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: TextStyle(color: Colors.grey[500]),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                suffixIcon: Icon(icon, color: Colors.grey[400]),
              ),
              onChanged: onChanged,
              validator: validator,
            ),
          ),
        ),
      ],
    );
  }
}
