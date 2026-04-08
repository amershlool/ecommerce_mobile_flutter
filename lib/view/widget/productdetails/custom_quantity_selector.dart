import 'package:e_commerce/core/constant/color.dart';
import 'package:flutter/material.dart';

class CustomQuantitySelector extends StatelessWidget {
  final void Function() addQuantity;

  final void Function() removeQuantity;

  final String title;

  final int count;

  const CustomQuantitySelector({
    super.key,
    required this.addQuantity,
    required this.removeQuantity,
    required this.title,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColor.darkGray,
          ),
        ),
        SizedBox(height: 10),
        Row(
          children: [
            buildQuantityButton(Icons.remove, removeQuantity),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                count.toString(),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            buildQuantityButton(Icons.add, addQuantity),
          ],
        ),
      ],
    );
  }
}

Widget buildQuantityButton(IconData icon, VoidCallback onPressed) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.grey,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.grey),
    ),
    child: IconButton(
      icon: Icon(icon, color: AppColor.darkGray),
      onPressed: onPressed,
    ),
  );
}
