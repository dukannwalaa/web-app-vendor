import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:vendor/common/constant/color.dart';
import 'package:vendor/common/widgets/buttons.dart';
import 'package:vendor/common/widgets/texts.dart';
import 'package:vendor/controller/dashboard_controller.dart';
import 'package:vendor/model/order.dart';

showSnackBar(msg,
    {actionName, actionCallBack, BuildContext? context, duration}) {
  Future(() {
    ScaffoldMessenger.of(context ?? Get.context!).showSnackBar(SnackBar(
        showCloseIcon: true,
        behavior: SnackBarBehavior.floating,
        backgroundColor: MyColor.black,
        elevation: 1,
        duration: Duration(seconds: duration ?? 5),
        closeIconColor: MyColor.white,
        content: regularDynamic(msg, textColor: MyColor.white, textSize: 14.sp),
        action: SnackBarAction(
          label: actionName ?? '',
          onPressed: actionCallBack ?? () => {},
        )));
  });
}

Widget loadingScreen() => const Center(
        child: CircularProgressIndicator(
      color: MyColor.black,
    ));

Widget noItemFound({itemName = 'Product', refresh}) => Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          regular18('No $itemName Found'),
          SizedBox(
            height: 2.h,
          ),
          Visibility(
              visible: refresh != null,
              child: flatButton(
                  width: 50.w, 'Refresh', () => refresh(), borderRadius: 1.h))
        ],
      ),
    );

closeProgressDialog() => Get.back();

AppBar appBar(title, {action, backArrow = true, bottom, centerTitle = true}) =>
    AppBar(
      shadowColor: MyColor.black,
      elevation: 1,
        titleSpacing: 0.0,
        bottom: bottom,
        leading: backArrow
            ? InkWell(
                onTap: () => Get.back(),
                child: Container(
                  padding: EdgeInsets.only(left: 5.w),
                  // color: MyColor.blueEC,
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: MyColor.black,
                    size: 5.w,
                  ),
                ),
              )
            : null,
        leadingWidth: 7.w,
        centerTitle: centerTitle,
        automaticallyImplyLeading: false,
        title: InkWell(
            onTap: () => Get.back(),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal:  3.w),
              // color: Colors.blue,
              child: mediumDynamic(title,
                  textColor: MyColor.black, textSize: 17.sp),
            )),
        backgroundColor: MyColor.white);

Widget orderStatusDropdown({list, required Order order, update}) {
  return DropdownButton<String>(
    value: order.orderStatus,
    icon: const Icon(Icons.arrow_drop_down_outlined),
    elevation: 16,
    isExpanded: true,
    style: regularTextStyle(textColor: MyColor.black),
    underline: Container(height: 0),
    onChanged: (String? value) {
      order.orderStatus = value;
      update();
    },
    items: list.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: boldDynamic(value, textSize: 15.sp),
      );
    }).toList(),
  );
}

Widget orderNotesDropdown({
  required List<String> list,
  required Order order,
}) {
  order.notes = order.notes!.isEmpty ? list.first : order.notes;
  return GetBuilder<DashboardController>(
      id: 'NOTES_BS',
      builder: (controller) {
        return DropdownButton<String>(
          value: order.notes!.isEmpty ? list.first : order.notes,
          isExpanded: true,
          icon: const Icon(Icons.arrow_drop_down_outlined),
          elevation: 16,
          style: regularTextStyle(textColor: MyColor.black),
          underline: Container(height: 0),
          onChanged: (String? value) {
            order.notes = value;
            controller.update(['NOTES_BS']);
          },
          items: list.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: boldDynamic(value, textSize: 16.sp),
            );
          }).toList(),
        );
      });
}
