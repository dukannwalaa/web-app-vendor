
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:vendor/common/constant/color.dart';
import 'package:vendor/common/widgets/image.dart';
import 'package:vendor/common/widgets/texts.dart';
import 'package:vendor/common/widgets/utility.dart';
import 'package:vendor/controller/account.dart';
import 'package:vendor/routes/routes.dart';
import 'package:vendor/utils/alert_box.dart';
import 'package:vendor/utils/utility.dart';

class Account extends GetView<AccountController> {
  const Account({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: appBar('Account'),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
          child: GetBuilder<AccountController>(builder: (context) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  boldDynamic('Your account', textSize: 18.sp),
                  SizedBox(height: 2.h),
                  mediumDynamic(
                    '+91 ${controller.vendor?.mobile ?? ''}',
                      textSize: 15.sp, textColor: MyColor.grey5C
                  ),
                  mediumDynamic(controller.vendor?.businessName ?? '',
                      textSize: 15.sp, textColor: MyColor.grey5C),
                  mediumDynamic(controller.vendor?.name ?? '',
                      textSize: 15.sp, textColor: MyColor.grey5C),
                  mediumDynamic(controller.vendor?.email ?? '',  textSize: 15.sp, textColor: MyColor.grey5C),

                  SizedBox(
                    height: 3.h,
                  ),
                  mediumDynamic('YOUR INFORMATION',
                      textColor: MyColor.greyCa, textSize: 14.sp),
                  _accountRow('Your orders', () {
                    Get.toNamed(Routes.orderList);
                  }, 'ic_document'),
                  _accountRow('Share customer app', () {}, 'ic_share'),
                  _accountRow('Contact Us', () {}, 'ic_safety'),
                  _accountRow('About us', () {}, 'ic_safety'),

                  _accountRow('Log out', () {
                    alertBoxConfirmation(
                        title: 'Logout',
                        yes: () {
                          logout();
                        });
                  }, 'ic_exit'),
                  SizedBox(
                    height: 2.h,
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  _accountRow(name, onClick, fileName) => Container(
    margin: EdgeInsets.only(top: 1.w),
    child: InkWell(
      onTap: onClick,
      child: Container(
        padding: EdgeInsets.all(2.w),
        child: Row(
          children: [
            Container(
              width: 8.w,
              height: 8.w,
              padding: EdgeInsets.all(2.w),
              decoration: BoxDecoration(
                  color: MyColor.greyF9,
                  borderRadius: BorderRadius.circular(5.w)),
              child:
              loadSvgAsset(fileName: fileName, width: 3.w, height: 3.w),
            ),
            SizedBox(
              width: 3.w,
            ),
            mediumDynamic(name,
                textSize: 15.sp, textColor: MyColor.black36),
          ],
        ),
      ),
    ),
  );
}
