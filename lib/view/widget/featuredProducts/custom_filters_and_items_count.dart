import 'package:e_commerce/controller/featured_products_controller.dart';
import 'package:e_commerce/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomFiltersAndItemsCount extends StatelessWidget {
  const CustomFiltersAndItemsCount({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FeaturedProductsControllerImp>(
      builder: (controller) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              // Dropdown with improved design
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(16) ,bottomLeft: Radius.circular(16)),
                    color: Colors.grey.shade50,
                    border: Border.all(
                      color: Colors.grey.shade200,
                      width: 1,
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      icon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Colors.grey.shade700,
                        size: 22,
                      ),
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade800,
                        fontWeight: FontWeight.w500,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      dropdownColor: Colors.white,
                      elevation: 4,
                      hint: const Text('Sort by'),
                      items: controller.sortOptions
                          .map(
                            (e) => DropdownMenuItem(
                          value: e,
                          child: Text(
                            e,
                            style: const TextStyle(
                              fontSize: 14,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      )
                          .toList(),
                      onChanged: (value) {
                        print(value);
                      },
                      value: controller.sortOptions.isNotEmpty
                          ? controller.sortOptions[0]
                          : null,
                    ),
                  ),
                ),
              ),


              // Items count with improved design
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColor.hotRed, AppColor.hotRed.withOpacity(0.8)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.only(topRight: Radius.circular(16),bottomRight: Radius.circular(16)),
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.hotRed.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Text(
                  "${controller.data.length} items",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}