import 'package:floor/floor.dart';
import 'package:vendor/database/database.dart';

class InitDatabase {
  static AppDatabase? appDatabase;

  Future<AppDatabase?> init() async => await $FloorAppDatabase
      .databaseBuilder('app_database.db').build();
}
