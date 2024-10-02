import 'package:get/get.dart';
import 'package:vendor/common/widgets/utility.dart';
import 'package:vendor/model/order.dart';
import 'package:vendor/repository/order.dart';
import 'package:vendor/service/order.dart';
import 'package:vendor/utils/cache_manager.dart';

import '../utils/string_constant.dart';

class DashboardController extends GetxController {
  var orderRepository = OrderRepository();
  List<Order> newOrders = [];
  List<Order> inProcessOrders = [];
  List<Order> completedOrders = [];
  List<Order> otherOrders = [];
  int? initDate;
  var isLoading = false;

  late Order order;

  fetchAllOrdersFromLocal() async {
    var vendorId = CacheManager().readString(key: CacheManager.vendorId) ?? '';
    List<Order>? orders =
    await orderRepository.fetchAllOrdersByVendorIdFromLocal(vendorId);
    updateOrders(orders ?? <Order>[]);
    fetchAllOrdersFromServer();
  }

  fetchAllOrdersFromServer() async {
    isLoading = true;
    update();
    var vendorId = CacheManager().readString(key: CacheManager.vendorId) ?? '';
    try {
      List<Order> orders =
      await orderRepository.fetchAllOrdersByVendorIdFromServer(vendorId);
      updateOrders(orders);
      OrderService().syncOrdersForVendor(vendorId);
    } catch (e) {
      showSnackBar(e.toString());
    } finally {
      isLoading = false;
      update();
    }
  }

  updateOrders(List<Order> orders) {
    newOrders.clear();
    completedOrders.clear();
    inProcessOrders.clear();
    otherOrders.clear();
    for (var order in orders) {
      if (order.orderStatus == StringConstant.orderAwaitingConfirmation) {
        newOrders.add(order);
      } else if (order.orderStatus == StringConstant.orderCompleted) {
        completedOrders.add(order);
      } else if (order.orderStatus == StringConstant.orderInProcess ||
          order.orderStatus == StringConstant.orderOutForDelivery) {
        inProcessOrders.add(order);
      } else {
        otherOrders.add(order);
      }
    }
    isLoading = false;
    update();
  }

  acceptOrder({required Order order}) async {
    newOrders.remove(order);
    var newOrder = order;
    newOrder.orderStatus = StringConstant.orderInProcess;
    newOrder.expectedDeliveryDate = newOrder.expectedDeliveryDate ??
        DateTime.now().add(const Duration(days: 2)).millisecondsSinceEpoch;
    inProcessOrders.add(newOrder);
    update();
    bool res = await upsertOrder(order: order);
    if (res == false) {
      newOrders.add(order);
      inProcessOrders.remove(newOrder);
      update();
      showSnackBar('Order could not accepted, Please try again');
    }
  }

  rejectOrder({required Order order, reason}) async {
    newOrders.remove(order);
    update();
    var newOrder = order;
    newOrder.orderStatus = StringConstant.orderReject;
    newOrder.notes = reason;
    bool res = await upsertOrder(order: order);
    if (res == false) {
      newOrders.add(order);
      update();
      showSnackBar('Order could not rejected, Please try again');
    }
  }

  outForDeliveryOrder({required Order order}) async {
    order.orderStatus = StringConstant.orderOutForDelivery;
    update();
    bool res = await upsertOrder(order: order);
    if (res == false) {
      order.orderStatus = StringConstant.orderInProcess;
      update();
      showSnackBar(
          'Order could not update to Out for delivery , Please try again');
    }
  }

  packedOrder({required Order order}) async {
    order.orderStatus = StringConstant.orderPacked;
    update();
    bool res = await upsertOrder(order: order);
    if (res == false) {
      order.orderStatus = StringConstant.orderInProcess;
      update();
      showSnackBar('Order could not update to Packed , Please try again');
    }
  }

  delayedOrder({required Order order}) async {
    order.orderStatus = StringConstant.orderDelayed;
    update();
    bool res = await upsertOrder(order: order);
    if (res == false) {
      order.orderStatus = StringConstant.orderInProcess;
      update();
      showSnackBar('Order could not update to Delayed , Please try again');
    }
  }

  completeOrder({required Order order}) async {
    inProcessOrders.remove(order);
    var newOrder = order;
    newOrder.orderStatus = StringConstant.orderCompleted;
    newOrder.updatedAt = DateTime.now().millisecondsSinceEpoch;
    newOrder.deliveredDate = DateTime.now().millisecondsSinceEpoch;
    completedOrders.add(newOrder);
    update();
    bool res = await upsertOrder(order: order);
    if (res == false) {
      inProcessOrders.add(order);
      completedOrders.remove(newOrder);
      update();
      showSnackBar('Order could not completed, Please try again');
    }
  }


  Future<bool> upsertOrder({order}) async {
    try {
      var result = await orderRepository.upsertOrderFromServer(order: order);
      if (result) orderRepository.updateOrderFromLocal(order);
      return result;
    } catch (e) {
      // showSnackBar(e.toString());
      return false;
    }
  }

  bool isNoOrders() =>
      newOrders.isNotEmpty ||
          inProcessOrders.isNotEmpty ||
          completedOrders.isNotEmpty;
}