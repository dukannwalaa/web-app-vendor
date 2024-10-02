import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:vendor/common/constant/color.dart';

const String fontName = 'Roboto';

TextStyle lightTextStyle({fontSize, textColor, bool strikeThrough = false}) {
  return GoogleFonts.getFont(fontName,
      fontWeight: FontWeight.w300,
      fontSize: fontSize,
      color: textColor,
      textStyle: strikeThrough
          ? const TextStyle(decoration: TextDecoration.lineThrough)
          : null);
}

TextStyle regularTextStyle({fontSize, textColor, textDecoration}) {
  return GoogleFonts.getFont(fontName,
      fontWeight: FontWeight.w400,
      fontSize: fontSize,
      color: textColor,
      textStyle: TextStyle(decoration: textDecoration));
}

TextStyle mediumTextStyle({fontSize, textColor, decoration}) {
  return GoogleFonts.getFont(fontName,
      fontWeight: FontWeight.w500,
      fontSize: fontSize,
      color: textColor,
      decoration: decoration);
}

TextStyle semiBoldTextStyle({fontSize, textColor}) {
  return GoogleFonts.getFont(
    fontName,
    fontWeight: FontWeight.w600,
    fontSize: fontSize,
    color: textColor,
  );
}

TextStyle boldTextStyle({fontSize, textColor, textDecoration}) {
  return GoogleFonts.getFont(fontName,
      fontWeight: FontWeight.w700,
      fontSize: fontSize,
      color: textColor,
      textStyle: TextStyle(decoration: textDecoration));
}

Widget regularDynamic(text,
    {textColor, maxLines, textSize, textDecoration, textAlign}) {
  return Text(
    text.toString(),
    maxLines: maxLines,
    textAlign: textAlign,
    style: regularTextStyle(
        fontSize: textSize,
        textColor: textColor ?? MyColor.black,
        textDecoration: textDecoration),
  );
}

Widget lightDynamic(text,
    {textColor, maxLines, textSize, bool strikeThrough = false}) {
  return Text(
    text.toString(),
    maxLines: maxLines,
    style: lightTextStyle(
        fontSize: textSize,
        textColor: textColor ?? MyColor.black,
        strikeThrough: strikeThrough),
  );
}

Widget regular20(text, {textColor, maxLines}) {
  return Text(
    text.toString(),
    maxLines: maxLines,
    style: regularTextStyle(
        fontSize: 20.sp, textColor: textColor ?? MyColor.black),
  );
}

Widget regular18(text, {textColor, maxLines}) {
  return Text(
    text.toString(),
    maxLines: maxLines,
    style: regularTextStyle(
        fontSize: 18.sp, textColor: textColor ?? MyColor.black),
  );
}

Widget regular16(text, {textColor, maxLines}) {
  return Text(
    text.toString(),
    maxLines: maxLines,
    style: regularTextStyle(
        fontSize: 16.sp, textColor: textColor ?? MyColor.black),
  );
}

Widget regular15(text, {textColor, maxLines}) {
  return Text(
    text.toString(),
    maxLines: maxLines,
    style: regularTextStyle(
        fontSize: 15.sp, textColor: textColor ?? MyColor.black),
  );
}

Widget medium20(text, {textColor, maxLines}) {
  return Text(
    text.toString(),
    maxLines: maxLines,
    style: mediumTextStyle(
        fontSize: 20.sp, textColor: textColor ?? MyColor.black),
  );
}

Widget mediumDynamic(text,
    {textColor, maxLines, textSize, decoration, textAlign}) {
  return Text(
    text.toString(),
    textAlign: textAlign ?? TextAlign.center,
    maxLines: maxLines,
    style: mediumTextStyle(
        fontSize: textSize ?? 20.sp,
        textColor: textColor ?? MyColor.black,
        decoration: decoration),
  );
}

Widget medium18(text, {textColor, maxLines}) {
  return Text(
    text.toString(),
    style: mediumTextStyle(
        fontSize: 18.sp, textColor: textColor ?? MyColor.black),
  );
}

Widget medium16(text, {textColor, maxLines}) {
  return Text(
    text.toString(),
    style: mediumTextStyle(
        fontSize: 16.sp, textColor: textColor ?? MyColor.black),
  );
}

Widget medium15(text, {textColor, maxLines}) {
  return Text(
    text.toString(),
    style: mediumTextStyle(
        fontSize: 15.sp, textColor: textColor ?? MyColor.black),
  );
}

Widget semiBold20({text, textColor, maxLines}) {
  return Text(
    text,
    maxLines: maxLines,
    style: semiBoldTextStyle(
        fontSize: 20.sp, textColor: textColor ?? MyColor.white),
  );
}

Widget boldDynamic(text,
    {textColor, maxLines, textSize, textDecoration, textAlign}) {
  return Text(
    text.toString(),
    textAlign: textAlign ?? TextAlign.left,
    maxLines: maxLines,
    style: boldTextStyle(
        fontSize: textSize,
        textColor: textColor ?? MyColor.black,
        textDecoration: textDecoration),
  );
}

Widget bold20(text, {textColor, maxLines}) {
  return Text(
    text.toString(),
    maxLines: maxLines,
    style: boldTextStyle(
        fontSize: 20.sp, textColor: textColor ?? MyColor.white),
  );
}

Widget bold18(text, {textColor, maxLines}) {
  return Text(
    text.toString(),
    maxLines: maxLines,
    style: boldTextStyle(
        fontSize: 18.sp, textColor: textColor ?? MyColor.black),
  );
}
