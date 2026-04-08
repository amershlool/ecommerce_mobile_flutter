import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final void Function() onEdit ;
  final void Function() onDelete ;
  const CustomElevatedButton({super.key, required this.onEdit, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: onEdit,
            icon: Icon(
              Icons.edit_outlined,
              color: Colors.black54,
              size: 20,
            ),
            label: Text(
              'Edit',
              style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                fontFamily: 'PlayfairDisplay',
                fontSize: 18,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFFFCC80),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(vertical: 5),
              elevation: 3,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: onDelete,
            icon: Icon(
              Icons.delete_outline,
              color: Colors.white,
              size: 18,
            ),
            label: Text(
              'Delete',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'PlayfairDisplay',
                fontSize: 18,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFD32F2F),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(vertical: 5),
              elevation: 3,
            ),
          ),
        ),
      ],
    );
  }
}
