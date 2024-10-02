import 'package:get/get.dart';
import 'package:vendor/controller/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => DashboardController(),
    );
  }
}
