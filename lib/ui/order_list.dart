
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendor/common/constant/color.dart';
import 'package:vendor/common/widgets/order.dart';
import 'package:vendor/common/widgets/utility.dart';
import 'package:vendor/controller/dashboard_controller.dart';
import 'package:vendor/model/order.dart';
import 'package:vendor/utils/strings.dart';

class OrderList extends GetView<DashboardController> {
  const OrderList({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          appBar: appBar('Order List',
              bottom: TabBar(
                  isScrollable: true,
                  labelColor: MyColor.white,
                  dividerColor: MyColor.white,
                  indicatorColor: MyColor.white,
                  tabs: [
                    Tab(text: Strings().newOrder),
                    Tab(text: Strings().inProcessOrder),
                    Tab(text: Strings().completedOrder),
                    Tab(text: Strings().otherOrder),
                  ])),
          body: GetBuilder<DashboardController>(builder: (context) {
            return controller.isLoading
                ? loadingScreen()
                : RefreshIndicator(
                    onRefresh: () async {
                      await controller.fetchAllOrdersFromServer();
                    },
                    child: TabBarView(
                      children: [
                        _listView(controller.newOrders,
                            orderCategory: Strings().newOrder),
                        _listView(controller.inProcessOrders,
                            orderCategory: Strings().inProcessOrder),
                        _listView(controller.completedOrders,
                            orderCategory: Strings().completedOrder),
                        _listView(controller.otherOrders,
                            orderCategory: Strings().otherOrder),
                      ],
                    ),
                  );
          })),
    );
  }

  Widget _listView(List<Order> orders, {orderCategory}) {
    return orders.isEmpty
        ? noItemFound(itemName: orderCategory,refresh:()=> controller.fetchAllOrdersFromServer())
        : ListView.builder(
            itemCount: orders.length,
            shrinkWrap: true,
            physics: const RangeMaintainingScrollPhysics(),
            itemBuilder: (context, index) => orderCategory == Strings().newOrder
                ? rowVendorNewOrder(
                    orders[index], context, () => controller.update())
                : orderCategory == Strings().inProcessOrder
                    ? rowVendorPendingOrder(
                        orders[index], context, () => controller.update())
                    : orderCategory == Strings().otherOrder
                        ? rowVendorRejectCancelOrder(
                            orders[index], context, () => controller.update())
                        : rowVendorCompletedOrder(
                            orders[index], context, () => controller.update()));
  }
}
