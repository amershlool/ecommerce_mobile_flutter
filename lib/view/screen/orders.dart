import 'package:e_commerce/controller/orders/refresh_all_page_controller.dart';
import 'package:e_commerce/controller/orders/view_all_controller.dart';
import 'package:e_commerce/controller/orders/view_await_approve_controller.dart';
import 'package:e_commerce/controller/orders/view_history_controller.dart';
import 'package:e_commerce/controller/orders/view_order_details_controller.dart';
import 'package:e_commerce/controller/orders/view_progress_controller.dart';
import 'package:e_commerce/controller/orders/view_the_way_controller.dart';
import 'package:e_commerce/view/widget/adderss/coustom_appbar.dart';
import 'package:e_commerce/view/widget/orders/custom_order_list_card_cond_await_approve.dart';
import 'package:e_commerce/view/widget/orders/custom_orders_list_card_cond_all.dart';
import 'package:e_commerce/view/widget/orders/custom_orders_list_card_cond_in_history.dart';
import 'package:e_commerce/view/widget/orders/custom_orders_list_card_cond_in_prog.dart';
import 'package:e_commerce/view/widget/orders/custom_orders_list_card_cond_the_way.dart';
import 'package:e_commerce/view/widget/orders/custom_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Orders extends StatelessWidget {
  const Orders({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(RefreshAllPageControllerImp());
    Get.put(ViewOrderDetailsControllerImp());
    Get.put(ViewAllOrdersControllerImp());
    Get.put(ViewAwaitApproveControllerImp());
    Get.put(ViewProgressOrdersControllerImp());
    Get.put(ViewTheWayOrdersControllerImp());
    Get.put(ViewHistoryOrdersControllerImp());

    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: customAppBar("My Orders", goToHomeIfTrue: true),
        body: Column(
          children: [
            Container(
              color: Colors.white,
              child: CustomTabBar(
                nameTab1: "All",
                nameTab2: "Pending",
                nameTab3: "Processing",
                nameTab4: "Delivery",
                nameTab5: "History",
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: TabBarView(
                children: [
                   CustomOrdersListCardCondAll(),
                  CustomOrderListCardCondAwaitApprove(),
                  CustomOrdersListCardCondInProg(),
                  CustomOrdersListCardCondTheWay(),
                  CustomOrdersListCardCondHistory(isAppBar: false,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
