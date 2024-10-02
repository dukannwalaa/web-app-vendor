import 'package:get/get.dart';
import 'package:vendor/controller/login.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }
}
