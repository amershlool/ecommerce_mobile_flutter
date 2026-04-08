import 'package:e_commerce/core/constant/color.dart';
import 'package:flutter/material.dart';

class CustomAddressCard extends StatelessWidget {
  final String addressName;
  final String addressCity;
  final String addressPhone;
  final void Function()? onPressed;

  const CustomAddressCard({
    super.key,
    required this.addressName,
    required this.addressCity,
    required this.addressPhone,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.home, size: 30, color: AppColor.hotRed),
      title: Text(addressName, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text("$addressCity, Jordan\n$addressPhone"),
      trailing: TextButton(
        onPressed: onPressed,
        child: const Text("Edit", style: TextStyle(color: AppColor.hotRed2)),
      ),
    );
  }
}
