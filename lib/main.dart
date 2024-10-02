import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:vendor/bindings/splash.dart';
import 'package:vendor/firebase_options.dart';
import 'package:vendor/routes/routes.dart';
import 'package:vendor/service/notification/notification.dart';
import 'package:vendor/utils/work_manager.dart';

Future<void> initServices() async {
  Get.log('starting services ...');
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await dotenv.load(fileName: "assets/.env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseFirestore.instance.settings =
      const Settings(persistenceEnabled: true);
  await NotificationService().initialiseNotificationService();
  initWorkManager();
  Get.log('All services started...');
}

void main() async {
  await initServices();
  runApp(ResponsiveSizer(
      builder: (p0, p1, p2) => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: Routes.splash,
          initialBinding: SplashBinding(),
          getPages: Routes.appPages,
          locale: const Locale('en', 'IN'),
          builder: (context, child) {
            return child!;
          })));
}
