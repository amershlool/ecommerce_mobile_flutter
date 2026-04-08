import 'package:e_commerce/controller/address_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomCardSwitch extends StatelessWidget {
  const CustomCardSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: const [
                  Icon(
                    Icons.location_on_outlined,
                    color: Colors.redAccent,
                    size: 28,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Use GPS Location",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Automatically detect your current location",
                          style: TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            GetBuilder<AddressControllerImp>(
              builder: (controller) {
                return Switch(
                  value: controller.useGps,
                  activeColor: Colors.white,
                  activeTrackColor: Colors.redAccent,
                  inactiveThumbColor: Colors.grey[300],
                  inactiveTrackColor: Colors.grey[400],
                  onChanged: (val) {
                    controller.toggleGps(val);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
