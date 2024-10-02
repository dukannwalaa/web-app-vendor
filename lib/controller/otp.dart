import 'package:get/get.dart';


class OtpController extends GetxController {
  var mobileNumber = '';
  // var _verificationId = '';
  var otpCode = ''.obs;
  var isLoading = false.obs;
  // var userRepository = UserRepository();

  Future<void> verifyOtp(String smsCode) async {

  }

  @override
  void onInit() {
    super.onInit();
    mobileNumber = Get.arguments['mobileNumber'];
    // _verificationId = Get.arguments['verificationId'];
    listenOtp();
  }

  listenOtp() async {
    // await SmsAutoFill().listenForCode();
  }

  @override
  void dispose() {
    // SmsAutoFill().unregisterListener();
    super.dispose();
  }
}
