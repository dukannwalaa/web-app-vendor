import 'dart:convert';
import 'package:floor/floor.dart';
import 'package:vendor/model/order.dart';

class StringListConverter extends TypeConverter<List<String>?, String> {
  @override
  List<String> decode(String? databaseValue) {
    List<String> result = [];
    if (databaseValue != 'null') {
      List<dynamic> rellyAStringList = jsonDecode(databaseValue ?? '');
      for (String string in rellyAStringList) {
        result.add(string);
      }
    }
    return result;
  }

  @override
  String encode(List<String>? value) {
    return json.encode(value);
  }
}

class SummaryTypeConverter extends TypeConverter<List<Products>?, String> {
  @override
  List<Products>? decode(String databaseValue) {
    final jsonFile = json.decode(databaseValue);
    List<Products> finances = [];
    finances = (jsonFile['summary'] as List<dynamic>)
        .map(
          (e) => Products.fromJson(e),
        )
        .toList();

    return finances;
  }

  @override
  String encode(List<Products>? value) {
    final data = <String, dynamic>{};
    data.addAll({'summary': value});
    return json.encode(data);
  }
}

int doubleStringToInt(String? doubleString) {
  double doubleValue = double.parse(doubleString ?? '0');
  return doubleValue.round();
}

double intStringToDouble(String? intString) {
  int intValue = int.parse(intString ?? '0');
  return intValue.toDouble();
}

double toDouble(dynamic value) {
  if (value is int) {
    return value.toDouble();
  } else if (value is num) {
    return value.toDouble();
  } else if (value is String) {
    return value.isEmpty ? 0.0 : double.parse(value);
  } else if (value == null) {
    return 0.0;
  } else {
    return value;
  }
}

int? toInt(dynamic value) {
  if (value is double) {
    return value.toInt();
  } else if (value is num) {
    return value.toInt();
  } else if (value is String) {
    return value.isEmpty ? null : int.parse(value);
  } else {
    return value;
  }
}
