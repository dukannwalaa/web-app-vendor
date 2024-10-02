
import 'package:get/get.dart';
import 'package:vendor/repository/order.dart';
import 'package:vendor/service/notification/notification.dart';
import 'package:vendor/utils/utility.dart';

class OrderService {
  var orderRepository = OrderRepository();

  syncOrdersForVendor(vendorId) async {
    try {
      // 1. Fetch orders from the server
      final serverOrders =
          await orderRepository.fetchAllOrdersByVendorIdFromServer(vendorId);

      // 2. Get all orders from the local database
      final localOrders =
          await orderRepository.fetchAllOrdersByVendorIdFromLocal(vendorId) ??
              [];

      // 3. Compare and update
      for (final serverOrder in serverOrders) {
        final localOrder = localOrders
            .firstWhereOrNull((o) => o.orderId == serverOrder.orderId);

        if (localOrder == null) {
          // New order from server - insert into local DB
          await orderRepository.insertOrderFromLocal(serverOrder);
          NotificationService().newOrderNotificationV(serverOrder);
        } else if (DateTime.fromMillisecondsSinceEpoch(serverOrder.updatedAt!)
            .isAfter(
                DateTime.fromMillisecondsSinceEpoch(localOrder.updatedAt!))) {
          // Server order is newer - update local DB
          await orderRepository.updateOrderFromLocal(serverOrder);
        }
      }

      //4.Delete Local Orders if they are deleted from server
      for (final localOrder in localOrders) {
        final serverOrder = serverOrders
            .firstWhereOrNull((o) => o.orderId == localOrder.orderId);
        if (serverOrder == null) {
          await orderRepository.deleteOrderFromLocal(localOrder);
        }
      }
    } catch (e) {
      // Handle errors (e.g., network issues, database errors)
      kPrint('Error syncing orders: $e');
      // Consider showing an error message to the user or retrying later
    }
  }
}
