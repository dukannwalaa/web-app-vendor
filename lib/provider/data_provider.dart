import 'package:vendor/database/database.dart';
import 'package:vendor/database/init_database.dart';
import 'package:vendor/database/order_dao.dart';

class DataProvider {
  Future<OrderDao?> getOrderDao() async {
    AppDatabase? appDatabase = await InitDatabase().init();
    return appDatabase?.orderDao;
  }
}
