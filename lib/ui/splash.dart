import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:vendor/common/constant/color.dart';
import 'package:vendor/common/widgets/image.dart';
import 'package:vendor/common/widgets/utility.dart';
import 'package:vendor/model/vendor.dart';
import 'package:vendor/provider/firestore_db.dart';
import 'package:vendor/routes/routes.dart';
import 'package:vendor/utils/cache_manager.dart';
import 'package:vendor/utils/string_constant.dart';
import 'package:vendor/utils/utility.dart';
import 'package:vendor/utils/work_manager.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 2),
      () {
        var cacheManager = CacheManager();
        if (cacheManager.hasData(CacheManager.vendorId)) {
          toVendorDashboard();
        } else {
          Get.offAndToNamed(Routes.login);
        }
      },
    );

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: MyColor.yellowGradient),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
                tag: 'ImageHero',
                child: loadPngAsset(fileName: 'app_logo', height: 15.h)),
          ],
        )),
      ),
    );
  }

  toVendorDashboard() async {
    var vendorId = CacheManager().readString(key: CacheManager.vendorId) ?? "";
    Vendor? vendor = await FireStoreDB().getVendorById(vendorId);

    if (vendor?.active == true) {
      scheduleNewOrderChecker(vendor?.id ?? '', StringConstant.vendor,
          CacheManager().readString(key: CacheManager.selectedVendorId) ?? '');
      Get.offNamed(Routes.dashboard);
    } else {
      logout();
      showSnackBar('You are blocked. Contact to DW');
      //Send to User Status Screen
    }
  }
}
