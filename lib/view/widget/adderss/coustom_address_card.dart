import 'package:e_commerce/core/constant/color.dart';
import 'package:e_commerce/view/widget/adderss/custom_address_detail_row.dart';
import 'package:e_commerce/view/widget/adderss/custom_elevated_button.dart';
import 'package:flutter/material.dart';

class CustomAddressCard extends StatelessWidget {
  final void Function() onEdit;
  final void Function() onDelete;
  final void Function() onTap;
  final String titleAddress;
  final String subTitleAddress;
  final String street;
  final String city;
  final String country;
  final String phoneNumber;

   const CustomAddressCard({
    super.key,
    required this.onEdit,
    required this.onDelete,
    required this.onTap,
    required this.titleAddress,
    required this.subTitleAddress,
    required this.street,
    required this.city,
    required this.country,
    required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              spreadRadius: 0.5,
              blurRadius: 10,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColor.hotRed.withAlpha(51),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.location_on_rounded,
                      color: Colors.red,
                      size: 26,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          titleAddress,
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent,
                            fontSize: 18,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow
                              .ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subTitleAddress,
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Divider(height: 25, color: AppColor.hotRed),
              CustomAddressDetailRow(icon: Icons.home_outlined, text: street, isPhone: false),
              CustomAddressDetailRow(icon: Icons.location_city_outlined, text: city, isPhone: false),
              CustomAddressDetailRow(icon: Icons.public, text: country, isPhone: false),
              const SizedBox(height: 10),
              const Divider(height: 5, color: AppColor.hotRed),
              CustomAddressDetailRow(icon: Icons.phone, text: phoneNumber, isPhone: true),
              const SizedBox(height: 5),
             CustomElevatedButton(onEdit: onEdit, onDelete: onDelete)
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAddressDetailRow(
    BuildContext context,
    IconData icon,
    String text, {
    bool isPhone = false,
  }) {
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
