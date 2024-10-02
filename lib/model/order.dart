import 'package:floor/floor.dart';
import 'package:vendor/utils/type_converter.dart';

@Entity(tableName: 'DWOrder')
class Order {
  @primaryKey
  String? orderId;
  String? userId;
  List<Products>? products;
  double? subTotal;
  double? deliveryCharge;
  double? discount;
  double? totalAmount;
  bool? cod;
  int? createdAt;
  String? orderStatus;
  String? name;
  String? address;
  String? mobile;
  int? expectedDeliveryDate;
  int? deliveredDate;
  String? notes;
  int? updatedAt;
  String? vendorId;
  int? platformFee;

  Order(
      {this.orderId,
      this.userId,
      this.products,
      this.subTotal,
      this.deliveryCharge,
      this.discount,
      this.totalAmount,
      this.cod,
      this.createdAt,
      this.orderStatus,
      this.name,
      this.mobile,
      this.address,
      this.expectedDeliveryDate,
      this.deliveredDate,
      this.notes,
      this.updatedAt,
      this.vendorId,
      this.platformFee,
      });

  Order.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    userId = json['userId'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((element) => products!.add(
            Products.fromJson(element),
          ));
    }
    subTotal = toDouble(json['subTotal']);
    deliveryCharge = toDouble(json['deliveryCharge']);
    discount = toDouble(json['discount']);
    totalAmount = toDouble(json['totalAmount']);
    cod = json['cod'];
    createdAt = toInt(json['createdAt']);
    orderStatus = json['orderStatus'];
    name = json['name'].toString();
    mobile = json['mobile'].toString();
    address = json['address'].toString();
    expectedDeliveryDate = toInt(json['expectedDeliveryDate']);
    deliveredDate = toInt(json['deliveryDate']);
    notes = json['notes'];
    updatedAt = json['updatedAt'];
    vendorId = json['vendorId'];
    platformFee = json['platformFee'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['orderId'] = orderId;
    data['userId'] = userId;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    data['subTotal'] = subTotal;
    data['deliveryCharge'] = deliveryCharge;
    data['discount'] = discount;
    data['totalAmount'] = totalAmount;
    data['cod'] = cod;
    data['createdAt'] = createdAt;
    data['orderStatus'] = orderStatus;
    data['name'] = name;
    data['mobile'] = mobile;
    data['address'] = address;
    data['deliveryDate'] = expectedDeliveryDate;
    data['deliveredDate'] = deliveredDate;
    data['notes'] = notes;
    data['updatedAt'] = updatedAt;
    data['vendorId'] = vendorId;
    data['platformFee'] = platformFee;
    return data;
  }
}

class Products {
  String? productId;
  String? productName;
  String? image;
  String? offerPrice;
  String? mrp;
  int? qty;
  int? gst;

  Products(
      {this.productId,
      this.productName,
      this.image,
      this.offerPrice,
      this.mrp,
      this.gst,
      this.qty});

  Products.fromJson(Map<String, dynamic> json) {
    productId = json['id'].toString();
    productName = json['name'];
    image = json['image'];
    offerPrice = json['offerPrice'];
    mrp = json['mrp'];
    gst = json['gst'];
    qty = json['qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = productId;
    data['name'] = productName;
    data['image'] = image;
    data['offerPrice'] = offerPrice;
    data['mrp'] = mrp;
    data['gst'] = gst;
    data['qty'] = qty;
    return data;
  }
}
