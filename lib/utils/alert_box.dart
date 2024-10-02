
import 'package:get/get.dart';
import 'package:vendor/common/constant/color.dart';
import 'package:vendor/common/widgets/texts.dart';

Future alertBoxConfirmation(
    {String? title,
    String? middleText,
    String? textConfirm,
    required Function yes}) {
  return Get.defaultDialog(
    confirmTextColor: MyColor.white,
    cancelTextColor: MyColor.black,
    backgroundColor: MyColor.white,
    title: title ?? "Confirm Action",
    titleStyle: boldTextStyle(),
    middleText: middleText ?? "Are you sure you want to proceed?",
    middleTextStyle: regularTextStyle(),
    textConfirm: textConfirm ?? "Yes",
    textCancel: "No",
    onConfirm: () {
      yes();
      Get.back(); // Close the dialog
    },
    onCancel: () {

    },
  );
}
