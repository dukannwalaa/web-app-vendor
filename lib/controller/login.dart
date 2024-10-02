
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:otpless_flutter/otpless_flutter.dart';
import 'package:vendor/common/widgets/utility.dart';
import 'package:vendor/model/vendor.dart';
import 'package:vendor/repository/vendor.dart';
import 'package:vendor/routes/routes.dart';
import 'package:vendor/utils/cache_manager.dart';
import 'package:vendor/utils/string_constant.dart';
import 'package:vendor/utils/work_manager.dart';


class LoginController extends GetxController {
  var vendorRepository = VendorRepository();



  @override
  void onInit() {
    super.onInit();
  }

  openLoginPage() async {
    final otpLess = Otpless();
    var arg = {'appId': dotenv.env['APP_ID'] ?? ''};
    await otpLess.openLoginPage((result) async {
      if (result['data'] != null && result['data']['status'] == 'SUCCESS') {
        await onLoginSuccess(result['data']);
      }
    }, arg);
  }

  onLoginSuccess(response) async {
    var mobile = '9236928255';

      Vendor? vendor = await vendorRepository.fetchVendor(mobile);
      if (vendor != null) {
        CacheManager()
            .writeString(key: CacheManager.vendorId, value: vendor.id);
        CacheManager().writeVendor(vendor);
        Get.offNamed(Routes.dashboard);
        scheduleNewOrderChecker(
            vendor.id ?? '', StringConstant.vendor, vendor.id ?? '');
      } else {
        showSnackBar(
            'You are not register with us as vendor, Please contact to DW');
      }

  }
}
