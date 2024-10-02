
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:vendor/common/constant/color.dart';
import 'package:vendor/common/widgets/buttons.dart';
import 'package:vendor/common/widgets/image.dart';
import 'package:vendor/common/widgets/texts.dart';
import 'package:vendor/controller/login.dart';
import 'package:vendor/utils/strings.dart';

class Login extends GetView<LoginController> {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: MyColor.yellowGradient),
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 15.h,
                ),
                Hero(
                    tag: 'ImageHero',
                    child: loadPngAsset(fileName: 'app_logo', height: 15.h)),
                SizedBox(
                  height: 5.h,
                ),
                medium20(Strings().welcome, textColor: MyColor.black),
                SizedBox(
                  height: 3.h,
                ),
                flatButtonMedium(
                    Strings().loginOrSignup,
                    fontSize: 18.sp,
                    width: 80.w,
                    height: 6.h,
                    bgColor: MyColor.yellow1C,
                    textColor: MyColor.black,
                    borderRadius: 1.w,
                    () async => {controller.onLoginSuccess('')}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
