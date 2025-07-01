import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memo_ri_app/resources/resources.dart';
import 'package:sizer/sizer.dart';

class AppTextStyles {
  TextStyle urbanist(
      {TextDecoration? textDecoration,
      Color? color,
      double? fontSize,
      bool dontGiveTextHeight = false,
      FontWeight? fontWeight,
      double? letterSpacing}) {
    return GoogleFonts.urbanist(
      fontSize: fontSize ?? 14.sp,
      color: color ?? R.appColors.black,
      height: dontGiveTextHeight ? null : 1.5,
      fontWeight: fontWeight ?? FontWeight.w400,
      letterSpacing: letterSpacing ?? 0,
      decoration: textDecoration ?? TextDecoration.none,
    );
  }

  TextStyle poppins(
      {TextDecoration? textDecoration,
      Color? color,
      double? fontSize,
      bool dontGiveTextHeight = false,
      FontWeight? fontWeight,
      double? letterSpacing}) {
    return GoogleFonts.poppins(
      fontSize: fontSize ?? 14.sp,
      color: color ?? R.appColors.black,
      height: dontGiveTextHeight ? null : 1.5,
      fontWeight: fontWeight ?? FontWeight.w400,
      letterSpacing: letterSpacing ?? 0,
      decoration: textDecoration ?? TextDecoration.none,
    );
  }

  TextStyle zenDots(
      {TextDecoration? textDecoration,
      Color? color,
      double? fontSize,
      FontWeight? fontWeight,
      double? letterSpacing}) {
    return GoogleFonts.zenDots(
      fontSize: fontSize ?? 14.sp,
      color: color ?? R.appColors.black,
      fontWeight: fontWeight ?? FontWeight.w400,
      letterSpacing: letterSpacing ?? 0,
      decoration: textDecoration ?? TextDecoration.none,
    );
  }
}
