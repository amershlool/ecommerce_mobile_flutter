import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/core/constant/color.dart';
import 'package:e_commerce/linkapi.dart';
import 'package:flutter/material.dart';

class CustomCardList extends StatelessWidget {
  final String nameItems;

  final String priceAfterDic;

  final String countItems;
  final String imageName;

  final void Function()? iconAdd;

  final void Function()? iconRemove;

  const CustomCardList({
    super.key,
    required this.nameItems,
    required this.priceAfterDic,
    required this.countItems,
    required this.iconAdd,
    required this.iconRemove,
    required this.imageName,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: 100,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: CachedNetworkImage(
                  imageUrl: "${AppLink.imageItems}/$imageName",
                  height: 90,
                  // fit: BoxFit.cover,
                ),
              ),
              Expanded(
                flex: 3,
                child: ListTile(
                  title: Text(
                    nameItems,
                    style: TextStyle(
                      fontFamily: 'PlayfairDisplay',
                      fontSize: 18,
                    ),
                  ),
                  subtitle: Text(
                    "$priceAfterDic \$",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColor.hotRed,
                    ),
                  ),
                ),
              ),
              VerticalDivider(
                color: Colors.grey,
                thickness: 1,
                indent: 10,
                endIndent: 10,
                width: 20,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 25,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        iconSize: 20,
                        onPressed: iconAdd,
                        icon: Icon(
                          Icons.add_circle_outline_sharp,
                          color: Colors.green,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      countItems,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 5),

                    SizedBox(
                      height: 25,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        iconSize: 20,
                        onPressed: iconRemove,
                        icon: Icon(
                          Icons.remove_circle_outline_sharp,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
