
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vendor/service/order.dart';
import 'package:vendor/utils/string_constant.dart';
import 'package:vendor/utils/utility.dart';
import 'package:workmanager/workmanager.dart';

const String newOrderChecker = 'newOrderChecker';

void initWorkManager() {
  Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
}

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    await dotenv.load(fileName: "assets/.env");
    kPrint('Periodic Task Run');
    try {
      if (task == newOrderChecker) {
        await OrderService().syncOrdersForVendor(inputData?['userId']);
      }
    } catch (e) {
      throw Exception(e);
    }
    return Future.value(true);
  });
}

void scheduleNewOrderChecker(String userId,String userTye,String name) {
  Workmanager().registerPeriodicTask(newOrderChecker, newOrderChecker,
      frequency: const Duration(minutes: 15),
      constraints: Constraints(
          networkType: NetworkType.connected,
          requiresBatteryNotLow: true,
          requiresStorageNotLow: true,
          requiresCharging: false,
          requiresDeviceIdle: false),
      initialDelay: const Duration(minutes: 15),
      inputData: {'userId': userId,'userTye':userTye,'name' : name});
}
