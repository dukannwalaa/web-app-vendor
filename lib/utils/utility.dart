
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:vendor/bindings/login.dart';
import 'package:vendor/ui/login.dart';
import 'package:vendor/utils/cache_manager.dart';
import 'package:vendor/utils/string_constant.dart';
import 'package:vendor/utils/strings.dart';

String getAssetFile({name, type = 'svg', subFolder}) {
  return subFolder != null
      ? 'assets/$type/$subFolder/$name.$type'
      : 'assets/$type/$name.$type';
}

void hideKeyboard() {
  FocusManager.instance.primaryFocus?.unfocus();
}

deviceHeight() => Device.height;

deviceWidth() => Device.width;

kPrint(message) {
  if (kDebugMode) {
    print('${Get.currentRoute}==>Print=======>$message');
  }
}

logout() {

  CacheManager().writeString(key: CacheManager.vendorId, value: null);

  CacheManager().writeString(key: CacheManager.vendorModel, value: null);
  CacheManager().writeString(key: CacheManager.selectedVendorId, value: null);
  Get.offAll(const Login(), binding: LoginBinding());
}

String getOrderStatusName(String status) {
  switch (status) {
    case StringConstant.orderAwaitingConfirmation:
      return Strings().orderAwaitingConfirmation;
    case StringConstant.orderInProcess:
      return Strings().orderInProcess;
    case StringConstant.orderCompleted:
      return Strings().orderCompleted;
    case StringConstant.orderReject:
      return Strings().orderReject;
    case StringConstant.orderPacked:
      return Strings().orderPacked;
    case StringConstant.orderDelayed:
      return Strings().orderDelayed;
    case StringConstant.orderOutForDelivery:
      return Strings().orderOutForDelivery;
    case StringConstant.orderPending:
      return Strings().orderPending;
    case StringConstant.orderActive:
      return Strings().orderActive;
    case StringConstant.orderCancelled:
      return Strings().orderCancelled;
    default:
      return '';
  }
}
