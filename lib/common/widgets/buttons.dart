
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:vendor/common/constant/color.dart';
import 'package:vendor/common/widgets/texts.dart';

Widget flatButton(text, onClick,
    {fontSize,
    textColor,
    bgColor,
    width,
    height,
    borderRadius,
    borderColor,
    borderWidth}) {
  return  SizedBox(
    width: width,
    height: height,
    child: ElevatedButton(
      onPressed: onClick,
      style: ElevatedButton.styleFrom(
          backgroundColor: bgColor ?? MyColor.black,
          elevation: 1.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 1)),
          side: BorderSide(
              color: borderColor ?? MyColor.transparent,
              width: borderWidth ?? 1),
          textStyle: mediumTextStyle(
              textColor: textColor ?? MyColor.black,
              fontSize: fontSize ?? 18.sp)),
      child: Center(
        child: regularDynamic(
            textSize: fontSize,
            text,
            textColor: textColor ?? MyColor.white),
      ),
    ),
  );
}
Widget flatButtonMedium(text, onClick,
    {fontSize,
      textColor,
      bgColor,
      width,
      height,
      borderRadius,
      borderColor,
      borderWidth}) {
  return  SizedBox(
    width: width,
    height: height,
    child: ElevatedButton(
      onPressed: onClick,
      style: ElevatedButton.styleFrom(
          backgroundColor: bgColor ?? MyColor.black,
          elevation: 1.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 1)),
          side: BorderSide(
              color: borderColor ?? MyColor.transparent,
              width: borderWidth ?? 1),
          textStyle: mediumTextStyle(
              textColor: textColor ?? MyColor.black,
              fontSize: fontSize ?? 18.sp)),
      child: Center(
        child: mediumDynamic(
            textSize: fontSize,
            text,
            textColor: textColor ?? MyColor.white),
      ),
    ),
  );
}
Widget flatButtonMedium2(text, onClick,
    {fontSize, textColor, bgColor, width, height}) {
  return Card(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(1.w))),
    color: bgColor,
    child: Container(
      padding: EdgeInsets.all(3.w),
      width: width,
      height: height,
      child: Center(
        child: InkWell(
          onTap: onClick,
          child: mediumDynamic(text, textColor: textColor, textSize: fontSize),
        ),
      ),
    ),
  );
}

Widget backArrowButton({size,color}) {
  return InkWell(
    onTap: () => {Get.back()},
    child: Icon(
      size: size,
      Icons.arrow_back,
      color: color ??MyColor.white,
    ),
  );
}
