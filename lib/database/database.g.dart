// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  OrderDao? _orderDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `DWOrder` (`orderId` TEXT, `userId` TEXT, `products` TEXT, `subTotal` REAL, `deliveryCharge` REAL, `discount` REAL, `totalAmount` REAL, `cod` INTEGER, `createdAt` INTEGER, `orderStatus` TEXT, `name` TEXT, `address` TEXT, `mobile` TEXT, `expectedDeliveryDate` INTEGER, `deliveredDate` INTEGER, `notes` TEXT, `updatedAt` INTEGER, `vendorId` TEXT, `platformFee` INTEGER, PRIMARY KEY (`orderId`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  OrderDao get orderDao {
    return _orderDaoInstance ??= _$OrderDao(database, changeListener);
  }
}

class _$OrderDao extends OrderDao {
  _$OrderDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _orderInsertionAdapter = InsertionAdapter(
            database,
            'DWOrder',
            (Order item) => <String, Object?>{
                  'orderId': item.orderId,
                  'userId': item.userId,
                  'products': _summaryTypeConverter.encode(item.products),
                  'subTotal': item.subTotal,
                  'deliveryCharge': item.deliveryCharge,
                  'discount': item.discount,
                  'totalAmount': item.totalAmount,
                  'cod': item.cod == null ? null : (item.cod! ? 1 : 0),
                  'createdAt': item.createdAt,
                  'orderStatus': item.orderStatus,
                  'name': item.name,
                  'address': item.address,
                  'mobile': item.mobile,
                  'expectedDeliveryDate': item.expectedDeliveryDate,
                  'deliveredDate': item.deliveredDate,
                  'notes': item.notes,
                  'updatedAt': item.updatedAt,
                  'vendorId': item.vendorId,
                  'platformFee': item.platformFee
                }),
        _orderUpdateAdapter = UpdateAdapter(
            database,
            'DWOrder',
            ['orderId'],
            (Order item) => <String, Object?>{
                  'orderId': item.orderId,
                  'userId': item.userId,
                  'products': _summaryTypeConverter.encode(item.products),
                  'subTotal': item.subTotal,
                  'deliveryCharge': item.deliveryCharge,
                  'discount': item.discount,
                  'totalAmount': item.totalAmount,
                  'cod': item.cod == null ? null : (item.cod! ? 1 : 0),
                  'createdAt': item.createdAt,
                  'orderStatus': item.orderStatus,
                  'name': item.name,
                  'address': item.address,
                  'mobile': item.mobile,
                  'expectedDeliveryDate': item.expectedDeliveryDate,
                  'deliveredDate': item.deliveredDate,
                  'notes': item.notes,
                  'updatedAt': item.updatedAt,
                  'vendorId': item.vendorId,
                  'platformFee': item.platformFee
                }),
        _orderDeletionAdapter = DeletionAdapter(
            database,
            'DWOrder',
            ['orderId'],
            (Order item) => <String, Object?>{
                  'orderId': item.orderId,
                  'userId': item.userId,
                  'products': _summaryTypeConverter.encode(item.products),
                  'subTotal': item.subTotal,
                  'deliveryCharge': item.deliveryCharge,
                  'discount': item.discount,
                  'totalAmount': item.totalAmount,
                  'cod': item.cod == null ? null : (item.cod! ? 1 : 0),
                  'createdAt': item.createdAt,
                  'orderStatus': item.orderStatus,
                  'name': item.name,
                  'address': item.address,
                  'mobile': item.mobile,
                  'expectedDeliveryDate': item.expectedDeliveryDate,
                  'deliveredDate': item.deliveredDate,
                  'notes': item.notes,
                  'updatedAt': item.updatedAt,
                  'vendorId': item.vendorId,
                  'platformFee': item.platformFee
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Order> _orderInsertionAdapter;

  final UpdateAdapter<Order> _orderUpdateAdapter;

  final DeletionAdapter<Order> _orderDeletionAdapter;

  @override
  Future<void> updateOrderStatus(
    String orderStatus,
    String orderId,
  ) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE DWOrder SET orderStatus = ?1 WHERE orderId = ?2',
        arguments: [orderStatus, orderId]);
  }

  @override
  Future<List<Order>> fetchUserAllOrder(String userId) async {
    return _queryAdapter.queryList('SELECT * from DWOrder WHERE userId=?1',
        mapper: (Map<String, Object?> row) => Order(
            orderId: row['orderId'] as String?,
            userId: row['userId'] as String?,
            products: _summaryTypeConverter.decode(row['products'] as String),
            subTotal: row['subTotal'] as double?,
            deliveryCharge: row['deliveryCharge'] as double?,
            discount: row['discount'] as double?,
            totalAmount: row['totalAmount'] as double?,
            cod: row['cod'] == null ? null : (row['cod'] as int) != 0,
            createdAt: row['createdAt'] as int?,
            orderStatus: row['orderStatus'] as String?,
            name: row['name'] as String?,
            mobile: row['mobile'] as String?,
            address: row['address'] as String?,
            expectedDeliveryDate: row['expectedDeliveryDate'] as int?,
            deliveredDate: row['deliveredDate'] as int?,
            notes: row['notes'] as String?,
            updatedAt: row['updatedAt'] as int?,
            vendorId: row['vendorId'] as String?,
            platformFee: row['platformFee'] as int?),
        arguments: [userId]);
  }

  @override
  Future<List<Order>> fetchVendorAllOrder(String vendorId) async {
    return _queryAdapter.queryList('SELECT * from DWOrder WHERE vendorId=?1',
        mapper: (Map<String, Object?> row) => Order(
            orderId: row['orderId'] as String?,
            userId: row['userId'] as String?,
            products: _summaryTypeConverter.decode(row['products'] as String),
            subTotal: row['subTotal'] as double?,
            deliveryCharge: row['deliveryCharge'] as double?,
            discount: row['discount'] as double?,
            totalAmount: row['totalAmount'] as double?,
            cod: row['cod'] == null ? null : (row['cod'] as int) != 0,
            createdAt: row['createdAt'] as int?,
            orderStatus: row['orderStatus'] as String?,
            name: row['name'] as String?,
            mobile: row['mobile'] as String?,
            address: row['address'] as String?,
            expectedDeliveryDate: row['expectedDeliveryDate'] as int?,
            deliveredDate: row['deliveredDate'] as int?,
            notes: row['notes'] as String?,
            updatedAt: row['updatedAt'] as int?,
            vendorId: row['vendorId'] as String?,
            platformFee: row['platformFee'] as int?),
        arguments: [vendorId]);
  }

  @override
  Future<Order?> fetchOrderByOrderId(String orderId) async {
    return _queryAdapter.query('SELECT * FROM DWOrder WHERE orderId = ?1',
        mapper: (Map<String, Object?> row) => Order(
            orderId: row['orderId'] as String?,
            userId: row['userId'] as String?,
            products: _summaryTypeConverter.decode(row['products'] as String),
            subTotal: row['subTotal'] as double?,
            deliveryCharge: row['deliveryCharge'] as double?,
            discount: row['discount'] as double?,
            totalAmount: row['totalAmount'] as double?,
            cod: row['cod'] == null ? null : (row['cod'] as int) != 0,
            createdAt: row['createdAt'] as int?,
            orderStatus: row['orderStatus'] as String?,
            name: row['name'] as String?,
            mobile: row['mobile'] as String?,
            address: row['address'] as String?,
            expectedDeliveryDate: row['expectedDeliveryDate'] as int?,
            deliveredDate: row['deliveredDate'] as int?,
            notes: row['notes'] as String?,
            updatedAt: row['updatedAt'] as int?,
            vendorId: row['vendorId'] as String?,
            platformFee: row['platformFee'] as int?),
        arguments: [orderId]);
  }

  @override
  Future<void> insertOrder(Order order) async {
    await _orderInsertionAdapter.insert(order, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertBulkOrders(List<Order> orders) async {
    await _orderInsertionAdapter.insertList(orders, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateOrder(Order order) async {
    await _orderUpdateAdapter.update(order, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteOrder(Order order) async {
    await _orderDeletionAdapter.delete(order);
  }
}

// ignore_for_file: unused_element
final _summaryTypeConverter = SummaryTypeConverter();
