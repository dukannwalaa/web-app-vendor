
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:vendor/common/constant/color.dart';
import 'package:vendor/common/widgets/texts.dart';
import 'package:vendor/utils/strings.dart';
import 'package:vendor/utils/utility.dart';

Widget phoneNumberTextField(
    {textController, fontSize, textColor, enable, onSubmit, onChange}) {
  return TextField(
    onChanged: onChange,
    onTapOutside: (e) => hideKeyboard(),
    onSubmitted: onSubmit,
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: MyColor.black,
          width: 1,
          style: BorderStyle.solid,
        ),
      ),
      labelText: Strings().enterNumber,
      prefixIcon: const Icon(Icons.phone),
    ),
    maxLength: 10,
    maxLines: 1,
    keyboardType: TextInputType.phone,
    enabled: enable ?? true,
    style: mediumTextStyle(
        fontSize: fontSize ?? 20.sp,
        textColor: textColor ?? MyColor.black),
    controller: textController,
  );
}

Widget otpTextField(
    {textController, fontSize, textColor, enable, onSubmit, onChange}) {
  return TextField(
    textAlign: TextAlign.center,
    onChanged: onChange,
    onTapOutside: (e) => hideKeyboard(),
    onSubmitted: onSubmit,
    decoration: InputDecoration(
      isDense: true,
      contentPadding: EdgeInsets.symmetric(vertical: 2.h),
      counterText: '',
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: MyColor.black,
          width: 1,
          style: BorderStyle.solid,
        ),
      ),
    ),
    maxLength: 6,
    maxLines: 1,
    keyboardType: TextInputType.number,
    inputFormatters: <TextInputFormatter>[
      FilteringTextInputFormatter.digitsOnly
    ],
    // Only numbers can be entered
    enabled: enable ?? true,
    style: mediumTextStyle(textColor: textColor, fontSize: fontSize),
    controller: textController,
  );
}

Widget searchTextField(
    {textController, fontSize, textColor, enable, onSubmit, onChange,margin}) {
  return Container(
    height: 6.h,
    margin: margin??EdgeInsets.symmetric(horizontal: 5.w),
    decoration: BoxDecoration(
        color: MyColor.white,
        borderRadius: BorderRadius.circular(3.w),
        ),
    child: TextField(
      onChanged: onChange,
      onTapOutside: (e) => hideKeyboard(),
      onSubmitted: onSubmit,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 0),
        hintText: Strings().searchHint,
        hintStyle: regularTextStyle(
            fontSize: 15.sp, textColor: MyColor.black0C.withOpacity(.6)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            50.w,
          ),
          borderSide: BorderSide.none,
        ),
        prefixIcon: Icon(Icons.search,color: MyColor.black,size: 5.w,),
      ),
      maxLines: 1,
      keyboardType: TextInputType.text,
      enabled: enable ?? true,
      style: mediumTextStyle(
          fontSize: fontSize ?? 18.sp,
          textColor: textColor ?? MyColor.black),
      controller: textController,
    ),
  );
}


  Widget textField(
    {textController, fontSize, textColor, enable, onSubmit, onChange,labelText}) {
  return TextField(
    onChanged: onChange,
    onTapOutside: (e) => hideKeyboard(),
    onSubmitted: onSubmit,
    decoration:  InputDecoration(
      label: lightDynamic(labelText,textSize: 15.sp),
    ),
    maxLines: 1,
    keyboardType: TextInputType.name,
    enabled: enable ?? true,
    style: mediumTextStyle(
        fontSize: fontSize ?? 16.sp,
        textColor: textColor ?? MyColor.black),
    controller: textController,
  );
}

Widget phoneNumberTextFieldWithoutBorder(
    {textController, fontSize, textColor, enable, onSubmit, onChange,labelText}) {
  return TextField(
    onChanged: onChange,
    onTapOutside: (e) => hideKeyboard(),
    onSubmitted: onSubmit,
    decoration: InputDecoration(
      label: regularDynamic(labelText,textSize: 14.sp),
    ),
    maxLength: 10,
    maxLines: 1,
    keyboardType: TextInputType.phone,
    enabled: enable ?? true,
    style: mediumTextStyle(
        fontSize: fontSize ?? 15.sp,
        textColor: textColor ?? MyColor.black),
    controller: textController,
  );
}

Widget pinCodeTextFieldWithoutBorder(
    {textController, fontSize, textColor, enable, onSubmit, onChange,labelText}) {
  return TextField(
    onChanged: onChange,
    onTapOutside: (e) => hideKeyboard(),
    onSubmitted: onSubmit,
    decoration: InputDecoration(
      label: regularDynamic(labelText,textSize: 14.sp),
    ),
    // maxLength: 6,
    maxLines: 1,
    keyboardType: TextInputType.number,
    enabled: enable ?? true,
    style: mediumTextStyle(
        fontSize: fontSize ?? 15.sp,
        textColor: textColor ?? MyColor.black),
    controller: textController,
  );
}
