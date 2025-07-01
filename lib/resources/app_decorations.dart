import 'package:flutter/material.dart';
import 'package:memo_ri_app/resources/localization/app_localization.dart';
import 'package:memo_ri_app/resources/resources.dart';
import 'package:sizer/sizer.dart';

class Decorations {
  InputDecoration inputDecorationWithHint(
      {required String hintText, Widget? suffixIcon}) {
    return InputDecoration(
      fillColor: R.appColors.white,
      filled: true,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: R.appColors.borderColor,
            width: 1,
          )),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: R.appColors.red,
            width: 1,
          )),
      disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: R.appColors.primaryColor,
            width: 1,
          )),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: R.appColors.red,
            width: 1,
          )),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: R.appColors.borderColor,
            width: 1,
          )),
      suffixIcon: suffixIcon,
      hintText: hintText.L(),
      errorStyle:
          R.textStyles.urbanist(fontSize: 14.sp, color: R.appColors.red),
      hintStyle:
          R.textStyles.urbanist(fontSize: 16.sp, color: R.appColors.hintColor),
    );
  }

  BoxDecoration generalDecoration(
      {required double radius, required Color backgroundColor}) {
    return BoxDecoration(
        color: backgroundColor, borderRadius: BorderRadius.circular(radius));
  }

  BoxDecoration bottomSheetDecor(
      {Color? backGroundColor, double? borderRadius}) {
    return BoxDecoration(
        color: backGroundColor ?? R.appColors.white,
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(borderRadius ?? 30)));
  }

  ButtonStyle iconButtonDeco({Color? backgroundColor}) {
    return ButtonStyle(
      shape: WidgetStatePropertyAll(CircleBorder()),
      backgroundColor:
          WidgetStatePropertyAll(backgroundColor ?? R.appColors.white),
    );
  }

  BoxDecoration shadowDecor({
    Color? backGroundColor,
    Color? shadowColor,
    double? borderRadius,
    double? spreadRadius,
    double? blurRadius,
  }) {
    return BoxDecoration(
        boxShadow: [
          BoxShadow(
              color:
                  shadowColor ?? R.appColors.shadowColor.withValues(alpha: .25),
              spreadRadius: spreadRadius ?? 4,
              blurRadius: blurRadius ?? 5.8),
        ],
        color: backGroundColor ?? R.appColors.white,
        borderRadius: BorderRadius.circular(borderRadius ?? 12));
  }
}
