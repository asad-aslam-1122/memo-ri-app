import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memo_ri_app/resources/localization/app_localization.dart';
import 'package:sizer/sizer.dart';

import '../../resources/resources.dart';
import '../image_picker/image_widget.dart';

class GlobalWidgets {
  static Widget circleContainer({required double width}) {
    return Container(
      height: width,
      width: width,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(colors: [
            R.appColors.white.withValues(alpha: 0.02),
            R.appColors.white.withValues(alpha: 0.02),
          ]),
          boxShadow: [
            BoxShadow(
              color: R.appColors.white.withValues(alpha: 0.26),
              spreadRadius: 30,
              blurRadius: 20,
            )
          ]),
    );
  }

  static Widget bottomSheetBar({double? width}) {
    return Container(
      width: width ?? 20.w,
      height: 4,
      margin: EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: R.appColors.bottomSheetColor,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }

  static Widget labelText(
      {required String labelText,
      AlignmentGeometry? alignment,
      FontWeight? fontWeight,
      double? fontSize}) {
    return Align(
      alignment: alignment ?? Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          labelText,
          style: R.textStyles.urbanist(
            fontSize: fontSize ?? 15.sp,
            fontWeight: fontWeight ?? FontWeight.w500,
          ),
        ),
      ),
    );
  }

  static PreferredSize bottomSheetAppBar(
      {double? height,
      bool? hideShadow,
      bool? showBackArrowBtn,
      AlignmentGeometry? backArrowAlign}) {
    return PreferredSize(
        preferredSize: Size(100.w, height ?? 16.h),
        child: Stack(
          children: [
            if (hideShadow ?? false)
              Positioned(
                left: 6.w,
                top: 4.h,
                child: GlobalWidgets.circleContainer(width: 22.w),
              ),
            if (showBackArrowBtn ?? false)
              Align(
                alignment: backArrowAlign ?? Alignment.topLeft,
                child: IconButton(
                    onPressed: () => Get.back(),
                    icon: Icon(
                      Icons.arrow_back,
                      color: R.appColors.white,
                    )),
              ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ImageWidget(
                    height: 22.w,
                    width: 55.w,
                    isFile: true,
                    showCameraIcon: false,
                    assetImagePath: R.appImages.appLogo,
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ],
        ));
  }

  static Widget smallBtn(
      {required VoidCallback onPressed,
      required String title,
      FontWeight? fontWeight,
      Color? backgroundColor,
      double? height,
      Color? textColor}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height ?? null,
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: R.decoration.generalDecoration(
            radius: 10,
            backgroundColor: backgroundColor ?? R.appColors.primaryColor),
        child: Center(
          child: Text(
            title.L(),
            style: R.textStyles.urbanist(
                fontWeight: fontWeight ?? FontWeight.w500,
                fontSize: 14.sp,
                color: textColor ?? R.appColors.white),
          ),
        ),
      ),
    );
  }

  static simpleAppBar({required String title}) {
    return AppBar(
      backgroundColor: R.appColors.primaryColor,
      surfaceTintColor: R.appColors.primaryColor,
      centerTitle: true,
      title: Text(
        title,
        style: R.textStyles.urbanist(
            fontWeight: FontWeight.w500,
            fontSize: 19.sp,
            color: R.appColors.white),
      ),
    );
  }

  static Widget resolutionWidget(
      {required String title,
      required VoidCallback onTab,
      Color? backgroundColor}) {
    return GestureDetector(
      onTap: onTab,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 3) +
            EdgeInsets.only(left: 8, right: 2),
        decoration: R.decoration.generalDecoration(
            radius: 16,
            backgroundColor: backgroundColor ?? R.appColors.primaryColor),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: R.textStyles.urbanist(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  color: R.appColors.white),
            ),
            Icon(
              Icons.arrow_drop_down_outlined,
              color: R.appColors.white,
              size: 20,
            )
          ],
        ),
      ),
    );
  }

  static Widget cateAndAlbumItems(
      {required String imagePath,
      required String title,
      required bool useAsset}) {
    return Column(
      children: [
        Container(
          height: 24.w,
          width: 24.w,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: useAsset
                      ? AssetImage(imagePath)
                      : FileImage(File(imagePath)),
                  fit: BoxFit.cover),
              boxShadow: [
                BoxShadow(
                    color: R.appColors.imageShadowColor.withValues(alpha: 0.2),
                    spreadRadius: 1,
                    blurRadius: 2)
              ],
              color: R.appColors.transparent,
              borderRadius: BorderRadius.circular(10)),
        ),
        SizedBox(
          height: 4,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: R.textStyles
                .urbanist(fontSize: 14.sp, fontWeight: FontWeight.w600),
          ),
        )
      ],
    );
  }
}
