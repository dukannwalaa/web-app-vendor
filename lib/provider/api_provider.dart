import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:vendor/model/order.dart';
import 'package:vendor/utils/cache_manager.dart';
import 'package:vendor/utils/strings.dart';
import 'package:vendor/utils/utility.dart';

class APIProvider {
  late Dio dio;
  static const _baseUrl = "";
  static final productListUrl = dotenv.env['PRODUCT_LIST_URL'] ?? '';
  static final orderURL = dotenv.env['ORDER_URL'] ?? '';
  static var countryCode = '+91';

  APIProvider() {
    dio = Dio();
  }

  Future<APIProvider> init() async {
    return this;
  }

  String getBaseURL(String endpoint) {
    return _baseUrl + endpoint;
  }

  Options getOptions() {
    var options = Options(followRedirects: false, headers: {
      'Accept': 'application/json',
    });
    return options;
  }

  Options getAuthOptions() {
    var token = CacheManager().readString(key: CacheManager.vendorId);
    var options = Options(followRedirects: false, headers: {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    });
    return options;
  }

  Future<List<Order>> fetchOrdersByVendorId(String vendorId) async {
    String vId = CacheManager().readString(key: CacheManager.vendorId) ?? '';
    final params = <String, String>{
      'name': vId,
      'vendorId': vendorId,
    };
    kPrint('Getting Order List');
    final response = await makeGetRequest(orderURL, param: params);
    kPrint(response);
    List<Order> orders = [];
    await response.forEach((order) {
      orders.add(Order.fromJson(order));
    });
    return orders;
  }

  Future<bool> upsertOrder({required Order order}) async {
    String vId = CacheManager().readVendor()?.id ?? '';
    final params = <String, dynamic>{
      'vendorId': vId,
      "reqType": "UPSERT_ORDER_STATUS",
      "orderId": order.orderId ?? '',
      "orderStatus": order.orderStatus ?? '',
      "notes": order.notes ?? '',
      "expectedDeliveryDate": order.expectedDeliveryDate,
      "deliveryDate": order.deliveredDate ?? 0
    };

    try {
      final response = await makePostRequest(orderURL,
          options: getOptions(), data: params, param: params);

      kPrint(response);
      List<Order> orders = [];
      response.forEach((order) {
        orders.add(Order.fromJson(order));
      });
      return true;
    } catch (e) {
      if (e.toString().contains('302')) {
        return true;
      }
      rethrow;
    }
  }

  Future<dynamic> makeGetRequest(String url, {param}) async {
    try {
      final response = await dio
          .get(url, queryParameters: param)
          .timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        kPrint(response);
        if (response.data['status'] == 'success') {
          kPrint(response.data['message']);
          return response.data['data'];
        } else {
          throw ('No data is found');
        }
      }
    } on DioException catch (e) {
      kPrint(e.type);
      kPrint(e.message);
      if (e.type == DioExceptionType.unknown) {
        throw (Strings().somethingWentWrongPlTryAgain);
      } else if (e.type == DioExceptionType.connectionTimeout) {
        throw (Strings().requestTimeOut);
      } else if (e.type == DioExceptionType.connectionError) {
        throw (Strings().noInternetConnection);
      } else {
        throw (Strings().somethingWentWrongPlTryAgain);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> makePostRequest(String url,
      {param,
      required Options options,
      required Map<String, dynamic> data}) async {
    try {
      final response = await dio
          .post(url, queryParameters: param, options: options, data: data)
          .timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        kPrint(response);
        if (response.data['status'] == 'success') {
          kPrint(response.data['message']);
          return response.data['data'];
        } else {
          throw (response.data['message']);
        }
      }
    } on DioException catch (e) {
      kPrint(e.type);
      kPrint(e.message);
      if (e.type == DioExceptionType.unknown) {
        throw (Strings().somethingWentWrongPlTryAgain);
      } else if (e.type == DioExceptionType.connectionTimeout) {
        throw (Strings().requestTimeOut);
      } else if (e.type == DioExceptionType.connectionError) {
        throw (Strings().noInternetConnection);
      } else if (e.response?.statusCode == 302) {
        throw ('302');
      } else {
        throw (Strings().somethingWentWrongPlTryAgain);
      }
    } catch (e) {
      rethrow;
    }
  }
}
