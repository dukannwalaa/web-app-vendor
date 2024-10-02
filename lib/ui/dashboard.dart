
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:vendor/common/constant/color.dart';
import 'package:vendor/common/widgets/order.dart';
import 'package:vendor/common/widgets/texts.dart';
import 'package:vendor/common/widgets/utility.dart';
import 'package:vendor/controller/dashboard_controller.dart';
import 'package:vendor/model/order.dart';
import 'package:vendor/routes/routes.dart';
import 'package:vendor/utils/cache_manager.dart';
import 'package:vendor/utils/strings.dart';

class Dashboard extends GetView<DashboardController> {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    controller.fetchAllOrdersFromLocal();
    return Scaffold(
      backgroundColor: MyColor.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          InkWell(
            onTap: () {
              Get.toNamed(Routes.orderList);
              // Handle search icon press
            },
            child: Container(
              margin: EdgeInsets.only(right: 2.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.shopping_bag,
                    color: MyColor.black,
                  ),
                  regularDynamic('Orders',
                      textColor: MyColor.black, textSize: 14.sp)
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Get.toNamed(Routes.account);
              // Handle search icon press
            },
            child: Container(
              margin: EdgeInsets.only(right: 2.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.person,
                    color: MyColor.black,
                  ),
                  regularDynamic('Account',
                      textColor: MyColor.black, textSize: 14.sp)
                ],
              ),
            ),
          )
        ],
        centerTitle: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.shopify_outlined,
              color: MyColor.black,
            ),
            regular18(CacheManager().readVendor()?.businessName ?? '',
                textColor: MyColor.black),
          ],
        ),
        backgroundColor: MyColor.white,
      ),
      body: Container(
        padding: EdgeInsets.all(2.w),
        width: double.infinity,
        child: GetBuilder<DashboardController>(
          builder: (controller) => controller.isLoading
              ? loadingScreen()
              : !controller.isNoOrders()
              ? noItemFound(
              itemName: 'Orders',
              refresh: () => controller.fetchAllOrdersFromServer())
              : RefreshIndicator(
            onRefresh: () async {
              await controller.fetchAllOrdersFromServer();
            },
            child: SingleChildScrollView(
                child: Column(
                  children: [
                    _orderView(context, Strings().newOrder,
                        controller.newOrders),
                    _orderView(context, Strings().inProcessOrder,
                        controller.inProcessOrders),
                    _orderView(context, Strings().completedOrder,
                        controller.completedOrders),
                  ],
                )),
          ),
        ),
      ),
    );
  }

  Widget _orderView(context, String orderCategory, List<Order> orders) {
    return Visibility(
      visible: orders.isNotEmpty,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 2.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              boldDynamic('$orderCategory(${orders.length})', textSize: 18.sp),
              InkWell(
                  onTap: () {
                    Get.toNamed(Routes.orderList);
                  },
                  child: mediumDynamic('View All',
                      textSize: 16.sp, decoration: TextDecoration.underline)),
            ],
          ),
          SizedBox(
            height: 1.h,
          ),
          Flexible(
            child: SizedBox(
              height: orderCategory == Strings().completedOrder ? 28.h : 43.h,
              width: double.infinity,
              child: ListView.builder(
                  itemCount: orders.length,
                  shrinkWrap: true,
                  physics: const RangeMaintainingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => orderCategory ==
                      Strings().newOrder
                      ? rowVendorNewOrder(
                      orders[index], context, () => controller.update())
                      : orderCategory == Strings().inProcessOrder
                      ? rowVendorPendingOrder(
                      orders[index], context, () => controller.update())
                      : rowVendorCompletedOrder(orders[index], context,
                          () => controller.update())),
            ),
          ),
        ],
      ),
    );
  }
}
