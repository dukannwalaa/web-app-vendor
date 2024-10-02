
import 'package:get/get.dart';
import 'package:vendor/model/order.dart';
import 'package:vendor/provider/api_provider.dart';
import 'package:vendor/provider/data_provider.dart';

class OrderRepository {
  // From Local DB
  Future<List<Order>?> fetchAllOrdersByVendorIdFromLocal(vendorId) async {
    var orderDao = await DataProvider().getOrderDao();
    return await orderDao?.fetchVendorAllOrder(vendorId);
  }

  Future<Order?> fetchOrderByOrderIdFromLocal(orderId) async {
    var orderDao = await DataProvider().getOrderDao();
    return await orderDao?.fetchOrderByOrderId(orderId);
  }

  Future<void> updateOrderFromLocal(Order order) async {
    var orderDao = await DataProvider().getOrderDao();
    return await orderDao?.updateOrder(order);
  }

  Future<void> insertOrderFromLocal(Order order) async {
    var orderDao = await DataProvider().getOrderDao();
    return await orderDao?.insertOrder(order);
  }

  Future<void> insertBulkOrdersFromLocal(List<Order> orders) async {
    var orderDao = await DataProvider().getOrderDao();
    return await orderDao?.insertBulkOrders(orders);
  }

  Future<void> deleteOrderFromLocal(Order order) async {
    var orderDao = await DataProvider().getOrderDao();
    return await orderDao?.deleteOrder(order);
  }
  // ===========================================================================


  // From Server
  Future<List<Order>> fetchAllOrdersByVendorIdFromServer(String vendorId) async {
    var apiProvider = Get.put(APIProvider());
    return await apiProvider.fetchOrdersByVendorId(vendorId);
  }

  Future<bool> upsertOrderFromServer({order}) async {
    var apiProvider = Get.put(APIProvider());
    return await apiProvider.upsertOrder(order:order);
  }
}
