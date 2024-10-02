
import 'package:get/get.dart';
import 'package:vendor/bindings/account.dart';
import 'package:vendor/bindings/dashboard.dart';
import 'package:vendor/bindings/login.dart';
import 'package:vendor/bindings/otp.dart';
import 'package:vendor/bindings/splash.dart';
import 'package:vendor/ui/account.dart';
import 'package:vendor/ui/dashboard.dart';
import 'package:vendor/ui/login.dart';
import 'package:vendor/ui/order_detail.dart';
import 'package:vendor/ui/order_list.dart';
import 'package:vendor/ui/splash.dart';


class Routes {
  static const splash = '/splash';
  static const login = '/login';
  static const otp = '/otp';
  static const dashboard = '/dashboard';
  static const account = '/account';
  static const editAccount = '/editAccount';
  static const orderList = '/orderList';
  static const orderDetail = '/orderDetail';


  static final appPages = [
    GetPage(
      name: splash,
      page: () => const Splash(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: login,
      page: () => const Login(),
      binding: LoginBinding(),
    ),

    GetPage(
        name: dashboard,
        page: () => const Dashboard(),
        binding: DashboardBinding(),
        transition: Transition.rightToLeft),
    GetPage(
        name: account,
        page: () => const Account(),
        binding: AccountBinding(),
        transition: Transition.rightToLeft),


    GetPage(
        name: orderList,
        page: () => const OrderList(),
        binding: DashboardBinding(),
        transition: Transition.rightToLeft),
    GetPage(
        name: orderDetail,
        page: () => const OrderDetail(),
        binding: DashboardBinding(),
        transition: Transition.rightToLeft),

  ];
}
