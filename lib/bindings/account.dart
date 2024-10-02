import 'package:get/get.dart';
import 'package:vendor/controller/account.dart';

class AccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AccountController());
  }
}
