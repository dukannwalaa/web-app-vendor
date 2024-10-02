import 'package:floor/floor.dart';
import 'package:vendor/model/order.dart';

@dao
abstract class OrderDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertOrder(Order order);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertBulkOrders(List<Order> orders);

  @update
  Future<void> updateOrder(Order order);

  @delete
  Future<void> deleteOrder(Order order);

  @Query(
      'UPDATE DWOrder SET orderStatus = :orderStatus WHERE orderId = :orderId')
  Future<void> updateOrderStatus(String orderStatus, String orderId);

  @Query('SELECT * from DWOrder WHERE userId=:userId')
  Future<List<Order>> fetchUserAllOrder(String userId);

  @Query('SELECT * from DWOrder WHERE vendorId=:vendorId')
  Future<List<Order>> fetchVendorAllOrder(String vendorId);

  @Query('SELECT * FROM DWOrder WHERE orderId = :orderId')
  Future<Order?> fetchOrderByOrderId(String orderId);
}
