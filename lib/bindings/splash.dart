import 'package:get/get.dart';
import 'package:vendor/controller/splash.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController());
  }

}