import 'package:get/get.dart';
import 'package:vendor/controller/otp.dart';

class OtpBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => OtpController());
  }

}