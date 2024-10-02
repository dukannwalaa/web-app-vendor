
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:vendor/common/constant/color.dart';
import 'package:vendor/common/widgets/order.dart';
import 'package:vendor/common/widgets/texts.dart';
import 'package:vendor/common/widgets/utility.dart';
import 'package:vendor/controller/dashboard_controller.dart';
import 'package:vendor/utils/date.dart';
import 'package:vendor/utils/string_constant.dart';
import 'package:vendor/utils/utility.dart';

class OrderDetail extends GetView<DashboardController> {
  const OrderDetail({super.key});

  @override
  Widget build(BuildContext context) {
    var arguments = Get.arguments;
    if (arguments != null && arguments['order'] != null) {
      controller.order = arguments['order'];
    }
    return Scaffold(
      appBar: appBar('Order Detail'),
      body: SafeArea(
        child: GetBuilder<DashboardController>(builder: (controller) {
          return Container(
            padding: EdgeInsets.all(2.w),
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 1.h,
                      ),
                      orderStatus(controller.order.orderStatus),
                      _items(),
                      _billDetails(),
                      _orderDetails(),
                      SizedBox(
                        height: 10.h,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }



  Widget _items() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      color: MyColor.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.all(1.h),
            child: mediumDynamic(
                '${controller.order.products?.length} items in this order',
                textColor: MyColor.black,
                textSize: 16.sp),
          ),
          Flexible(
            fit: FlexFit.loose,
            child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) =>
                    rowOrderProduct(controller.order.products![index]),
                itemCount: controller.order.products?.length),
          )
        ],
      ),
    );
  }


  Widget _billDetails() {
    return Container(
      color: MyColor.white,
      padding: EdgeInsets.symmetric(vertical: 5.w, horizontal: 2.w),
      margin: EdgeInsets.symmetric(vertical: 3.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          boldDynamic('Bill Details',
              textColor: MyColor.black, textSize: 17.sp),
          SizedBox(height: 1.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              regularDynamic('Mrp', textColor: MyColor.grey46, textSize: 15.sp),
              regularDynamic('₹${controller.order.subTotal}',
                  textSize: 15.sp, textColor: MyColor.grey46),
            ],
          ),
          SizedBox(
            height: 1.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              mediumDynamic('Product Discount',
                  textSize: 15.sp, textColor: MyColor.blueD5),
              mediumDynamic('-₹${controller.order.discount}',
                  textSize: 15.sp, textColor: MyColor.blueD5),
            ],
          ),
          SizedBox(
            height: 1.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              regularDynamic('Delivery Charges',
                  textColor: MyColor.grey46, textSize: 15.sp),
              regularDynamic('+₹${controller.order.deliveryCharge}',
                  textSize: 15.sp, textColor: MyColor.grey46),
            ],
          ),
          SizedBox(
            height: 1.5.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              boldDynamic('Bill Total',
                  textColor: MyColor.black, textSize: 17.sp),
              boldDynamic('₹${controller.order.totalAmount}',
                  textColor: MyColor.black, textSize: 17.sp),
            ],
          ),
        ],
      ),
    );
  }

  Widget _orderDetails() {
    return Container(
      color: MyColor.white,
      padding: EdgeInsets.symmetric(vertical: 5.w, horizontal: 2.w),
      margin: EdgeInsets.symmetric(vertical: 3.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          boldDynamic('Order Details',
              textColor: MyColor.black, textSize: 17.sp),
          SizedBox(height: 1.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              mediumDynamic('Order id',
                  textColor: MyColor.grey81, textSize: 15.sp),
              SizedBox(
                height: 1.w,
              ),
              regularDynamic('${controller.order.orderId}',
                  textSize: 14.sp, textColor: MyColor.black),
            ],
          ),
          SizedBox(
            height: 2.h,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              mediumDynamic('Payment',
                  textColor: MyColor.grey81, textSize: 15.sp),
              SizedBox(
                height: 1.w,
              ),
              regularDynamic('COD', textSize: 14.sp, textColor: MyColor.black),
            ],
          ),
          SizedBox(
            height: 2.h,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              mediumDynamic('Deliver to',
                  textColor: MyColor.grey81, textSize: 15.sp),
              SizedBox(
                height: 1.w,
              ),
              regularDynamic('${controller.order.address?.replaceAll('@', '')}',
                  textSize: 14.sp, textColor: MyColor.black),
            ],
          ),
          SizedBox(
            height: 2.h,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              mediumDynamic('Order placed',
                  textColor: MyColor.grey81, textSize: 15.sp),
              SizedBox(
                height: 1.w,
              ),
              regularDynamic(
                  'placed on ${toDateFromTimeStamp(controller.order.createdAt ?? 0, format: 'EE, dd MMM yy, hh:mm a')}',
                  textSize: 14.sp,
                  textColor: MyColor.black),
            ],
          ),
        ],
      ),
    );
  }

  Widget orderStatus(status) {
    String statusName = getOrderStatusName(status);
    String title = '';
    String subTitle = '';
    Color textColor = MyColor.green3E;
    Widget? icon = Icon(Icons.check_circle, color: MyColor.green3E, size: 5.w);

    if (StringConstant.orderInProcess == status ||
        StringConstant.orderPacked == status) {
      title = 'Order ${statusName.toLowerCase()}';
      subTitle = statusName.toLowerCase();
      icon = Icon(Icons.telegram_sharp, color: MyColor.green3E, size: 5.w);
    } else if (StringConstant.orderCompleted == status) {
      textColor = MyColor.black;
      title = 'Order Successfully Delivered';
      subTitle =
      'Delivered on ${toDateFromTimeStamp(controller.order.deliveredDate ?? 0, format: 'EE, dd MMM yy')}';
    } else if (StringConstant.orderCancelled == status ||
        StringConstant.orderReject == status) {
      textColor = MyColor.red49;
      icon = const SizedBox();
      title = 'Order ${statusName.toLowerCase()}';
      subTitle =
      '${statusName.toLowerCase()} on ${toDateFromTimeStamp(controller.order.updatedAt ?? 0, format: 'EE, dd MMM yy').toLowerCase()}';
    } else if (StringConstant.orderOutForDelivery == status) {
      textColor = MyColor.green3E;
      icon =
          Icon(Icons.access_alarms_outlined, color: MyColor.green3E, size: 5.w);
      title = 'Order is ${statusName.toLowerCase()}';
      subTitle =
      '${statusName.toLowerCase()} on ${toDateFromTimeStamp(controller.order.updatedAt ?? 0, format: 'EE, dd MMM yy').toLowerCase()}';
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 2.w),
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
      color: MyColor.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              icon,
              SizedBox(width: 1.w),
              boldDynamic(title, textColor: textColor, textSize: 16.sp)
            ],
          ),
          SizedBox(height: 1.w),
          regularDynamic(subTitle, textSize: 15.sp, textColor: MyColor.grey75),
          // SizedBox(height: 1.h),
          Visibility(
            visible: StringConstant.orderCompleted == status,
            child: Row(
              children: [
                mediumDynamic('Download Invoice',
                    textSize: 16.sp, textColor: MyColor.green3E),
                const Icon(
                  Icons.arrow_drop_down_outlined,
                  color: MyColor.green3E,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
