import 'package:e_commerce/core/constant/color.dart';
import 'package:flutter/material.dart';

class CustomAddressDetailRow extends StatelessWidget {
  final  IconData icon;
  final String text;
final  bool isPhone ;
  const CustomAddressDetailRow({super.key, required this.icon, required this.text, required this.isPhone});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: AppColor.hotRed),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              text,
              style: isPhone
                  ? TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                fontSize: 17,
                fontFamily: 'BalooBhaijaan',
              )
                  : TextStyle(color: AppColor.darkGray),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
