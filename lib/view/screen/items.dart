import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/controller/items_controller.dart';
import 'package:e_commerce/core/class/handlingdata.dart';
import 'package:e_commerce/core/constant/color.dart';
import 'package:e_commerce/data/model/items_model.dart';
import 'package:e_commerce/linkapi.dart';
import 'package:e_commerce/view/widget/custom_appbar.dart';
import 'package:e_commerce/view/widget/custom_popupmenuitem_appbar.dart';
import 'package:e_commerce/view/widget/items/custom_list_items.dart';
import 'package:e_commerce/view/widget/items/list_categories_items.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Items extends StatelessWidget {
  const Items({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ItemsControllerImp());

    return Scaffold(
      drawer: CustomSideMenu(),

      backgroundColor: AppColor.background,
      body: GetBuilder<ItemsControllerImp>(
        builder: (controller) => Container(
          padding: EdgeInsets.all(5),
          child: ListView(
            children: [
              CustomAppbar(
                isSearch: true,

                titleAppbar: "titleAppbar".tr,
                onPressedIconSearch: () {
                  controller.onSearch();
                },
                onPressedIconAction: () {
                  Get.back();
                },
                iconAction: Icons.arrow_back_ios,
                onChanged: (val) {
                  controller.checkSearch(val);
                },
                textEditingController: controller.search!,
              ),
              controller.isSearch
                  ? HandlingDataView(
                      statusRequest: controller.statusRequest,
                      widget: ListItemsSearch(
                        listDataModel: controller.listDataSearch,
                      ),
                    )
                  : Column(
                      children: [
                        SizedBox(height: 20),
                        ListCategoriesItems(),
                        GetBuilder<ItemsControllerImp>(
                          builder: (controller) => HandlingDataView(
                            statusRequest: controller.statusRequest,
                            widget: GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: controller.listItemsData.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 0.75,
                                  ),
                              itemBuilder: (context, index) {
                                return FadeInUp(
                                  duration: Duration(milliseconds: 600),
                                  delay: Duration(milliseconds: 200),
                                  child: CustomListItems(
                                    itemsModel: ItemsModel.fromJson(
                                      controller.listItemsData[index],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class ListItemsSearch extends GetView<ItemsControllerImp> {
  final List<ItemsModel> listDataModel;

  const ListItemsSearch({super.key, required this.listDataModel});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listDataModel.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final item = listDataModel[index];

        return InkWell(
          onTap: () {
            controller.goToPageProductDetails(item);
          },
          borderRadius: BorderRadius.circular(15),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 2),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              color: Colors.white70,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    // الصورة
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImage(
                        imageUrl: "${AppLink.imageItems}/${item.itemsImageURl}",
                        height: 80,
                        width: 80,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error, color: Colors.red),
                      ),
                    ),
                    const SizedBox(width: 20),
                    // النصوص
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.itemsNameEn ?? '',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item.categoriesNameEn ?? '',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "${item.itemsPrice ?? '0'} \$",
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColor.hotRed2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 18,
                      color: AppColor.hotRed,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
