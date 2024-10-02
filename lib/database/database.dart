import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:vendor/database/order_dao.dart';
import 'package:vendor/model/order.dart';
import 'package:vendor/utils/type_converter.dart';

part 'database.g.dart';

@TypeConverters([
  SummaryTypeConverter,
])
@Database(version: 1, entities: [ Order])
abstract class AppDatabase extends FloorDatabase {


  OrderDao get orderDao;
}
